import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AgoraRtcController extends GetxController {
  // ── Credentials ─────────────────────────────────────────────────────────
  final String appId = String.fromEnvironment('AppIdAgorra', defaultValue: '');
  final String agorraToken = String.fromEnvironment(
    'AgorraToken1234567890',
    defaultValue: '',
  );
  final String channelId = 'air_space_agorra_industrial_dashboard_stream1';

  late RtcEngine engine;

  // ── Core state ───────────────────────────────────────────────────────────
  final isLocalJoined = false.obs;
  final isMuted = false.obs;
  final isVideoDisabled = false.obs;
  final isScreenSharing = false.obs;
  final isVirtualBgActive = false.obs;
  final isAiTranscribing = false.obs;
  final isHandRaised = false.obs;
  final isChatOpen = false.obs;
  final isParticipantsOpen = false.obs;

  // ── Participants ─────────────────────────────────────────────────────────
  final remoteUsers = <int>[].obs;

  /// UIDs whose audio we have locally muted (tap on tile to toggle)
  final mutedRemoteUsers = <int>{}.obs;

  /// UIDs currently detected as speaking (populated by onAudioVolumeIndication)
  final speakingUsers = <int>{}.obs;

  /// Display names — uid=0 is local user
  final participantNames = <int, String>{0: 'You (Host)'}.obs;

  /// Pinned user uid — null means no pin
  final pinnedUserId = Rxn<int>();

  // ── View modes ───────────────────────────────────────────────────────────
  /// 'gallery' | 'speaker'
  final viewMode = 'gallery'.obs;

  // ── Meeting timer ────────────────────────────────────────────────────────
  final meetingSeconds = 0.obs;
  Timer? _meetingTimer;

  // ── AI logs ──────────────────────────────────────────────────────────────
  final transcriptionLines = <String>[].obs;

  // ── Computed helpers ─────────────────────────────────────────────────────
  int get participantCount => remoteUsers.length + 1;

  String get formattedDuration {
    final s = meetingSeconds.value;
    final m = s ~/ 60;
    final h = m ~/ 60;
    if (h > 0)
      return '${h.toString().padLeft(2, '0')}:${(m % 60).toString().padLeft(2, '0')}:${(s % 60).toString().padLeft(2, '0')}';
    return '${m.toString().padLeft(2, '0')}:${(s % 60).toString().padLeft(2, '0')}';
  }

  bool isRemoteMuted(int uid) => mutedRemoteUsers.contains(uid);
  bool isSpeaking(int uid) => speakingUsers.contains(uid);

  @override
  void onInit() {
    super.onInit();
    _initAgoraEngine();
  }

  // ─────────────────────────────────────────────────────────────────────────
  // ENGINE INIT
  // ─────────────────────────────────────────────────────────────────────────
  Future<void> _initAgoraEngine() async {
    if (appId.isEmpty) {
      _log('⚠ Agora App ID missing in .env file.');
      return;
    }
    try {
      engine = createAgoraRtcEngine();

      await engine.initialize(
        RtcEngineContext(
          appId: appId,
          channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
        ),
      );

      engine.registerEventHandler(
        RtcEngineEventHandler(
          // ── Join success ──────────────────────────────────────────────
          onJoinChannelSuccess: (RtcConnection conn, int elapsed) {
            isLocalJoined.value = true;
            _startMeetingTimer();
            _log('✅ Joined channel: ${conn.channelId}');
            _startMockTranscription();
          },

          // ── Remote user joined ────────────────────────────────────────
          onUserJoined: (RtcConnection conn, int uid, int elapsed) {
            if (!remoteUsers.contains(uid)) {
              remoteUsers.add(uid);
              participantNames[uid] = 'Participant $uid';
            }
            _log('👤 User $uid joined.');
          },

          // ── Remote user left ──────────────────────────────────────────
          onUserOffline:
              (RtcConnection conn, int uid, UserOfflineReasonType reason) {
                remoteUsers.remove(uid);
                mutedRemoteUsers.remove(uid);
                speakingUsers.remove(uid);
                participantNames.remove(uid);
                if (pinnedUserId.value == uid) pinnedUserId.value = null;
                _log('🚪 User $uid left (${reason.name}).');
              },

          // ── Audio volume indication — drives speaking rings ────────────
          onAudioVolumeIndication:
              (
                RtcConnection conn,
                List<AudioVolumeInfo> speakers,
                int speakerNumber,
                int totalVolume,
              ) {
                final nowSpeaking = <int>{};
                for (final s in speakers) {
                  if ((s.volume ?? 0) > 10) nowSpeaking.add(s.uid ?? 0);
                }
                speakingUsers.value = nowSpeaking;
              },

          // ── Remote mute/unmute events ─────────────────────────────────
          onUserMuteAudio: (RtcConnection conn, int uid, bool muted) {
            _log(
              muted ? '🔇 User $uid muted mic.' : '🔊 User $uid unmuted mic.',
            );
          },

          onError: (ErrorCodeType err, String msg) {
            _log('🔴 RTC Error $err: $msg');
          },
        ),
      );

      // Enable audio volume callback (needed for speaking rings)
      await engine.enableAudioVolumeIndication(
        interval: 200,
        smooth: 3,
        reportVad: true,
      );

      await engine.enableVideo();
      await engine.startPreview();

      await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);

      await engine.joinChannel(
        token: agorraToken,
        channelId: channelId,
        uid: 0,
        options: const ChannelMediaOptions(
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
          publishCameraTrack: true,
          publishMicrophoneTrack: true,
        ),
      );
    } catch (e) {
      _log('💥 Engine init failed: $e');
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // CONTROLS
  // ─────────────────────────────────────────────────────────────────────────

  /// 🎙️ Mute / unmute YOUR OWN mic
  Future<void> toggleMute() async {
    try {
      final next = !isMuted.value;
      await engine.muteLocalAudioStream(next);
      isMuted.value = next;
      _log(next ? '🔇 Your mic is muted.' : '🔊 Your mic is live.');
    } catch (e) {
      _log('Mute error: $e');
    }
  }

  /// 🔇 Locally mute / unmute a REMOTE user's audio (tap on their tile)
  Future<void> muteRemoteAudio(int uid) async {
    try {
      final muted = !isRemoteMuted(uid);
      await engine.muteRemoteAudioStream(uid: uid, mute: muted);
      if (muted) {
        mutedRemoteUsers.add(uid);
      } else {
        mutedRemoteUsers.remove(uid);
      }
      _log(
        muted
            ? '🔇 Muted participant $uid locally.'
            : '🔊 Unmuted participant $uid.',
      );
    } catch (e) {
      _log('Remote mute error: $e');
    }
  }

  /// 📷 Toggle camera
  Future<void> toggleVideo() async {
    try {
      final next = !isVideoDisabled.value;
      await engine.muteLocalVideoStream(next);
      isVideoDisabled.value = next;
      _log(next ? '📷 Camera off.' : '📷 Camera on.');
    } catch (e) {
      _log('Video toggle error: $e');
    }
  }

  /// 🖥️ Toggle screen share
  Future<void> toggleScreenShare() async {
    try {
      if (!isScreenSharing.value) {
        await engine.startScreenCapture(
          const ScreenCaptureParameters2(
            captureAudio: true,
            captureVideo: true,
          ),
        );
        isScreenSharing.value = true;
        _log('🖥️ Screen sharing started.');
      } else {
        await engine.stopScreenCapture();
        isScreenSharing.value = false;
        _log('🖥️ Screen sharing stopped.');
      }
    } catch (e) {
      _log('Screen share error: $e');
    }
  }

  /// 🔮 Toggle virtual background blur
  Future<void> toggleVirtualBackground() async {
    try {
      final next = !isVirtualBgActive.value;
      isVirtualBgActive.value = next;
      final bgSource = next
          ? const VirtualBackgroundSource(
              backgroundSourceType: BackgroundSourceType.backgroundBlur,
              blurDegree: BackgroundBlurDegree.blurDegreeHigh,
            )
          : const VirtualBackgroundSource(
              backgroundSourceType: BackgroundSourceType.backgroundNone,
            );
      await engine.enableVirtualBackground(
        enabled: next,
        backgroundSource: bgSource,
        segproperty: const SegmentationProperty(),
      );
      _log(next ? '🔮 Background blur on.' : '🔮 Background blur off.');
    } catch (e) {
      _log('Virtual bg error: $e');
    }
  }

  /// ✋ Toggle hand raise
  void toggleHandRaise() {
    isHandRaised.value = !isHandRaised.value;
    _log(isHandRaised.value ? '✋ Hand raised.' : '✋ Hand lowered.');
  }

  /// 📌 Pin / unpin a participant (0 = local)
  void togglePin(int uid) {
    if (pinnedUserId.value == uid) {
      pinnedUserId.value = null;
      viewMode.value = 'gallery';
      _log('📌 Unpinned participant.');
    } else {
      pinnedUserId.value = uid;
      viewMode.value = 'speaker';
      _log('📌 Pinned participant $uid.');
    }
  }

  /// 🖼️ Toggle gallery ↔ speaker view
  void toggleViewMode() {
    viewMode.value = viewMode.value == 'gallery' ? 'speaker' : 'gallery';
    _log('View: ${viewMode.value} mode.');
  }

  void toggleChat() => isChatOpen.value = !isChatOpen.value;
  void toggleParticipants() =>
      isParticipantsOpen.value = !isParticipantsOpen.value;

  /// 🚪 Leave channel
  Future<void> leaveStreamChannel() async {
    try {
      isAiTranscribing.value = false;
      _meetingTimer?.cancel();
      await engine.leaveChannel();
      isLocalJoined.value = false;
      remoteUsers.clear();
      mutedRemoteUsers.clear();
      speakingUsers.clear();
      pinnedUserId.value = null;
      meetingSeconds.value = 0;
      _log('👋 Left the call.');
    } catch (e) {
      debugPrint('Leave error: $e');
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // HELPERS
  // ─────────────────────────────────────────────────────────────────────────

  void _startMeetingTimer() {
    _meetingTimer?.cancel();
    meetingSeconds.value = 0;
    _meetingTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      meetingSeconds.value++;
    });
  }

  void _log(String msg) {
    final ts = DateTime.now().toString().substring(11, 19);
    transcriptionLines.insert(0, '[$ts] $msg');
    if (transcriptionLines.length > 100) transcriptionLines.removeLast();
  }

  void _startMockTranscription() {
    isAiTranscribing.value = true;
    const lines = [
      'AI Captions: Analyzing audio vectors...',
      'AI Captions: Speech clarity — optimal.',
      'AI Captions: Background noise suppression active.',
      'AI Captions: Channel bandwidth — 2.4 Mbps.',
    ];
    for (var i = 0; i < lines.length; i++) {
      Future.delayed(Duration(seconds: 3 + i * 5), () {
        if (isAiTranscribing.value) _log(lines[i]);
      });
    }
  }

  @override
  void onClose() {
    leaveStreamChannel();
    engine.release();
    super.onClose();
  }
}
