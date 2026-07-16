import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart' as wrtc;
import '../models/rtc_config.dart';
import 'rtc_engine_interface.dart';
import 'signaling_service.dart';

/// Real, functional, zero-license-cost WebRTC engine.
///
/// Topology: full **mesh** — every participant opens one RTCPeerConnection
/// directly to every other participant. No media server, so no per-minute
/// or per-GB bill from a third party; the only ongoing cost is TURN relay
/// bandwidth if/when a call can't go peer-to-peer directly (see
/// WEBRTC_SETUP.md). Mesh scales cleanly up to roughly 6-8 simultaneous
/// video participants — past that each device's upload bandwidth becomes
/// the bottleneck. Swapping this for an SFU later means writing a new
/// class behind the same [RtcEngineInterface]; nothing above this layer
/// (UI, controller) needs to change.
///
/// Signaling is [SignalingService] (Supabase Realtime). Glare is avoided
/// with the classic "lower peer id always offers first" rule instead of a
/// full perfect-negotiation implementation, which is enough for a mesh
/// where renegotiation is rare (mute/video toggles use track.enabled, not
/// renegotiation; only screen-share does a track replace, which doesn't
/// require a new offer either).
class WebRtcService implements RtcEngineInterface {
  RtcConfig? _config;
  SignalingService? _signaling;

  bool _joined = false;
  bool _screenSharing = false;
  int _localUid = 0;
  String _localPeerId = '';

  wrtc.MediaStream? _localStream;
  wrtc.MediaStream? _screenStream;
  final wrtc.RTCVideoRenderer _localRenderer = wrtc.RTCVideoRenderer();
  bool _localRendererReady = false;

  final Map<String, _Peer> _peers = {}; // peerId -> Peer
  final Map<int, String> _uidToPeerId = {};

  StreamSubscription? _peerJoinedSub, _peerLeftSub, _offerSub, _answerSub, _candSub;
  Timer? _statsTimer;
  final _events = StreamController<RtcEvent>.broadcast();

  @override
  RtcBackend get backend => RtcBackend.webrtc;

  @override
  bool get isJoined => _joined;

  @override
  Stream<RtcEvent> get events => _events.stream;

  Map<String, dynamic> get _rtcConfiguration => {
    'iceServers': _config!.iceServers,
    'sdpSemantics': 'unified-plan',
  };

  // ── Lifecycle ────────────────────────────────────────────────────────

  @override
  Future<void> initialize(RtcConfig config) async {
    _config = config;
    await _localRenderer.initialize();
    _localRendererReady = true;
  }

  @override
  Future<void> joinChannel({
    required String channelId,
    required String token,
    required int uid,
  }) async {
    _localUid = uid;
    _localPeerId = uid.toString();

    // 1. Grab local mic + camera. On web this triggers the browser
    //    permission prompt; on Android/iOS it needs the manifest/Info.plist
    //    entries described in WEBRTC_SETUP.md.
    _localStream ??= await wrtc.navigator.mediaDevices.getUserMedia({
      'audio': true,
      'video': {
        'facingMode': 'user',
        'width': {'ideal': 1280},
        'height': {'ideal': 720},
      },
    });
    _localRenderer.srcObject = _localStream;

    // 2. Connect signaling and wire events before announcing presence,
    //    so we don't miss any peer that's already in the room.
    _signaling = SignalingService(roomId: channelId, localPeerId: _localPeerId);
    _peerJoinedSub = _signaling!.onPeerJoined.listen(_onPeerJoined);
    _peerLeftSub = _signaling!.onPeerLeft.listen(_onPeerLeft);
    _offerSub = _signaling!.onOffer.listen((r) => _onOffer(r.$1, r.$2));
    _answerSub = _signaling!.onAnswer.listen((r) => _onAnswer(r.$1, r.$2));
    _candSub = _signaling!.onCandidate.listen((r) => _onCandidate(r.$1, r.$2));
    await _signaling!.connect();

    _joined = true;
    _events.add(RtcEvent(type: RtcEventType.localJoined, channelId: channelId));

    _statsTimer?.cancel();
    _statsTimer = Timer.periodic(const Duration(seconds: 2), (_) => _pollStats());
  }

