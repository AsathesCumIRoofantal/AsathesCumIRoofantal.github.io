import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SystemComponent {
  final String name;
  final String status;
  final double health;
  final IconData icon;

  SystemComponent({
    required this.name,
    required this.status,
    required this.health,
    required this.icon,
  });
}

class SystemAllTogetherController extends GetxController {
  final components = <SystemComponent>[
    SystemComponent(
      name: "Data Vault",
      status: "Synchronized",
      health: 1.0,
      icon: Icons.storage_rounded,
    ),
    SystemComponent(
      name: "Network Nodes",
      status: "Active",
      health: 0.92,
      icon: Icons.hub_outlined,
    ),
    SystemComponent(
      name: "AI Core",
      status: "Optimizing",
      health: 0.85,
      icon: Icons.psychology_outlined,
    ),
    SystemComponent(
      name: "User Feed",
      status: "Stable",
      health: 0.98,
      icon: Icons.rss_feed_rounded,
    ),
  ].obs;

  void restartSystem() {
    Get.snackbar(
      "System Restart",
      "Initiating global system synchronization...",
    );
  }
}
