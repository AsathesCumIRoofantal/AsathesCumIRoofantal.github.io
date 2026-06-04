import 'package:get/get.dart';
import 'package:flutter/material.dart';

class EaseTool {
  final String name;
  final String description;
  final IconData icon;
  final Color color;

  EaseTool({
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
  });
}

class EaseToolsController extends GetxController {
  final tools = <EaseTool>[
    EaseTool(
      name: 'Rapid Converter',
      description: 'Convert data formats instantly between JSON, XML, and CSV.',
      icon: Icons.swap_horiz_rounded,
      color: Colors.blue,
    ),
    EaseTool(
      name: 'Smart Search',
      description: 'Global search across all AIR modules with AI indexing.',
      icon: Icons.search_rounded,
      color: Colors.purple,
    ),
    EaseTool(
      name: 'Auto Documentation',
      description: 'Generate professional docs from your activity logs.',
      icon: Icons.auto_fix_high_rounded,
      color: Colors.orange,
    ),
    EaseTool(
      name: 'Task Scheduler',
      description: 'Automate repetitive tasks with periodic triggers.',
      icon: Icons.timer_rounded,
      color: Colors.green,
    ),
    EaseTool(
      name: 'Analytics Pro',
      description: 'Visual insights into your productivity and earnings.',
      icon: Icons.analytics_rounded,
      color: Colors.red,
    ),
    EaseTool(
      name: 'Collaboration Sync',
      description: 'Real-time synchronization for team projects.',
      icon: Icons.sync_rounded,
      color: Colors.teal,
    ),
  ].obs;
}
