import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebRecordedRewardedController extends GetxController {
  final totalMerits = 15200.obs;
  final rewardMultiplier = 1.5.obs;

  final List<Map<String, dynamic>> recordStream = [
    {
      'action': 'Sliver Logic Contribution',
      'reward': 500,
      'date': '10m ago',
      'icon': Icons.code,
      'color': const Color(0xFFE11D48),
    },
    {
      'action': 'Wisdom Axiom Definition',
      'reward': 200,
      'date': '2h ago',
      'icon': Icons.book,
      'color': const Color(0xFFFB7185),
    },
    {
      'action': 'System Anomaly Report',
      'reward': 1000,
      'date': '1d ago',
      'icon': Icons.warning,
      'color': const Color(0xFFF43F5E),
    },
    {
      'action': 'Community Peer Review',
      'reward': 300,
      'date': '3d ago',
      'icon': Icons.people,
      'color': const Color(0xFFB91C1C),
    },
  ].obs;
}
