import 'package:air_app/web_modules/_shared/web_nav_data.dart';
import 'package:air_app/web_modules/_shared/web_shell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'web_rtc_controller.dart';

class WebRtcCallView extends GetView<WebRtcController> {
  const WebRtcCallView({super.key});
  static const String routeName = WebNavData.homeWebRtcRoute;

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness ==
        Brightness.dark; //TODO and Responsive....
    return WebShell(
      currentRoute: routeName,
      child: Scaffold(
        backgroundColor: const Color(0xff0B1020),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: RTCVideoView(
                  controller.localRenderer,
                  mirror: true,
                  objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: controller.toggleMic,
                        icon: Icon(
                          controller.micEnabled.value
                              ? Icons.mic
                              : Icons.mic_off,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        onPressed: controller.toggleCamera,
                        icon: Icon(
                          controller.cameraEnabled.value
                              ? Icons.videocam
                              : Icons.videocam_off,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
