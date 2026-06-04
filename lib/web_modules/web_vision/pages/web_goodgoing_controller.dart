import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebGoodGoingController extends GetxController {
  final selectedPath = ''.obs;

  final List<Map<String, dynamic>> trajectories = [
    {
      'title': 'The Architect',
      'desc': 'Focus on infrastructure and systemic lapping.',
      'icon': Icons.architecture,
      'color': const Color(0xFFD4AF37),
    },
    {
      'title': 'The Sage',
      'desc': 'Deep dive into the Wisdom axioms and ethics.',
      'icon': Icons.auto_stories,
      'color': const Color(0xFFC5A028),
    },
    {
      'title': 'The Collaborator',
      'desc': 'Master the art of multi-persona synergy.',
      'icon': Icons.people,
      'color': const Color(0xFFB8860B),
    },
    {
      'title': 'The Vanguard',
      'desc': 'Leading the charge into the 2026 frontiers.',
      'icon': Icons.rocket_launch,
      'color': const Color(0xFFB9A35A),
    },
  ].obs;

  void pickPath(String path) {
    selectedPath.value = path;
    Get.snackbar(
      "Path Chosen",
      "You have set your trajectory toward $path. The AIR space will now align.",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFFD4AF37),
      colorText: Colors.white,
    );
  }
}
