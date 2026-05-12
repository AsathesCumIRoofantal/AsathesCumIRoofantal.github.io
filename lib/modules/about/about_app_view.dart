import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'about_controller.dart';

class AboutAppView extends GetView<AboutController> {
  const AboutAppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: const Text("ABOUT APP")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FlutterLogo(size: 80),
            const SizedBox(height: 24),
            const Text("AIR MOBILE", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Obx(() => Text("Version ${controller.appVersion.value}", style: const TextStyle(color: Colors.grey))),
            const SizedBox(height: 48),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "A cutting-edge industrial synchronization platform built on the power of GetX and Flutter.",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
