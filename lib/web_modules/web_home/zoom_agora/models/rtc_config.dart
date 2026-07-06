/// Backend selector — switch between Agora (default) and raw WebRTC.
enum RtcBackend { agora, webrtc }

/// Immutable configuration that every RTC service reads at init time.
/// Passed through route arguments so each meeting can choose its backend.
class RtcConfig {
  /// Which RTC engine to use.
  final RtcBackend backend;

  /// Agora App ID (ignored when [backend] == [RtcBackend.webrtc]).
  final String appId;

  /// Agora temp token or empty string for testing mode.
  final String token;

  /// Channel / room identifier — shared across both backends.
  final String channelId;

  /// Local user ID. 0 = let Agora assign; for WebRTC it is a random int.
  final int uid;

  /// WebSocket URL for the signaling server (WebRTC mode only).
  final String? signalingUrl;

  /// Whether AnyDesk-style remote control is available in this session.
  final bool enableRemoteControl;

  /// STUN / TURN servers for WebRTC ICE.
  final List<Map<String, dynamic>> iceServers;

  /// If true, the session runs with mock data (no real engine).
  final bool demoMode;

  const RtcConfig({
    this.backend = RtcBackend.agora,
    this.appId = '',
    this.token = '',
    this.channelId = 'air_space_default_channel',
    this.uid = 0,
    this.signalingUrl,
    this.enableRemoteControl = true,
    this.iceServers = const [
      {'urls': 'stun:stun.l.google.com:19302'},
      {'urls': 'stun:stun1.l.google.com:19302'},
    ],
    this.demoMode = false,
  });

  /// Builds an [RtcConfig] with a TURN relay appended after the public
  /// STUN servers, so calls still connect when direct P2P is blocked by
  /// strict NAT / corporate firewalls. See WEBRTC_SETUP.md for a
  /// self-hosted coturn docker-compose (free) or the Metered.ca free tier.
  factory RtcConfig.withTurn({
    required String channelId,
    required int uid,
    required String turnUrl, // e.g. 'turn:your.server.com:3478'
    required String turnUsername,
    required String turnCredential,
    bool enableRemoteControl = true,
  }) =>
      RtcConfig(
        backend: RtcBackend.webrtc,
        channelId: channelId,
        uid: uid,
        enableRemoteControl: enableRemoteControl,
        iceServers: [
          {'urls': 'stun:stun.l.google.com:19302'},
          {'urls': 'stun:stun1.l.google.com:19302'},
          {'urls': turnUrl, 'username': turnUsername, 'credential': turnCredential},
        ],
      );

  /// Read credentials from dart-define env vars (matching existing pattern).
  factory RtcConfig.fromEnvironment({
    RtcBackend backend = RtcBackend.agora,
    String channelId = 'air_space_agorra_industrial_dashboard_stream1',
    bool enableRemoteControl = true,
  }) {
    final appId = const String.fromEnvironment('AppIdAgorra', defaultValue: '');
    final token = const String.fromEnvironment(
      'AgorraToken1234567890',
      defaultValue: '',
    );
    return RtcConfig(
      backend: backend,
      appId: appId,
      token: token,
      channelId: channelId,
      enableRemoteControl: enableRemoteControl,
      demoMode: appId.isEmpty && backend == RtcBackend.agora,
    );
  }

  RtcConfig copyWith({
    RtcBackend? backend,
    String? appId,
    String? token,
    String? channelId,
    int? uid,
    String? signalingUrl,
    bool? enableRemoteControl,
    List<Map<String, dynamic>>? iceServers,
    bool? demoMode,
  }) =>
      RtcConfig(
        backend: backend ?? this.backend,
        appId: appId ?? this.appId,
        token: token ?? this.token,
        channelId: channelId ?? this.channelId,
        uid: uid ?? this.uid,
        signalingUrl: signalingUrl ?? this.signalingUrl,
        enableRemoteControl: enableRemoteControl ?? this.enableRemoteControl,
        iceServers: iceServers ?? this.iceServers,
        demoMode: demoMode ?? this.demoMode,
      );
}
