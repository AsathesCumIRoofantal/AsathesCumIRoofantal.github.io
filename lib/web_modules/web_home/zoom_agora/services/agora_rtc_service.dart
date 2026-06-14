import 'dart:async';
import 'dart:typed_data';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import '../models/rtc_config.dart';
import 'rtc_engine_interface.dart' hide RtcStats;

/// Production Agora RTC implementation of [RtcEngineInterface].
/// Wraps `agora_rtc_engine` and maps all callbacks to the unified event stream.
class AgoraRtcService implements RtcEngineInterface {
  late RtcEngine _engine;
  RtcConfig? _config;
  int? _dataStreamId;
  bool _joined = false;
  bool _screenSharing = false;

  final _events = StreamController<RtcEvent>.broadcast();

  // ── RtcEngineInterface overrides ──────────────────────────────────────

  @override
  RtcBackend get backend => RtcBackend.agora;

  @override
  bool get isJoined => _joined;

  @override
  Stream<RtcEvent> get events => _events.stream;

  // ── Initialise ────────────────────────────────────────────────────────

  @override
  Future<void> initialize(RtcConfig config) async {
    _config = config;
    _engine = createAgoraRtcEngine();

    await _engine.initialize(
      RtcEngineContext(
        appId: config.appId,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
      ),
    );

    // Register event handlers → pipe to unified stream
    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection conn, int elapsed) {
          _joined = true;
          _events.add(
            RtcEvent(type: RtcEventType.localJoined, channelId: conn.channelId),
          );
        },
        onLeaveChannel: (RtcConnection conn, RtcStats stats) {
          _joined = false;
          _events.add(
            RtcEvent(type: RtcEventType.localLeft, channelId: conn.channelId),
          );
        },
        onUserJoined: (RtcConnection conn, int uid, int elapsed) {
          _events.add(
            RtcEvent(
              type: RtcEventType.userJoined,
              uid: uid,
              channelId: conn.channelId,
            ),
          );
        },
        onUserOffline: (RtcConnection conn, int uid, UserOfflineReasonType r) {
          _events.add(
            RtcEvent(
              type: RtcEventType.userLeft,
              uid: uid,
              channelId: conn.channelId,
              data: {'reason': r.name},
            ),
          );
        },
        onAudioVolumeIndication:
            (
              RtcConnection conn,
              List<AudioVolumeInfo> speakers,
              int speakerNumber,
              int totalVolume,
            ) {
              final entries = speakers
                  .map(
                    (s) => AudioVolumeEntry(
                      uid: s.uid ?? 0,
                      volume: s.volume ?? 0,
                    ),
                  )
                  .toList();
              _events.add(
                RtcEvent(
                  type: RtcEventType.audioVolumeIndication,
                  data: {'speakers': entries},
                ),
              );

              // Determine active speaker (loudest non-zero)
              int activeSpeaker = 0;
              int maxVol = 0;
              for (final s in speakers) {
                if ((s.volume ?? 0) > maxVol) {
                  maxVol = s.volume ?? 0;
                  activeSpeaker = s.uid ?? 0;
                }
              }
              if (maxVol > 10) {
                _events.add(
                  RtcEvent(
                    type: RtcEventType.activeSpeakerChanged,
                    uid: activeSpeaker,
                  ),
                );
              }
            },
        onUserMuteAudio: (RtcConnection conn, int uid, bool muted) {
          _events.add(
            RtcEvent(
              type: RtcEventType.userMuteAudio,
              uid: uid,
              data: {'muted': muted},
            ),
          );
        },
        onUserMuteVideo: (RtcConnection conn, int uid, bool muted) {
          _events.add(
            RtcEvent(
              type: RtcEventType.userMuteVideo,
              uid: uid,
              data: {'muted': muted},
            ),
          );
        },
        onRtcStats: (RtcConnection conn, RtcStats stats) {
          _events.add(
            RtcEvent(
              type: RtcEventType.statsUpdated,
              data: {
                'stats': RtcStats(
                  cpuAppUsage: stats.cpuAppUsage ?? 0,
                  cpuTotalUsage: stats.cpuTotalUsage ?? 0,
                  txBytes: stats.txBytes ?? 0,
                  rxBytes: stats.rxBytes ?? 0,
                ),
              },
            ),
          );
        },
        onStreamMessage:
            (
              RtcConnection conn,
              int remoteUid,
              int streamId,
              Uint8List data,
              int length,
              int sentTs,
            ) {
              _events.add(
                RtcEvent(
                  type: RtcEventType.dataMessageReceived,
                  uid: remoteUid,
                  data: {'bytes': data},
                ),
              );
            },
        onTokenPrivilegeWillExpire: (RtcConnection conn, String token) {
          _events.add(
            RtcEvent(type: RtcEventType.tokenExpiring, data: {'token': token}),
          );
        },
        onError: (ErrorCodeType err, String msg) {
          _events.add(
            RtcEvent(
              type: RtcEventType.error,
              data: {'code': err.name, 'message': msg},
            ),
          );
        },
      ),
    );

    // Enable audio volume reporting for speaking indicators
    await _engine.enableAudioVolumeIndication(
      interval: 200,
      smooth: 3,
      reportVad: true,
    );

    await _engine.enableVideo();
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
  }

  // ── Join / Leave ──────────────────────────────────────────────────────

  @override
  Future<void> joinChannel({
    required String channelId,
    required String token,
    required int uid,
  }) async {
    // Create a reliable data stream for remote control messages
    _dataStreamId = await _engine.createDataStream(
      const DataStreamConfig(syncWithAudio: false, ordered: true),
    );

    await _engine.joinChannel(
      token: token,
      channelId: channelId,
      uid: uid,
      options: const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        publishCameraTrack: true,
        publishMicrophoneTrack: true,
      ),
    );
  }

  @override
  Future<void> leaveChannel() async {
    _screenSharing = false;
    await _engine.leaveChannel();
    _joined = false;
  }

  @override
  Future<void> dispose() async {
    _events.close();
    _engine.release();
  }

  // ── Audio / Video ─────────────────────────────────────────────────────

  @override
  Future<void> muteLocalAudio(bool mute) => _engine.muteLocalAudioStream(mute);

  @override
  Future<void> muteLocalVideo(bool mute) => _engine.muteLocalVideoStream(mute);

  @override
  Future<void> muteRemoteAudio(int uid, bool mute) =>
      _engine.muteRemoteAudioStream(uid: uid, mute: mute);

  @override
  Future<void> switchCamera() => _engine.switchCamera();

  // ── Screen Share ──────────────────────────────────────────────────────

  @override
  Future<void> startScreenShare({bool withAudio = true}) async {
    await _engine.startScreenCapture(
      ScreenCaptureParameters2(captureAudio: withAudio, captureVideo: true),
    );
    _screenSharing = true;
    _events.add(const RtcEvent(type: RtcEventType.screenShareStarted));
  }

  @override
  Future<void> stopScreenShare() async {
    await _engine.stopScreenCapture();
    _screenSharing = false;
    _events.add(const RtcEvent(type: RtcEventType.screenShareStopped));
  }

  // ── Virtual Background ────────────────────────────────────────────────

  @override
  Future<void> enableVirtualBackground(
    bool enabled, {
    String? imagePath,
  }) async {
    final bgSource = enabled
        ? (imagePath != null
              ? VirtualBackgroundSource(
                  backgroundSourceType: BackgroundSourceType.backgroundImg,
                  source: imagePath,
                )
              : const VirtualBackgroundSource(
                  backgroundSourceType: BackgroundSourceType.backgroundBlur,
                  blurDegree: BackgroundBlurDegree.blurDegreeHigh,
                ))
        : const VirtualBackgroundSource(
            backgroundSourceType: BackgroundSourceType.backgroundNone,
          );
    await _engine.enableVirtualBackground(
      enabled: enabled,
      backgroundSource: bgSource,
      segproperty: const SegmentationProperty(),
    );
  }

  // ── Data Channel ──────────────────────────────────────────────────────

  @override
  Future<void> sendDataMessage(Uint8List data) async {
    if (_dataStreamId == null) return;
    await _engine.sendStreamMessage(
      streamId: _dataStreamId!,
      data: data,
      length: data.length,
    );
  }

  @override
  Future<void> sendDataMessageTo(int uid, Uint8List data) async {
    // Agora data streams are broadcast-only; we include target uid in the
    // message payload and let the receiver filter.
    await sendDataMessage(data);
  }

  // ── Video Views ───────────────────────────────────────────────────────

  @override
  Widget buildLocalVideoView() {
    return AgoraVideoView(
      controller: VideoViewController(
        rtcEngine: _engine,
        canvas: const VideoCanvas(uid: 0),
      ),
    );
  }

  @override
  Widget buildRemoteVideoView(int uid, {String? channelId}) {
    return AgoraVideoView(
      controller: VideoViewController.remote(
        rtcEngine: _engine,
        canvas: VideoCanvas(uid: uid),
        connection: RtcConnection(
          channelId: channelId ?? _config?.channelId ?? '',
        ),
      ),
    );
  }

  // ── Preview ───────────────────────────────────────────────────────────

  @override
  Future<void> startPreview() => _engine.startPreview();

  @override
  Future<void> stopPreview() => _engine.stopPreview();
}

// /// Typedef alias to avoid conflict with our custom [RtcStats].
// typedef RtcStats_ = agora_rtc_engine.RtcStats;
