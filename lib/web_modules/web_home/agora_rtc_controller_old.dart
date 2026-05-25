// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:get/get.dart';

// class AgoraRtcController extends GetxController {
//   late final RtcEngine engine;

//   final isJoined = false.obs;
//   final micEnabled = true.obs;
//   final cameraEnabled = true.obs;

//   final remoteUsers = <int>[].obs;

//   @override
//   void onInit() {
//     super.onInit();
//     initializeAgora();
//   }

//   Future<void> initializeAgora() async {
//     engine = createAgoraRtcEngine();

//     await engine.initialize(const RtcEngineContext(appId: 'YOUR_AGORA_APP_ID'));

//     await engine.enableVideo();

//     engine.registerEventHandler(
//       RtcEngineEventHandler(
//         onJoinChannelSuccess: (connection, elapsed) {
//           isJoined.value = true;
//         },
//         onUserJoined: (connection, remoteUid, elapsed) {
//           remoteUsers.add(remoteUid);
//         },
//         onUserOffline: (connection, remoteUid, reason) {
//           remoteUsers.remove(remoteUid);
//         },
//       ),
//     );
//   }

//   Future<void> toggleMic() async {
//     micEnabled.value = !micEnabled.value;
//     await engine.muteLocalAudioStream(!micEnabled.value);
//   }

//   Future<void> toggleCamera() async {
//     cameraEnabled.value = !cameraEnabled.value;
//     await engine.muteLocalVideoStream(!cameraEnabled.value);
//   }
// }
