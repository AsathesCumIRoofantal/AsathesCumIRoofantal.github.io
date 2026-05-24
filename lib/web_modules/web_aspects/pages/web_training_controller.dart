import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebTrainingController extends GetxController {
  final currentModule = 'Advanced Sliver-Proxying'.obs;
  final completionRate = 0.68.obs;

  final List<Map<String, dynamic>> curriculum = [
    {
      'title': 'The Basics of AIR',
      'status': 'Completed',
      'duration': '2h',
      'icon': Icons.play_circle_fill,
    },
    {
      'title': 'Reactive State Masters',
      'status': 'Completed',
      'duration': '5h',
      'icon': Icons.bolt,
    },
    {
      'title': 'Advanced Sliver-Proxying',
      'status': 'In-Progress',
      'duration': '8h',
      'icon': Icons.layers,
    },
    {
      'title': 'Neural Mesh Architecture',
      'status': 'Locked',
      'duration': '12h',
      'icon': Icons.hub,
    },
    {
      'title': 'Sovereign System Design',
      'status': 'Locked',
      'duration': '15h',
      'icon': Icons.shield,
    },
  ].obs;
}
