import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebLimitsController extends GetxController {
  // --- The Binary State ---
  final isInfiniteMode = false.obs; // false = 0 (Minimal), true = 1 (Infinite)

  // --- Limit Categories ---
  final List<Map<String, dynamic>> limitsData = [
    {
      'title': 'Sovereignty Threshold',
      'limit0': 'Restricted to local node.',
      'limit1': 'Global network override enabled.',
      'icon': Icons.lock_open_rounded,
      'color': const Color(0xFFE11D48),
    },
    {
      'title': 'Data Ingestion Cap',
      'limit0': '100 MB / day.',
      'limit1': 'Unlimited Neural Streaming.',
      'icon': Icons.cloud_download_rounded,
      'color': const Color(0xFFFB7185),
    },
    {
      'title': 'Identity Projection',
      'limit0': 'Single Persona active.',
      'limit1': 'Multi-Persona simultaneous broadcast.',
      'icon': Icons.people_alt_rounded,
      'color': const Color(0xFFF43F5E),
    },
    {
      'title': 'Computational Budget',
      'limit0': 'Shared Cluster access.',
      'limit1': 'Dedicated Quantum Core allocation.',
      'icon': Icons.computer,
      'color': const Color(0xFFB91C1C),
    },
  ].obs;

  void toggleLimit() {
    isInfiniteMode.value = !isInfiniteMode.value;
    Get.snackbar(
      isInfiniteMode.value ? "Mode: 1" : "Mode: 0",
      isInfiniteMode.value
          ? "Infinite constraints removed."
          : "Returning to minimal baseline.",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFFE11D48),
      colorText: Colors.white,
    );
  }
}
