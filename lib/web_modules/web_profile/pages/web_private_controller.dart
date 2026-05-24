import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebPrivateController extends GetxController {
  // --- Security State ---
  final isUnlocked = false.obs;
  final isAuthenticating = false.obs;
  final accessLevel = 'Level 5 (Omega)'.obs;

  // --- Confidential Data (Encrypted Files) ---
  final List<Map<String, dynamic>> secureFiles = [
    {
      'fileName': 'Personal_Identity_Core.vault',
      'description': 'Deep-layer identity markers and neural-link hashes.',
      'size': '2.4 GB',
      'sensitivity': 'Critical',
      'color': const Color(0xFFEF4444), // Red
      'lastAccessed': '2 days ago',
    },
    {
      'fileName': 'Private_Financial_Ledger.enc',
      'description': 'Off-shore asset distribution and credit-vault keys.',
      'size': '112 MB',
      'sensitivity': 'High',
      'color': const Color(0xFFF59E0B), // Amber
      'lastAccessed': '1 week ago',
    },
    {
      'fileName': 'Confidential_Collaborations.pdf',
      'description': 'Non-disclosure agreements and secret partner contracts.',
      'size': '45 MB',
      'sensitivity': 'Medium',
      'color': const Color(0xFF3B82F6), // Blue
      'lastAccessed': '1 month ago',
    },
    {
      'fileName': 'System_Override_Codes.txt',
      'description':
          'Emergency bypass codes for the AIR-Sliver infrastructure.',
      'size': '1.2 KB',
      'sensitivity': 'Omega',
      'color': const Color(0xFF7C3AED), // Violet
      'lastAccessed': 'Never',
    },
  ].obs;

  // Simulate Biometric Authentication
  void authenticate() async {
    isAuthenticating.value = true;
    // Simulate a 2-second biometric scan
    await Future.delayed(const Duration(seconds: 2));
    isUnlocked.value = true;
    isAuthenticating.value = false;

    Get.snackbar(
      "Access Granted",
      "Welcome back, Administrator. Your session is now encrypted.",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF059669),
      colorText: Colors.white,
    );
  }

  void lockVault() {
    isUnlocked.value = false;
  }
}
