import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart' hide navigator;

class WebRtcController extends GetxController {
  final micEnabled = true.obs;
  final cameraEnabled = true.obs;

  final RTCVideoRenderer localRenderer = RTCVideoRenderer();

  MediaStream? localStream;

  @override
  void onInit() {
    super.onInit();
    initialize();
  }

  Future<void> initialize() async {
    await localRenderer.initialize();

    localStream = await navigator.mediaDevices.getUserMedia({
      'audio': true,
      'video': true,
    });

    localRenderer.srcObject = localStream;
  }

  Future<void> toggleMic() async {
    micEnabled.value = !micEnabled.value;

    localStream?.getAudioTracks().forEach((track) {
      track.enabled = micEnabled.value;
    });
  }

  Future<void> toggleCamera() async {
    cameraEnabled.value = !cameraEnabled.value;

    localStream?.getVideoTracks().forEach((track) {
      track.enabled = cameraEnabled.value;
    });
  }

  @override
  void onClose() {
    localRenderer.dispose();
    super.onClose();
  }
}
