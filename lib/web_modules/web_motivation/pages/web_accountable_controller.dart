import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebAccountableController extends GetxController {
  final List<Map<String, dynamic>> responsibilities = [
    {
      'action': 'Sliver Optimization',
      'accountability': 'Zero-Lag Interface',
      'status': 'Verified',
      'color': const Color(0xFFEC4899),
    },
    {
      'action': 'Wisdom Axioms',
      'accountability': 'Ethical Framework',
      'status': 'Under Review',
      'color': const Color(0xFFFB7185),
    },
  ].obs;
}
