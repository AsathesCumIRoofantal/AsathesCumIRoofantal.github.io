import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebContributeController extends GetxController {
  final totalImpactScore = 4250.obs;
  final contributionLevel = 'Silver Contributor'.obs;
  final progressToGold = 0.65.obs;

  final List<Map<String, dynamic>> activeMissions = [
    {
      'title': 'Sliver Architecture Audit',
      'reward': '500 pts',
      'difficulty': 'Hard',
      'category': 'Engineering',
      'icon': Icons.architecture,
      'color': const Color(0xFFE11D48),
    },
    {
      'title': 'Wisdom Rule Documentation',
      'reward': '200 pts',
      'difficulty': 'Easy',
      'category': 'Documentation',
      'icon': Icons.edit_document,
      'color': const Color(0xFFFB7185),
    },
    {
      'title': 'Be-You UX Research',
      'reward': '350 pts',
      'difficulty': 'Medium',
      'category': 'Design',
      'icon': Icons.brush,
      'color': const Color(0xFFF43F5E),
    },
    {
      'title': 'Sovereign Setup Feedback',
      'reward': '150 pts',
      'difficulty': 'Easy',
      'category': 'QA',
      'icon': Icons.verified_user,
      'color': const Color(0xFFB91C1C),
    },
  ].obs;

  void submitContribution() {
    Get.snackbar(
      "Submission Received",
      "Your contribution is under review by the AIR Council.",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFFE11D48),
      colorText: Colors.white,
    );
  }
}
