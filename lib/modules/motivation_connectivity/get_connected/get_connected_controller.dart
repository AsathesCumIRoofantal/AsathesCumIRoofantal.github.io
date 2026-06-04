import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SocialLink {
  final String platform;
  final String handle;
  final IconData icon;

  SocialLink({required this.platform, required this.handle, required this.icon});
}

class GetConnectedController extends GetxController {
  final links = <SocialLink>[
    SocialLink(platform: "AIR Global Feed", handle: "@network_core", icon: Icons.rss_feed_rounded),
    SocialLink(platform: "Enterprise Slack", handle: "#air-support", icon: Icons.alternate_email_rounded),
    SocialLink(platform: "Dev Portal", handle: "github.com/air-org", icon: Icons.code_rounded),
  ].obs;

  void connect(String platform) {
    Get.snackbar("Connecting", "Redirecting to $platform...");
  }
}
