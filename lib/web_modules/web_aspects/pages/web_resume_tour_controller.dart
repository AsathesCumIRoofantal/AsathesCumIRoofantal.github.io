import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebResumeTourController extends GetxController {
  // --- Progress Metrics ---
  final totalStops = 12.obs;
  final completedStops = 4.obs;
  final tourPercentage = 33.3.obs; // (4/12)*100
  final currentStopIndex = 4.obs;

  // --- Tour Roadmap Data ---
  final List<Map<String, dynamic>> tourStops = [
    {
      'title': 'The Genesis Gate',
      'desc': 'Introduction to the AIR architecture and core vision.',
      'status': 'completed', // completed, current, locked
      'icon': Icons.door_front_door_outlined,
      'timeSpent': '15 mins',
    },
    {
      'title': 'Sliver Space Station',
      'desc': 'Exploring how the web layer handles massive data flows.',
      'status': 'completed',
      'icon': Icons.rocket_launch_rounded,
      'timeSpent': '45 mins',
    },
    {
      'title': 'Identity Forge',
      'desc': 'Creating and managing your multiple personas in Be-You.',
      'status': 'completed',
      'icon': Icons.face_retouching_natural,
      'timeSpent': '30 mins',
    },
    {
      'title': 'The Wisdom Vault',
      'desc': 'Learning the internal rules that govern the system.',
      'status': 'completed',
      'icon': Icons.auto_stories_rounded,
      'timeSpent': '60 mins',
    },
    {
      'title': 'Neural Network Hub',
      'desc': 'Understanding API connectivity and global reach.',
      'status': 'current',
      'icon': Icons.hub_rounded,
      'timeSpent': '0 mins',
    },
    {
      'title': 'The Reward Prism',
      'desc': 'How to earn and redeem credits in the AIR economy.',
      'status': 'locked',
      'icon': Icons.card_giftcard_rounded,
      'timeSpent': '0 mins',
    },
    {
      'title': 'Sovereign Setup',
      'desc': 'Configuring the professional environment for peak efficiency.',
      'status': 'locked',
      'icon': Icons.settings_suggest_rounded,
      'timeSpent': '0 mins',
    },
    {
      'title': 'The Final Horizon',
      'desc': 'Completion of the tour and certification of AIR-mastery.',
      'status': 'locked',
      'icon': Icons.flag_rounded,
      'timeSpent': '0 mins',
    },
  ].obs;

  void resumeTour() {
    Get.snackbar(
      "Tour Resumed",
      "Welcome back! Navigating to ${tourStops[currentStopIndex.value]['title']}...",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFFE11D48),
      colorText: Colors.white,
    );
    // In real app: Navigate to the specific module
  }
}
