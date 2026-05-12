import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimelineEvent {
  final String year;
  final String title;
  final String description;
  final IconData icon;

  TimelineEvent({required this.year, required this.title, required this.description, required this.icon});
}

class TimelineOfAirController extends GetxController {
  final events = <TimelineEvent>[
    TimelineEvent(year: "2024", title: "Inception", description: "The conceptual birth of the Automated Industrial Registry.", icon: Icons.lightbulb_outline),
    TimelineEvent(year: "2025", title: "Beta Phase", description: "First successful deployment in selected industrial zones.", icon: Icons.rocket_launch_outlined),
    TimelineEvent(year: "2026", title: "Global Expansion", description: "Integration of real-time asset tracking and community modules.", icon: Icons.public),
    TimelineEvent(year: "2027", title: "AI Integration", description: "Predictive maintenance and automated governance go live.", icon: Icons.psychology_outlined),
  ].obs;
}
