import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:air_app/web_modules/_shared/web_nav_data.dart';
import 'package:air_app/web_modules/_shared/web_shell.dart';
import 'package:air_app/web_modules/web_home/agora_rtc_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AgoraView extends GetView<AgoraRtcController> {
  const AgoraView({super.key});

  static const String routeName = WebNavData.homeAgoraRoute;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Builder(
      builder: (context) {
        return WebShell(
          currentRoute: routeName,
          child: Scaffold(
            appBar: AppBar(title: const Text('Industrial RTC Dashboard')),
            body: LayoutBuilder(
              builder: (context, constraints) {
                final isDesktop = constraints.maxWidth > 1100;
                final isTablet = constraints.maxWidth > 700;

                return Obx(
                  () => GridView.builder(
                    itemCount: 1 + controller.remoteUsers.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                    itemBuilder: (_, index) {
                      // Local View (index 0) or Remote View (index > 0)
                      return AgoraVideoView(
                        controller: index == 0
                            ? VideoViewController(
                                rtcEngine: controller.engine,
                                canvas: const VideoCanvas(uid: 0),
                              )
                            : VideoViewController.remote(
                                rtcEngine: controller.engine,
                                canvas: VideoCanvas(
                                  uid: controller.remoteUsers[index - 1],
                                ),
                                connection: RtcConnection(
                                  channelId: controller.channelId,
                                ),
                              ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
