import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebCommunicationController extends GetxController {
  final signalStrength = 82.obs; // percentage
  final activeNodes = 14.obs;
  final currentMode = 'Neural'.obs; // Quantum, Neural, Classic

  final List<Map<String, dynamic>> signalBursts = [
    {
      'sender': 'Sovereign Alpha',
      'message':
          'Sliver-Symmetry updates have been deployed to the Core. Please verify.',
      'timestamp': '2m ago',
      'type': 'Official',
      'priority': 'High',
      'color': const Color(0xFFE11D48),
    },
    {
      'sender': 'Identity Hub',
      'message':
          'New persona alignment detected. Syncing your "Be-You" profile...',
      'timestamp': '15m ago',
      'type': 'System',
      'priority': 'Medium',
      'color': const Color(0xFFFB7185),
    },
    {
      'sender': 'Research Team',
      'message':
          'The Quantum-Sliver thesis is now available for peer review in Wisdom.',
      'timestamp': '1h ago',
      'type': 'Collaborative',
      'priority': 'Low',
      'color': const Color(0xFFF43F5E),
    },
    {
      'sender': 'Security Node 7',
      'message':
          'Unauthorized ping detected in the Private Vault. No breach occurred.',
      'timestamp': '3h ago',
      'type': 'Alert',
      'priority': 'Critical',
      'color': const Color(0xFFB91C1C),
    },
  ].obs;

  void setMode(String mode) {
    currentMode.value = mode;
    Get.snackbar(
      "Mode Switched",
      "Communication channel shifted to $mode transmission.",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFFE11D48),
      colorText: Colors.white,
    );
  }
}
