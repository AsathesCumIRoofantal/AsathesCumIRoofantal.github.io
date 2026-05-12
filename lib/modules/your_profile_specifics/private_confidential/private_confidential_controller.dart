import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfidentialFile {
  final String name;
  final String accessLevel;
  final String status;

  ConfidentialFile({required this.name, required this.accessLevel, required this.status});
}

class PrivateConfidentialController extends GetxController {
  final files = <ConfidentialFile>[
    ConfidentialFile(name: "PROJECT_NEBULA_BLUEPRINTS.enc", accessLevel: "Level 5", status: "Encrypted"),
    ConfidentialFile(name: "FINANCIAL_PROJECTIONS_2026.enc", accessLevel: "Executive", status: "Locked"),
  ].obs;

  void authenticate() {
    Get.snackbar("Security Access", "Requesting biometric authorization...");
  }
}
