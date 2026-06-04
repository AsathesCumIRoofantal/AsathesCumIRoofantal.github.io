import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebAnomaliesOpenController extends GetxController {
  final openAnomalyCount = 7.obs;
  final criticalAlerts = 2.obs;

  final List<Map<String, dynamic>> openAnomalies = [
    {
      'id': 'S-991',
      'type': 'Sliver-Fragment',
      'severity': 'Critical',
      'desc':
          'Unexplained ghost-rendering occurring in the Profile-Reward transition.',
      'discovered': '1 hour ago',
      'priority': 1,
      'color': const Color(0xFFB91C1C),
    },
    {
      'id': 'S-204',
      'type': 'Data-Drift',
      'severity': 'High',
      'desc':
          'Network latency spikes detected in the Global API Mesh (Node-Gamma).',
      'discovered': '4 hours ago',
      'priority': 2,
      'color': const Color(0xFFEF4444),
    },
    {
      'id': 'S-772',
      'type': 'Persona-Clash',
      'severity': 'Medium',
      'desc':
          'Concurrent state updates causing flicker in "Be-You" Persona selection.',
      'discovered': '12 hours ago',
      'priority': 3,
      'color': const Color(0xFFF87171),
    },
    {
      'id': 'S-009',
      'type': 'Cache-Void',
      'severity': 'Low',
      'desc': 'Minor misalignment in the footer of the Setup-Digitalize hub.',
      'discovered': '2 days ago',
      'priority': 4,
      'color': const Color(0xFFFDA47A),
    },
  ].obs;

  void claimAnomaly(String id) {
    Get.snackbar(
      "Anomaly Claimed",
      "You are now the lead investigator for $id. Good luck.",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFFE11D48),
      colorText: Colors.white,
    );
  }
}
