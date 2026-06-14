import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import '../models/rtc_config.dart';

// ─────────────────────────────────────────────────────────────────────────────
// UNIFIED RTC EVENT MODEL
// ─────────────────────────────────────────────────────────────────────────────

enum RtcEventType {
  localJoined,
  localLeft,
  userJoined,
  userLeft,
  audioVolumeIndication,
  activeSpeakerChanged,
  userMuteAudio,
  userMuteVideo,
  screenShareStarted,
  screenShareStopped,
  connectionStateChanged,
  statsUpdated,
  dataMessageReceived,
  tokenExpiring,
  error,
}

/// A single event emitted by any RTC backend.
class RtcEvent {
  final RtcEventType type;
  final int? uid;
  final String? channelId;
  final Map<String, dynamic> data;

  const RtcEvent({
    required this.type,
    this.uid,
    this.channelId,
    this.data = const {},
  });

  @override
  String toString() => 'RtcEvent($type, uid=$uid, data=$data)';
}

/// Audio volume snapshot for one user.
class AudioVolumeEntry {
  final int uid; // 0 = local
  final int volume; // 0..255
  const AudioVolumeEntry({required this.uid, required this.volume});
}

/// Network / codec stats snapshot.
class RtcStats {
  final int cpuAppPct;
  final int cpuTotalPct;
  final int txKbps;
  final int rxKbps;
  final int jitterMs;
  final double packetLossPct;
  final String resolution;
  final String codec;
  const RtcStats({
    this.cpuAppPct = 0,
    this.cpuTotalPct = 0,
    this.txKbps = 0,
    this.rxKbps = 0,
    this.jitterMs = 0,
    this.packetLossPct = 0.0,
    this.resolution = '1280x720',
    this.codec = 'H264',
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// ABSTRACT ENGINE INTERFACE
// ─────────────────────────────────────────────────────────────────────────────

/// Contract that every RTC backend must implement.
/// Both [AgoraRtcService] and [WebRtcService] conform to this.
abstract class RtcEngineInterface {
  /// Which backend this instance represents.
  RtcBackend get backend;

  /// Whether the engine is currently connected to a channel.
  bool get isJoined;

  /// Unified event stream — UI subscribes to this once.
  Stream<RtcEvent> get events;

  /// Initialise the engine with the given config. Call once.
  Future<void> initialize(RtcConfig config);

  /// Join a channel / room. Token may be empty for testing.
  Future<void> joinChannel({
    required String channelId,
    required String token,
    required int uid,
  });

  /// Leave the current channel gracefully.
  Future<void> leaveChannel();

  /// Release all resources. Call on dispose.
  Future<void> dispose();

  // ── Audio / Video controls ──────────────────────────────────────────────

  Future<void> muteLocalAudio(bool mute);
  Future<void> muteLocalVideo(bool mute);
  Future<void> muteRemoteAudio(int uid, bool mute);
  Future<void> switchCamera();

  // ── Screen sharing ──────────────────────────────────────────────────────

  Future<void> startScreenShare({bool withAudio = true});
  Future<void> stopScreenShare();

  // ── Virtual background ──────────────────────────────────────────────────

  Future<void> enableVirtualBackground(bool enabled, {String? imagePath});

  // ── Data channel (for remote control) ──────────────────────────────────

  /// Send a binary or JSON message to all users in the channel.
  Future<void> sendDataMessage(Uint8List data);

  /// Send a message to a specific user (if supported, otherwise broadcasts).
  Future<void> sendDataMessageTo(int uid, Uint8List data);

  // ── Video rendering ─────────────────────────────────────────────────────

  /// Returns a platform-appropriate video widget for the given uid.
  /// [uid] 0 = local user.
  Widget buildLocalVideoView();
  Widget buildRemoteVideoView(int uid, {String? channelId});

  // ── Preview (pre-join) ──────────────────────────────────────────────────

  Future<void> startPreview();
  Future<void> stopPreview();
}
