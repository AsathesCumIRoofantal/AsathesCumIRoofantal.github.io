import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebWindupController extends GetxController {
  final totalTimeSpent = '14h 22m'.obs;
  final modulesCompleted = 12.obs;
  final totalInsightsGained = 450.obs;

  void finalizeSession() {
    Get.snackbar(
      "Session Closed",
      "Your journey state has been archived in the Sliver-Vault.",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFFD4AF37),
      colorText: Colors.white,
    );
  }
}
