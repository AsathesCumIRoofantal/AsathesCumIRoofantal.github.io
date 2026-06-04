import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebCalendarController extends GetxController {
  final List<Map<String, dynamic>> timeline = [
    {
      'date': 'Jan 2024',
      'event': 'The Genesis of AIR',
      'desc': 'Sliver-Architecture v1.0 deployed.',
      'icon': Icons.rocket_launch,
    },
    {
      'date': 'Mar 2024',
      'event': 'Be-You Integration',
      'desc': 'Neural persona mapping enabled.',
      'icon': Icons.face,
    },
    {
      'date': 'June 2024',
      'event': 'Wisdom Expansion',
      'desc': 'Axioms of Sovereignty defined.',
      'icon': Icons.auto_stories,
    },
    {
      'date': 'Aug 2024',
      ' la': 'Air Space Launch',
      'desc': 'Global Hub for all identity nodes.',
      'icon': Icons.public,
    },
    {
      'date': 'Dec 2024',
      'event': 'The 2026 Preview',
      'desc': 'Sliver-Proxy and Impeller v2.0.',
      'icon': Icons.auto_awesome,
    },
  ].obs;
}
