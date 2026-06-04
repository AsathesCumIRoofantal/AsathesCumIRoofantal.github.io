import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebNetworkApisController extends GetxController {
  // --- Global Network Stats ---
  final globalLatency = 24.5.obs; // ms
  final totalRequests = 1240500.0.obs;
  final systemUptime = 99.98.obs;

  // --- API Node Data ---
  final List<Map<String, dynamic>> apiNodes = [
    {
      'name': 'Core Identity Engine',
      'endpoint': 'https://api.airspace.io/v1/identity',
      'key': 'ask_live_8821_x9210',
      'status': 'Online', // Online, Degraded, Offline
      'health': 0.98,
      'callsPerMin': 1200,
      'category': 'Primary',
      'color': const Color(0xFF7C3AED),
    },
    {
      'name': 'Collaborative Stream',
      'endpoint': 'https://api.airspace.io/v1/collab',
      'key': 'collab_sync_4410_p22',
      'status': 'Online',
      'health': 0.92,
      'callsPerMin': 850,
      'category': 'Secondary',
      'color': const Color(0xFFC084FC),
    },
    {
      'name': 'Sliver Cache Proxy',
      'endpoint': 'https://cache.airspace.io/v2/proxy',
      'key': 'cache_fast_1102_z99',
      'status': 'Degraded',
      'health': 0.65,
      'callsPerMin': 4200,
      'category': 'System',
      'color': const Color(0xFFF59E0B),
    },
    {
      'name': 'Neural Search API',
      'endpoint': 'https://api.airspace.io/v1/neural',
      'key': 'search_ai_7732_k11',
      'status': 'Online',
      'health': 0.99,
      'callsPerMin': 310,
      'category': 'AI',
      'color': const Color(0xFF8B5CF6),
    },
  ].obs;

  void rotateKey(int index) {
    // Simulation of API key rotation
    apiNodes[index]['key'] = 'rot_${DateTime.now().millisecondsSinceEpoch}';
    Get.snackbar(
      "Security",
      "API Key for ${apiNodes[index]['name']} rotated successfully.",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black87,
      colorText: Colors.white,
    );
  }
}