  @override
  Future<void> leaveChannel() async {
    _statsTimer?.cancel();
    for (final peerId in _peers.keys.toList()) {
      _teardownPeer(peerId, emit: false);
    }
    await _peerJoinedSub?.cancel();
    await _peerLeftSub?.cancel();
    await _offerSub?.cancel();
    await _answerSub?.cancel();
    await _candSub?.cancel();
    await _signaling?.dispose();
    _signaling = null;

    if (_screenSharing) await stopScreenShare();
    await _localStream?.dispose();
    _localStream = null;
    _localRenderer.srcObject = null;

    final wasChannel = _config?.channelId;
    _joined = false;
    _events.add(RtcEvent(type: RtcEventType.localLeft, channelId: wasChannel));
  }

  @override
  Future<void> dispose() async {
    if (_joined) await leaveChannel();
    await _localRenderer.dispose();
    await _events.close();
  }

  // ── Peer connection management (mesh) ───────────────────────────────

  Future<void> _onPeerJoined(String peerId) async {
    if (_peers.containsKey(peerId)) return;
    final uid = int.tryParse(peerId) ?? peerId.hashCode;
    final peer = _Peer(peerId: peerId, uid: uid);
    _peers[peerId] = peer;
    _uidToPeerId[uid] = peerId;

    await peer.renderer.initialize();
    peer.rendererReady = true;

    await _createPeerConnection(peer);

    // Deterministic initiator rule avoids both sides sending an offer.
    final weInitiate = _localPeerId.compareTo(peerId) < 0;
    if (weInitiate) {
      final dc = await peer.pc!.createDataChannel(
        'control',
        wrtc.RTCDataChannelInit()..ordered = true,
      );
      _wireDataChannel(peer, dc);
      final offer = await peer.pc!.createOffer();
      await peer.pc!.setLocalDescription(offer);
      await _signaling!.sendOffer(peerId, {'type': offer.type, 'sdp': offer.sdp});
    }
  }

  void _onPeerLeft(String peerId) => _teardownPeer(peerId, emit: true);

  Future<void> _createPeerConnection(_Peer peer) async {
    peer.pc = await wrtc.createPeerConnection(_rtcConfiguration);

    for (final track in _localStream!.getTracks()) {
      await peer.pc!.addTrack(track, _localStream!);
    }

    peer.pc!.onTrack = (event) {
      if (event.streams.isEmpty) return;
      peer.renderer.srcObject = event.streams.first;
      _events.add(RtcEvent(type: RtcEventType.userJoined, uid: peer.uid));
    };

    peer.pc!.onIceCandidate = (c) {
      if (c.candidate == null) return;
      _signaling?.sendCandidate(peer.peerId, {
        'candidate': c.candidate,
        'sdpMid': c.sdpMid,
        'sdpMLineIndex': c.sdpMLineIndex,
      });
    };

    peer.pc!.onDataChannel = (channel) => _wireDataChannel(peer, channel);

    peer.pc!.onConnectionState = (state) {
      _events.add(RtcEvent(
        type: RtcEventType.connectionStateChanged,
        uid: peer.uid,
        data: {'state': state.toString()},
      ));
      if (state == wrtc.RTCPeerConnectionState.RTCPeerConnectionStateFailed) {
        _teardownPeer(peer.peerId, emit: true);
      }
    };
  }

  void _wireDataChannel(_Peer peer, wrtc.RTCDataChannel channel) {
    peer.dataChannel = channel;
    channel.onMessage = (msg) {
      final bytes = msg.isBinary
          ? msg.binary
          : Uint8List.fromList(utf8.encode(msg.text));
      _handleIncomingBytes(peer, bytes);
    };
  }

  /// State (mute/video) and control-request-to-self-mute messages are
  /// distinguished from opaque app payloads (chat/remote-control) by a
  /// leading marker key, then re-emitted or acted on directly.
  void _handleIncomingBytes(_Peer peer, Uint8List bytes) {
    try {
      final decoded = jsonDecode(utf8.decode(bytes));
      if (decoded is Map) {
        if (decoded['_state'] == true) {
          if (decoded.containsKey('audioMuted')) {
            _events.add(RtcEvent(
              type: RtcEventType.userMuteAudio,
              uid: peer.uid,
              data: {'muted': decoded['audioMuted']},
            ));
          }
          if (decoded.containsKey('videoMuted')) {
            _events.add(RtcEvent(
              type: RtcEventType.userMuteVideo,
              uid: peer.uid,
              data: {'muted': decoded['videoMuted']},
            ));
          }
          if (decoded.containsKey('screenSharing')) {
            _events.add(RtcEvent(
              type: decoded['screenSharing'] == true
                  ? RtcEventType.screenShareStarted
                  : RtcEventType.screenShareStopped,
              uid: peer.uid,
            ));
          }
          return;
        }
        if (decoded['_muteRequest'] == true) {
          // A host asked us (running on the muted user's own device) to
          // mute ourselves — mirrors how Zoom's "mute all" really works,
          // since in a P2P mesh no one else can silence our mic directly.
          muteLocalAudio(decoded['audio'] == true);
          return;
        }
      }
    } catch (_) {
      // Not JSON — fall through, treat as opaque binary payload below.
    }
    _events.add(RtcEvent(
      type: RtcEventType.dataMessageReceived,
      uid: peer.uid,
      data: {'bytes': bytes},
    ));
  }

