import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebMaintenanceController extends GetxController {
  // --- System Health Metrics ---
  final systemHealth = 98.5.obs;
  final cpuLoad = 22.4.obs;
  final memoryUsage = 38.1.obs;
  final isScanning = true.obs;
  final networkLatency = 14.0.obs; // ms

  // --- Terminal Log Stream ---
  // This simulates a live system log
  final List<Map<String, String>> systemLogs = [
    {'time': '14:20:01', 'msg': 'Initializing AIR-S_Sliver_Pipeline...'},
    {'time': '14:20:03', 'msg': 'SliverAppBar parallax cache: [OPTIMIZED]'},
    {'time': '14:20:05', 'msg': 'Checking Impeller GPU Shaders... [Succeeded]'},
    {'time': '14:20:08', 'msg': 'Syncing Profile-Violet accent theme... [OK]'},
    {'time': '14:20:12', 'msg': 'Scanning for memory leaks in WebShell...'},
    {
      'time': '14:20:15',
      'msg': 'AI-Predictor: No anomalies detected in CPU cycles.',
    },
    {'time': '14:20:20', 'msg': 'Maintenance Cycle: STABLE'},
  ].obs;

  void toggleScan() {
    isScanning.value = !isScanning.value;
    if (isScanning.value) {
      Get.snackbar(
        "System",
        "Diagnostic Scan Started",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black87,
        colorText: Colors.white,
      );
    }
  }
}
