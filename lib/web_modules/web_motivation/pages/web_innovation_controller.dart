import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebInnovationController extends GetxController {
  final List<Map<String, dynamic>> sparks = [
    {
      'idea': 'Sliver-Mesh V3',
      'impact': 'High',
      'category': 'Architecture',
      'color': const Color(0xFFEC4899),
    },
    {
      'idea': 'Neural-Input',
      'impact': 'Critical',
      'category': 'UX',
      'color': const Color(0xFFFB7185),
    },
    {
      'idea': 'Quantum-Symmetry',
      'impact': 'Medium',
      'category': 'Logic',
      'color': const Color(0xFFF43F5E),
    },
  ].obs;
}