  Future<void> _onOffer(String peerId, Map<String, dynamic> sdpMap) async {
    var peer = _peers[peerId];
    if (peer == null) {
      final uid = int.tryParse(peerId) ?? peerId.hashCode;
      peer = _Peer(peerId: peerId, uid: uid);
      _peers[peerId] = peer;
      _uidToPeerId[uid] = peerId;
      await peer.renderer.initialize();
      peer.rendererReady = true;
    }
    if (peer.pc == null) await _createPeerConnection(peer);

    await peer.pc!.setRemoteDescription(
      wrtc.RTCSessionDescription(sdpMap['sdp'] as String, sdpMap['type'] as String),
    );
    peer.remoteDescSet = true;
    for (final c in peer.pendingCandidates) {
      await peer.pc!.addCandidate(c);
    }
    peer.pendingCandidates.clear();

    final answer = await peer.pc!.createAnswer();
    await peer.pc!.setLocalDescription(answer);
    await _signaling!.sendAnswer(peerId, {'type': answer.type, 'sdp': answer.sdp});
  }

  Future<void> _onAnswer(String peerId, Map<String, dynamic> sdpMap) async {
    final peer = _peers[peerId];
    if (peer?.pc == null) return;
    await peer!.pc!.setRemoteDescription(
      wrtc.RTCSessionDescription(sdpMap['sdp'] as String, sdpMap['type'] as String),
    );
    peer.remoteDescSet = true;
    for (final c in peer.pendingCandidates) {
      await peer.pc!.addCandidate(c);
    }
    peer.pendingCandidates.clear();
  }

  Future<void> _onCandidate(String peerId, Map<String, dynamic> c) async {
    final peer = _peers[peerId];
    if (peer == null) return;
    final candidate = wrtc.RTCIceCandidate(
      c['candidate'] as String?,
      c['sdpMid'] as String?,
      c['sdpMLineIndex'] as int?,
    );
    if (peer.pc == null || !peer.remoteDescSet) {
      peer.pendingCandidates.add(candidate);
    } else {
      await peer.pc!.addCandidate(candidate);
    }
  }

  void _teardownPeer(String peerId, {required bool emit}) {
    final peer = _peers.remove(peerId);
    if (peer == null) return;
    _uidToPeerId.remove(peer.uid);
    peer.dataChannel?.close();
    peer.pc?.close();
    if (peer.rendererReady) peer.renderer.dispose();
    if (emit) _events.add(RtcEvent(type: RtcEventType.userLeft, uid: peer.uid));
  }

  // ── Audio / Video controls ───────────────────────────────────────────

  @override
  Future<void> muteLocalAudio(bool mute) async {
    for (final t in _localStream?.getAudioTracks() ?? const <wrtc.MediaStreamTrack>[]) {
      t.enabled = !mute;
    }
    _events.add(RtcEvent(type: RtcEventType.userMuteAudio, uid: 0, data: {'muted': mute}));
    await _broadcastState(audioMuted: mute);
  }

  @override
  Future<void> muteLocalVideo(bool mute) async {
    for (final t in _localStream?.getVideoTracks() ?? const <wrtc.MediaStreamTrack>[]) {
      t.enabled = !mute;
    }
    _events.add(RtcEvent(type: RtcEventType.userMuteVideo, uid: 0, data: {'muted': mute}));
    await _broadcastState(videoMuted: mute);
  }

  Future<void> _broadcastState({bool? audioMuted, bool? videoMuted, bool? screenSharing}) async {
    final payload = <String, dynamic>{'_state': true};
    if (audioMuted != null) payload['audioMuted'] = audioMuted;
    if (videoMuted != null) payload['videoMuted'] = videoMuted;
    if (screenSharing != null) payload['screenSharing'] = screenSharing;
    await sendDataMessage(Uint8List.fromList(utf8.encode(jsonEncode(payload))));
  }

