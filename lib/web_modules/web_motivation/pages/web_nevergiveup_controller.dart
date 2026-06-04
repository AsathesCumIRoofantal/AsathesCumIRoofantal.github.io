import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebNeverGiveUpController extends GetxController {
  final List<Map<String, dynamic>> milestones = [
    {
      'title': 'The First Fall',
      'lesson': 'Failure is just a lapped data point for future success.',
      'color': Colors.grey,
    },
    {
      'title': 'The Grit Phase',
      'lesson': 'Consistency beats intensity every single time.',
      'color': Colors.pink[300],
    },
    {
      'title': 'The Breakthrough',
      'lesson': 'The final push is where the real transformation happens.',
      'color': const Color(0xFFEC4899),
    },
  ].obs;
}
