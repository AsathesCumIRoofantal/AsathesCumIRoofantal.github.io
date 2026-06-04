import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebPracticeController extends GetxController {
  final List<Map<String, dynamic>> masteryLevels = [
    {
      'skill': 'Deep Work',
      'progress': 0.8,
      'hours': '120h',
      'icon': Icons.timer,
    },
    {
      'skill': 'Sliver-Symmetry',
      'progress': 0.4,
      'hours': '45h',
      'icon': Icons.architecture,
    },
    {
      'skill': 'Sovereign Design',
      'progress': 0.6,
      'hours': '80h',
      'icon': Icons.auto_awesome,
    },
  ].obs;
}
