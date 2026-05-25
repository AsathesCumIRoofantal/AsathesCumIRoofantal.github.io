import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// Controller manages Agora SDK state, connections, and hardware toggles
class AgoraRtcController extends GetxController {
  //Please use your own app id and token
  String appId = dotenv.env['AppIdAgorra'] ?? "n/a";
  String agorraToken = dotenv.env['AgorraToken'] ?? "n/a";
  String channelId = "air_space_agorra_industrial_dashboard_stream";

  late RtcEngine engine;
  final isLocalJoined = false.obs;
  final isMuted = false.obs;
  final isCameraOff = false.obs;
  final remoteUsers = <int>[].obs; // Tracks remote user IDs

  @override
  void onInit() {
    super.onInit();
    _initAgoraEngine();
  }

  Future<void> _initAgoraEngine() async {
    engine = createAgoraRtcEngine();
    // Initialize, set up event handlers, and join channel
    await engine.initialize(RtcEngineContext(appId: appId));

    engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (_, __) => isLocalJoined.value = true,
        onUserJoined: (_, remoteUid, __) => remoteUsers.add(remoteUid),
        onUserOffline: (_, remoteUid, __) => remoteUsers.remove(remoteUid),
      ),
    );

    await engine.enableVideo();
    await engine.startPreview();
    await engine.joinChannel(
      token: agorraToken,
      channelId: channelId,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  Future<void> toggleMicrophone() async {
    await engine.muteLocalAudioStream(!isMuted.value);
    isMuted.value = !isMuted.value;
  }

  Future<void> toggleCamera() async {
    await engine.muteLocalVideoStream(!isCameraOff.value);
    isCameraOff.value = !isCameraOff.value;
  }

  @override
  void onClose() {
    engine.leaveChannel(); //
    engine.release(); //
    super.onClose();
  }
}
