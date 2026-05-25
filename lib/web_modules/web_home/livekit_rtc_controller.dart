import 'package:get/get.dart';
import 'package:livekit_client/livekit_client.dart';

class LiveRtcController extends GetxController {
  final room = Room();

  final connected = false.obs;
  final micEnabled = true.obs;
  final cameraEnabled = true.obs;

  @override
  void onInit() {
    super.onInit();
    connectRoom();
  }

  Future<void> connectRoom() async {
    await room.connect('wss://YOUR_URL', 'YOUR_TOKEN');

    connected.value = true;
  }

  Future<void> toggleMic() async {
    micEnabled.value = !micEnabled.value;

    // await room.localParticipant?.setMicrophoneEnabled(micEnabled.value);# livekit_client: ^2.7.0
    for (var trackPub in room.localParticipant.audioTracks.values) {
      //# livekit_client: ^0.1.1
      // Access the native WebRTC track underlying the LiveKit wrapper
      if (trackPub.track != null) {
        trackPub.track!.mediaTrack.enabled = micEnabled.value;
      }
    }
  }

  Future<void> toggleCamera() async {
    cameraEnabled.value = !cameraEnabled.value;

    // await room.localParticipant?.setCameraEnabled(cameraEnabled.value);# livekit_client: ^2.7.0

    for (var trackPub in room.localParticipant.videoTracks.values) {
      //# livekit_client: ^0.1.1
      if (trackPub.track != null) {
        // Directly tells flutter_webrtc to stop pushing frames
        trackPub.track!.mediaTrack.enabled = cameraEnabled.value;
      }
    }
  }
}
