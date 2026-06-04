import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContributionType {
  final String title;
  final String description;
  final IconData icon;
  final String reward;

  ContributionType({required this.title, required this.description, required this.icon, required this.reward});
}

class ContributeToAirController extends GetxController {
  final types = <ContributionType>[
    ContributionType(
      title: "Data Verification",
      description: "Help verify digitized records for accuracy.",
      icon: Icons.fact_check_outlined,
      reward: "50 Credits/Batch",
    ),
    ContributionType(
      title: "Bug Reporting",
      description: "Report technical glitches and UI inconsistencies.",
      icon: Icons.bug_report_outlined,
      reward: "200 Credits/Valid Bug",
    ),
    ContributionType(
      title: "Community Moderation",
      description: "Maintain the quality of the public feed.",
      icon: Icons.security_outlined,
      reward: "500 Credits/Month",
    ),
    ContributionType(
      title: "Infrastructure Hosting",
      description: "Provide compute power for AIR network nodes.",
      icon: Icons.dns_outlined,
      reward: "1000 Credits/Month",
    ),
  ].obs;

  void startContribution(String title) {
    Get.snackbar("Contribution Started", "Setting up your workspace for $title...");
  }
}
