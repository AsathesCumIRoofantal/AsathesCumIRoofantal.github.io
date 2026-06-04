import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebNewInAirController extends GetxController {
  final trendScore = 88.5.obs;
  final isHot = true.obs;

  final List<Map<String, dynamic>> newFeatures = [
    {
      'title': 'Sliver-Mesh V2',
      'tag': 'Performance',
      'desc':
          'Zero-latency scrolling for datasets exceeding 1 million entries.',
      'date': '2 days ago',
      'impact': 'High',
      'icon': Icons.bolt,
      'color': const Color(0xFFE11D48),
    },
    {
      'title': 'Neural Persona Sync',
      'tag': 'AI',
      'desc':
          'Automatic identity alignment between Be-You and Profile modules.',
      'date': '5 days ago',
      'impact': 'Medium',
      'icon': Icons.psychology,
      'color': const Color(0xFFFB7185),
    },
    {
      'title': 'Holographic Vaults',
      'tag': 'Security',
      'desc': 'Quantum-encrypted storage for confidential identity markers.',
      'date': '1 week ago',
      'impact': 'Critical',
      'icon': Icons.lock_person,
      'color': const Color(0xFFB91C1C),
    },
  ].obs;
}