  @override
  Future<void> muteRemoteAudio(int uid, bool mute) async {
    // Mesh has no server in the middle of anyone's mic — the best a host
    // can do is politely ask the client to mute itself, same as Zoom does.
    final peerId = _uidToPeerId[uid];
    final peer = peerId != null ? _peers[peerId] : null;
    if (peer == null) return;
    final payload = {'_muteRequest': true, 'audio': mute};
    await _sendJsonTo(peer, payload);
  }

  Future<void> _sendJsonTo(_Peer peer, Map<String, dynamic> payload) async {
    if (peer.dataChannel?.state != wrtc.RTCDataChannelState.RTCDataChannelOpen) return;
    await peer.dataChannel!.send(
      wrtc.RTCDataChannelMessage.fromBinary(Uint8List.fromList(utf8.encode(jsonEncode(payload)))),
    );
  }

  @override
  Future<void> switchCamera() async {
    final track = _localStream?.getVideoTracks().firstOrNull;
    if (track != null) await wrtc.Helper.switchCamera(track);
  }

  // ── Screen sharing ───────────────────────────────────────────────────

  @override
  Future<void> startScreenShare({bool withAudio = true}) async {
    // Web: browser's native picker. Desktop: OS picker. Android: requires
    // the foreground-service + MediaProjection wiring in
    // WEBRTC_SETUP.md (flutter_webrtc handles the plumbing, you add the
    // manifest entries + a notification channel). iOS: requires adding a
    // Broadcast Upload Extension target in Xcode — this is a native
    // project change flutter_webrtc can't do purely from Dart; see the
    // setup guide for the exact steps.
    _screenStream = await wrtc.navigator.mediaDevices.getDisplayMedia({
      'video': true,
      'audio': withAudio,
    });
    final screenTrack = _screenStream!.getVideoTracks().first;
    screenTrack.onEnded = () {
      // User clicked the browser/OS "Stop sharing" control directly.
      if (_screenSharing) stopScreenShare();
    };

    // This only ever touches *this* user's own peer connections/senders, so
    // several different people can independently call startScreenShare() at
    // the same time with no interference at this layer — the app-level cap
    // on how many can share at once lives in ZoomMeetingController
    // (maxConcurrentScreenShares), not here.
    for (final peer in _peers.values) {
      if (peer.pc == null) continue;
      final senders = await peer.pc!.getSenders();
      for (final s in senders) {
        if (s.track?.kind == 'video') await s.replaceTrack(screenTrack);
      }
    }
    _localRenderer.srcObject = _screenStream;
    _screenSharing = true;
    await _broadcastState(screenSharing: true);
    _events.add(const RtcEvent(type: RtcEventType.screenShareStarted));
  }

  @override
  Future<void> stopScreenShare() async {
    if (!_screenSharing) return;
    final camTrack = _localStream?.getVideoTracks().firstOrNull;
    for (final peer in _peers.values) {
      if (peer.pc == null) continue;
      final senders = await peer.pc!.getSenders();
      for (final s in senders) {
        if (s.track?.kind == 'video' && camTrack != null) {
          await s.replaceTrack(camTrack);
        }
      }
    }
    _localRenderer.srcObject = _localStream;
    await _screenStream?.dispose();
    _screenStream = null;
    _screenSharing = false;
    await _broadcastState(screenSharing: false);
    _events.add(const RtcEvent(type: RtcEventType.screenShareStopped));
  }

  // ── Virtual background ───────────────────────────────────────────────

  @override
  Future<void> enableVirtualBackground(bool enabled, {String? imagePath}) async {
    // Not implemented here on purpose: real-time background segmentation
    // needs an ML model (e.g. google_mlkit_selfie_segmentation) plus a
    // frame-by-frame canvas compositing pipeline — a separate, sizeable
    // piece of work, not something WebRTC itself provides. Flagged in
    // WEBRTC_SETUP.md as a follow-up rather than silently faked.
    debugPrint('enableVirtualBackground: not implemented for the WebRTC backend yet.');
  }

  // ── Data channel ─────────────────────────────────────────────────────

  @override
  Future<void> sendDataMessage(Uint8List data) async {
    final msg = wrtc.RTCDataChannelMessage.fromBinary(data);
    for (final peer in _peers.values) {
      if (peer.dataChannel?.state == wrtc.RTCDataChannelState.RTCDataChannelOpen) {
        await peer.dataChannel!.send(msg);
      }
    }
  }

