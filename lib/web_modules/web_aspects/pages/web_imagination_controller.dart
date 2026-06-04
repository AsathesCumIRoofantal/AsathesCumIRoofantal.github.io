import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebImaginationController extends GetxController {
  // --- Interaction Stats ---
  final totalImaginations = 142.obs;
  final implementedFeatures = 58.obs;

  // --- Feature Database ---
  final List<Map<String, dynamic>> features = [
    {
      'title': 'Sliver-Symmetry AI',
      'desc':
          'AI that automatically organizes your UI based on the visual weight of content.',
      'status': 'Implemented', // Implemented, In-Beta, Imagined
      'votes': 1240,
      'category': 'Architecture',
      'icon': Icons.auto_awesome,
      'color': const Color(0xFFE11D48),
    },
    {
      'title': 'Neural-Haptic Feedback',
      'desc':
          'Direct neural-link haptics that let you "feel" the layout density through the screen.',
      'status': 'Imagined',
      'votes': 450,
      'category': 'UX',
      'icon': Icons.touch_app,
      'color': const Color(0xFFFB7185),
    },
    {
      'title': 'Infinite-Scroll Portal',
      'desc':
          'A 3D tunnel transition when navigating between high-level AIR sections.',
      'status': 'In-Beta',
      'votes': 890,
      'category': 'Animation',
      'icon': Icons.flip, // Simulated icon
      'color': const Color(0xFFF43F5E),
    },
    {
      'title': 'Quantum State-Casting',
      'desc':
          'The ability to launder state across different identities in real-time without lag.',
      'status': 'Imagined',
      'votes': 310,
      'category': 'State Management',
      'icon': Icons.manage_search, // Simulated icon
      'color': const Color(0xFFB91C1C),
    },
    {
      'title': 'Voice-to-Sliver UI',
      'desc':
          'Describe a page layout verbally, and the system generates the Sliver-architecture.',
      'status': 'In-Beta',
      'votes': 1100,
      'category': 'AI',
      'icon': Icons.mic,
      'color': const Color(0xFFE11D48),
    },
  ].obs;

  void voteForFeature(int index) {
    features[index]['votes']++;
    Get.snackbar(
      "Vote Cast",
      "Your imagination has been recorded in the Forge.",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFFE11D48),
      colorText: Colors.white,
    );
  }
}
