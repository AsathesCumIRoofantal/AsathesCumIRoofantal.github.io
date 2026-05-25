import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AgoraRtcControllerDesign1 extends GetxController {
  // Pull security keys securely from Environment Configurations
  final String appId = dotenv.env['AppIdAgorra'] ?? "";
  final String agorraToken = dotenv.env['AgorraToken'] ?? "";
  final String channelId = "air_space_agorra_industrial_dashboard_stream";

  late RtcEngine engine;

  // Core Track Reactive Observers
  final isLocalJoined = false.obs;
  final isMuted = false.obs;
  final isVideoDisabled = false.obs;
  final isScreenSharing = false.obs;
  final isVirtualBgActive = false.obs;
  final isAiTranscribing = false.obs;

  // Trackers for active connections and live string logging feeds
  final remoteUsers = <int>[].obs;
  final transcriptionLines = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initAgoraEngine();
  }

  Future<void> _initAgoraEngine() async {
    if (appId.isEmpty) {
      _logAiEvent(
        "[Error] Agora App ID configuration parameter is missing inside your env file.",
      );
      return;
    }

    try {
      engine = createAgoraRtcEngine();

      // Initialize framework with custom optimization context profiles
      await engine.initialize(
        RtcEngineContext(
          appId: appId,
          channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
        ),
      );

      // Register real-time stream engine operation pipelines
      engine.registerEventHandler(
        RtcEngineEventHandler(
          onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
            isLocalJoined.value = true;
            _logAiEvent("System: Joined call routing hub successfully.");
            _startAiMockTranscription(); // Boots mock AI logs for feature illustration
          },
          onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
            remoteUsers.add(remoteUid);
            _logAiEvent(
              "System: Remote hardware source connected (UID: $remoteUid).",
            );
          },
          onUserOffline:
              (
                RtcConnection connection,
                int remoteUid,
                UserOfflineReasonType reason,
              ) {
                remoteUsers.remove(remoteUid);
                _logAiEvent(
                  "System: Feed source disconnected (UID: $remoteUid).",
                );
              },
          onError: (ErrorCodeType err, String msg) {
            _logAiEvent("[RTC Error] Code: $err - $msg");
          },
        ),
      );

      // Setup and publish local engine hardware tracks
      await engine.enableVideo();
      await engine.startPreview();

      // Request joining the live space channel feed
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
      _logAiEvent("Critical Engine Crash Exception: $e");
    }
  }

  // 🎙️ Toggle Microphone Stream State
  Future<void> toggleMute() async {
    try {
      await engine.muteLocalAudioStream(!isMuted.value);
      isMuted.value = !isMuted.value;
      _logAiEvent(
        isMuted.value
            ? "Hardware: Microphone stream muted."
            : "Hardware: Microphone stream active.",
      );
    } catch (e) {
      _logAiEvent("Mute Error: $e");
    }
  }

  // 📷 Toggle Camera Feed Track State
  Future<void> toggleVideo() async {
    try {
      await engine.muteLocalVideoStream(!isVideoDisabled.value);
      isVideoDisabled.value = !isVideoDisabled.value;
      _logAiEvent(
        isVideoDisabled.value
            ? "Hardware: Local camera stream disabled."
            : "Hardware: Local camera stream active.",
      );
    } catch (e) {
      _logAiEvent("Video Toggle Error: $e");
    }
  }

  // 🖥️ Toggle Screen Share Capabilities
  Future<void> toggleScreenShare() async {
    try {
      if (!isScreenSharing.value) {
        // Triggers Web Browser display picker layout naturally
        await engine.startScreenCapture(
          const ScreenCaptureParameters2(
            captureAudio: true,
            captureVideo: true,
          ),
        );
        isScreenSharing.value = true;
        _logAiEvent("System: Browser frame viewport capturing active.");
      } else {
        await engine.stopScreenCapture();
        isScreenSharing.value = false;
        _logAiEvent("System: Screen share stream closed.");
      }
    } catch (e) {
      _logAiEvent("Screen Share Error: $e");
    }
  }

  // 🔮 Toggle Virtual Background/Blur Processing Matrix
  Future<void> toggleVirtualBackground() async {
    try {
      isVirtualBgActive.value = !isVirtualBgActive.value;

      VirtualBackgroundSource bgSource;
      if (isVirtualBgActive.value) {
        bgSource = const VirtualBackgroundSource(
          backgroundSourceType: BackgroundSourceType.backgroundBlur,
          blurDegree: BackgroundBlurDegree.blurDegreeHigh,
        );
        _logAiEvent(
          "AI Engine: Local background image segmentation blur active.",
        );
      } else {
        bgSource = const VirtualBackgroundSource(
          backgroundSourceType: BackgroundSourceType.backgroundNone,
        );
        _logAiEvent("AI Engine: Background segmentation filters removed.");
      }

      await engine.enableVirtualBackground(
        enabled: isVirtualBgActive.value,
        backgroundSource: bgSource,
        segproperty: const SegmentationProperty(),
      );
    } catch (e) {
      _logAiEvent("Virtual Background Error: $e");
    }
  }

  // 🚪 Gracefully Terminate Channels
  Future<void> leaveStreamChannel() async {
    try {
      isAiTranscribing.value = false;
      await engine.leaveChannel();
      isLocalJoined.value = false;
      remoteUsers.clear();
      _logAiEvent("System: Disconnected and exited from current session.");
    } catch (e) {
      debugPrint("Exit Exception: $e");
    }
  }

  // Helper log engine updates directly inside UI
  void _logAiEvent(String eventText) {
    final timestamp = DateTime.now().toString().substring(11, 19);
    transcriptionLines.insert(0, "[$timestamp] $eventText");
  }

  // Simulates cloud-processed real-time transcription metrics
  void _startAiMockTranscription() {
    isAiTranscribing.value = true;
    Future.delayed(const Duration(seconds: 4), () {
      if (isAiTranscribing.value) {
        _logAiEvent("AI Captions: Analyzing telemetry data vectors...");
        _startNextMockLine();
      }
    });
  }

  void _startNextMockLine() {
    Future.delayed(const Duration(seconds: 6), () {
      if (isAiTranscribing.value) {
        _logAiEvent(
          "AI Captions: Audio channels showing optimal operational levels.",
        );
      }
    });
  }

  @override
  void onClose() {
    leaveStreamChannel();
    engine.release();
    super.onClose();
  }
}