  @override
  Future<void> sendDataMessageTo(int uid, Uint8List data) async {
    final peerId = _uidToPeerId[uid];
    final peer = peerId != null ? _peers[peerId] : null;
    if (peer?.dataChannel?.state == wrtc.RTCDataChannelState.RTCDataChannelOpen) {
      await peer!.dataChannel!.send(wrtc.RTCDataChannelMessage.fromBinary(data));
    }
  }

  // ── Video rendering ──────────────────────────────────────────────────

  @override
  Widget buildLocalVideoView() {
    if (!_localRendererReady) return const _WebRtcStub(label: 'Starting camera…');
    return wrtc.RTCVideoView(
      _localRenderer,
      mirror: true,
      objectFit: wrtc.RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
    );
  }

  @override
  Widget buildRemoteVideoView(int uid, {String? channelId}) {
    final peerId = _uidToPeerId[uid];
    final peer = peerId != null ? _peers[peerId] : null;
    if (peer == null || !peer.rendererReady) {
      return _WebRtcStub(label: 'Connecting…');
    }
    return wrtc.RTCVideoView(
      peer.renderer,
      objectFit: wrtc.RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
    );
  }

  // ── Preview (pre-join) ───────────────────────────────────────────────

  @override
  Future<void> startPreview() async {
    _localStream ??= await wrtc.navigator.mediaDevices.getUserMedia({
      'audio': true,
      'video': true,
    });
    _localRenderer.srcObject = _localStream;
  }

  @override
  Future<void> stopPreview() async {
    if (_joined) return; // don't tear down media once actually in a call
    await _localStream?.dispose();
    _localStream = null;
    _localRenderer.srcObject = null;
  }

  // ── Stats ────────────────────────────────────────────────────────────

  Future<void> _pollStats() async {
    if (_peers.isEmpty) return;
    int txBytesTotal = 0, rxBytesTotal = 0;
    double lossSum = 0;
    int lossSamples = 0;
    String resolution = '—';

    for (final peer in _peers.values) {
      if (peer.pc == null) continue;
      try {
        final reports = await peer.pc!.getStats();
        for (final r in reports) {
          final v = r.values;
          if (r.type == 'outbound-rtp' && v['bytesSent'] != null) {
            txBytesTotal += (v['bytesSent'] as num).toInt();
          } else if (r.type == 'inbound-rtp' && v['bytesReceived'] != null) {
            rxBytesTotal += (v['bytesReceived'] as num).toInt();
            if (v['packetsLost'] != null && v['packetsReceived'] != null) {
              final lost = (v['packetsLost'] as num).toDouble();
              final recv = (v['packetsReceived'] as num).toDouble();
              if (lost + recv > 0) {
                lossSum += lost / (lost + recv) * 100;
                lossSamples++;
              }
            }
          } else if (r.type == 'track' && v['frameWidth'] != null) {
            resolution = '${v['frameWidth']}x${v['frameHeight']}';
          }
        }
      } catch (_) {
        // getStats can throw transiently mid-negotiation — skip this tick.
      }
    }

    _events.add(RtcEvent(
      type: RtcEventType.statsUpdated,
      data: {
        // Rough deltas would need last-tick bookkeeping; total-so-far is
        // still useful for the stats panel's trend line.
        'txBytesTotal': txBytesTotal,
        'rxBytesTotal': rxBytesTotal,
        'packetLossPct': lossSamples == 0 ? 0.0 : lossSum / lossSamples,
        'resolution': resolution,
        'codec': 'VP8/H264',
        'peerCount': _peers.length,
      },
    ));
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// INTERNAL PEER STATE
// ─────────────────────────────────────────────────────────────────────────────

class _Peer {
  _Peer({required this.peerId, required this.uid});
  final String peerId;
  final int uid;
  wrtc.RTCPeerConnection? pc;
  wrtc.RTCDataChannel? dataChannel;
  final wrtc.RTCVideoRenderer renderer = wrtc.RTCVideoRenderer();
  bool rendererReady = false;
  bool remoteDescSet = false;
  final List<wrtc.RTCIceCandidate> pendingCandidates = [];
}

class _WebRtcStub extends StatelessWidget {
  const _WebRtcStub({required this.label});
  final String label;
  @override
  Widget build(BuildContext c) => DecoratedBox(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF0F3460), Color(0xFF16213E)],
      ),
    ),
    child: Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.hub_outlined, color: Colors.white70, size: 28),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ]),
    ),
  );
}
