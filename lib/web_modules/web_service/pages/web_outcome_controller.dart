import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebOutcomeController extends GetxController {
  final totalProcessed = 1240.obs;
  final successRate = 99.4.obs;

  final RxList<Map<String, dynamic>> processedResults = [
    {
      'title': 'Identity Alignment',
      'input': 'Raw Bio-Data',
      'outcome': 'Unified Persona Matrix',
      'efficiency': 0.98,
      'timeTaken': '1.2s',
      'color': const Color(0xFF0D9488),
      'icon': Icons.check_circle_rounded,
    },
    {
      'title': 'Sliver Cache Optimize',
      'input': 'Unstructured JSON',
      'outcome': 'Indexed Sliver-Proxy',
      'efficiency': 0.85,
      'timeTaken': '0.4s',
      'color': const Color(0xFF14B8A6),
      'icon': Icons.bolt_rounded,
    },
    {
      'title': 'Wisdom Axiom Hash',
      'input': 'Natural Language',
      'outcome': 'Immutable Truth-Key',
      'efficiency': 0.99,
      'timeTaken': '2.1s',
      'color': const Color(0xFF0F766E),
      'icon': Icons.verified_user_rounded,
    },
    {
      'title': 'Network Mesh Sync',
      'input': 'Latent Pings',
      'outcome': 'Zero-Lag Topology',
      'efficiency': 0.72,
      'timeTaken': '0.9s',
      'color': const Color(0xFF0D9488),
      'icon': Icons.hub_rounded,
    },
  ].obs;
}
