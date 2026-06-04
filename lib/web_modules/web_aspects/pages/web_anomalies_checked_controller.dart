import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebAnomaliesCheckedController extends GetxController {
  final stabilityIndex = 99.98.obs;
  final totalResolved = 142.obs;

  final List<Map<String, dynamic>> resolvedAnomalies = [
    {
      'id': 'S-001',
      'type': 'Sliver-Leak',
      'severity': 'Critical',
      'issue': 'Memory overflow during 1M+ item scroll in Profile view.',
      'resolution': 'Implemented a custom Sliver-Proxy cache layer.',
      'date': 'Oct 12',
      'color': const Color(0xFFE11D48),
    },
    {
      'id': 'S-042',
      'type': 'Neural-Sync Error',
      'severity': 'Medium',
      'issue': 'Identity persona mismatch between Be-You and Global Profile.',
      'resolution': 'Unified the Reactive-State stream across modules.',
      'date': 'Nov 05',
      'color': const Color(0xFFFB7185),
    },
    {
      'id': 'S-109',
      'type': 'UI-Jank',
      'severity': 'Low',
      'issue': 'Frame drops during Impeller transition in Air Space.',
      'sliver_fix': 'Optimized GPU shader pre-compilation.',
      'resolution': 'Applied a global 120fps lock via RepaintBoundary.',
      'date': 'Dec 01',
      'color': const Color(0xFFF43F5E),
    },
  ].obs;
}
