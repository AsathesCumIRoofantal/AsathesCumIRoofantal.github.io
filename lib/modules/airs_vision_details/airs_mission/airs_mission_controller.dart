import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MissionPillar {
  final String title;
  final String description;
  final IconData icon;

  MissionPillar({required this.title, required this.description, required this.icon});
}

class AirsMissionController extends GetxController {
  final pillars = <MissionPillar>[
    MissionPillar(title: "Global Connectivity", description: "Linking every industrial asset to a unified digital twin.", icon: Icons.language_rounded),
    MissionPillar(title: "Autonomous Governance", description: "Reducing human bias through algorithmic transparency.", icon: Icons.auto_awesome_rounded),
    MissionPillar(title: "Sustainable Growth", description: "Optimizing resource allocation for a zero-waste future.", icon: Icons.eco_outlined),
  ].obs;
}
