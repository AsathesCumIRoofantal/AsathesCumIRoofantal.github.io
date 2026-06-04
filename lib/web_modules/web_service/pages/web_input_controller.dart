import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebInputController extends GetxController {
  final isProcessing = true.obs;
  final currentLoad = 64.2.obs; // Percentage

  final RxList<Map<String, dynamic>> intakeQueue = [
    {
      'id': 'REQ-771',
      'source': 'Be-You Persona',
      'dataType': 'Neural-Map',
      'status': 'Analyzing', // Analyzing, Validating, Ingesting
      'progress': 0.45,
      'color': const Color(0xFF0D9488),
    },
    {
      'id': 'REQ-882',
      'source': 'Wisdom Axioms',
      'dataType': 'Text-Sliver',
      'status': 'Validating',
      'progress': 0.82,
      'color': const Color(0xFF14B8A6),
    },
    {
      'id': 'REQ-901',
      'source': 'Profile-Assets',
      'dataType': 'Binary-Vault',
      'status': 'Analyzing',
      'progress': 0.15,
      'color': const Color(0xFF0F766E),
    },
  ].obs;

  void simulateProgress() {
    // Logic to randomly increment progress of the first item
    int index = 0;
    if (intakeQueue[index]['progress'] < 1.0) {
      intakeQueue[index]['progress'] += 0.01;
      intakeQueue.refresh();
    }
  }
}
