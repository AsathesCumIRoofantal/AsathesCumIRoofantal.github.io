import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebSkillsController extends GetxController {
  final List<Map<String, dynamic>> talentMatrix = [
    {
      'name': 'Sliver Architecture',
      'level': 0.95,
      'rank': 'Grandmaster',
      'color': const Color(0xFFE11D48),
    },
    {
      'name': 'Neural Syncing',
      'level': 0.70,
      'rank': 'Expert',
      'color': const Color(0xFFFB7185),
    },
    {
      'name': 'Quantum Logic',
      'level': 0.45,
      'rank': 'Adept',
      'color': const Color(0xFFF43F5E),
    },
    {
      'name': 'Sovereign Setup',
      'level': 0.88,
      'rank': 'Master',
      'color': const Color(0xFFB91C1C),
    },
  ].obs;

  void upgradeSkill(int index) {
    if (talentMatrix[index]['level'] < 1.0) {
      talentMatrix[index]['level'] += 0.05;
    }
  }
}
