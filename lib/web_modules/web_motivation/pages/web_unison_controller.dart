import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebUnisonController extends GetxController {
  final List<Map<String, dynamic>> unisonCircles = [
    {
      'title': 'Collective Intelligence',
      'desc': 'When we think together, the lapped data doubles.',
      'color': const Color(0xFFEC4899),
    },
    {
      'title': 'Emotional Symmetry',
      'desc': 'Mirrored empathy leads to systemic stability.',
      'color': const Color(0xFFFB7185),
    },
    {
      'title': 'Unified Vision',
      'desc': 'One goal, shared across a thousand identities.',
      'color': const Color(0xFFF43F5E),
    },
  ].obs;
}
