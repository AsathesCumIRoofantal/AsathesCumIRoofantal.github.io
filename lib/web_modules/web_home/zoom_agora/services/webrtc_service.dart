import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../models/rtc_config.dart';
import 'rtc_engine_interface.dart';

/// Lightweight Custom WebRTC implementation of [RtcEngineInterface].
///
/// In production this would wrap `flutter_webrtc` + a signaling channel
/// (see `signaling_service.dart`). For deployed-feel testing without
/// native deps we keep the public surface 1:1 with [AgoraRtcService] and
/// emit synthetic events so the UI behaves identically.
///
/// Toggle between this and [AgoraRtcService] via [RtcBackendManager].
class WebRtcService implements RtcEngineInterface {
  RtcConfig? _config;
  bool _joined = false;
  bool _screenSharing = false;
  Timer? _statsTimer;
  final _rand = Random();
  final _events = StreamController<RtcEvent>.broadcast();

  @override
  RtcBackend get backend => RtcBackend.webrtc;

  @override
  bool get isJoined => _joined;

  @override
  Stream<RtcEvent> get events => _events.stream;

  @override
  Future<void> initialize(RtcConfig config) async {
    _config = config;
    // TODO(prod): create RTCPeerConnection pool with config.iceServers
    //             and connect to config.signalingUrl via SignalingService.
  }

  @override
  Future<void> joinChannel({
    required String channelId,
    required String token,
    required int uid,
  }) async {
    _joined = true;
    _events.add(RtcEvent(type: RtcEventType.localJoined, channelId: channelId));
    _statsTimer?.cancel();
    _statsTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      _events.add(RtcEvent(
        type: RtcEventType.statsUpdated,
        data: {
          'txKbps': 600 + _rand.nextInt(400),
          'rxKbps': 800 + _rand.nextInt(600),
          'jitterMs': 8 + _rand.nextInt(20),
          'packetLossPct': _rand.nextDouble() * 1.5,
          'codec': 'VP9',
        },
      ));
    });
  }

  @override
  Future<void> leaveChannel() async {
    _statsTimer?.cancel();
    _screenSharing = false;
    _joined = false;
    _events.add(RtcEvent(
      type: RtcEventType.localLeft,
      channelId: _config?.channelId,
    ));
  }

  @override
  Future<void> dispose() async {
    _statsTimer?.cancel();
    await _events.close();
  }

  @override
  Future<void> muteLocalAudio(bool mute) async {
    _events.add(RtcEvent(
      type: RtcEventType.userMuteAudio, uid: 0, data: {'muted': mute}));
  }

  @override
  Future<void> muteLocalVideo(bool mute) async {
    _events.add(RtcEvent(
      type: RtcEventType.userMuteVideo, uid: 0, data: {'muted': mute}));
  }

  @override
  Future<void> muteRemoteAudio(int uid, bool mute) async {}

  @override
  Future<void> switchCamera() async {}

  @override
  Future<void> startScreenShare({bool withAudio = true}) async {
    _screenSharing = true;
    _events.add(const RtcEvent(type: RtcEventType.screenShareStarted));
  }

  @override
  Future<void> stopScreenShare() async {
    _screenSharing = false;
    _events.add(const RtcEvent(type: RtcEventType.screenShareStopped));
  }

  @override
  Future<void> enableVirtualBackground(bool enabled, {String? imagePath}) async {}

  @override
  Future<void> sendDataMessage(Uint8List data) async {
    // TODO(prod): RTCDataChannel.send(data)
  }

  @override
  Future<void> sendDataMessageTo(int uid, Uint8List data) =>
      sendDataMessage(data);

  @override
  Widget buildLocalVideoView() => const _WebRtcStub(label: 'WebRTC · Local');

  @override
  Widget buildRemoteVideoView(int uid, {String? channelId}) =>
      _WebRtcStub(label: 'WebRTC · uid $uid');

  @override
  Future<void> startPreview() async {}

  @override
  Future<void> stopPreview() async {}
}

class _WebRtcStub extends StatelessWidget {
  const _WebRtcStub({required this.label});
  final String label;
  @override
  Widget build(BuildContext c) => DecoratedBox(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft, end: Alignment.bottomRight,
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
