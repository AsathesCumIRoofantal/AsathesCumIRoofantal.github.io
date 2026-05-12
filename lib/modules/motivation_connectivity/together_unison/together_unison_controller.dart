import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TeamProject {
  final String name;
  final String objective;
  final int members;

  TeamProject({required this.name, required this.objective, required this.members});
}

class TogetherUnisonController extends GetxController {
  final projects = <TeamProject>[
    TeamProject(name: "Operation Titan", objective: "Modernizing Sector 4 logistics.", members: 12),
    TeamProject(name: "Harmony Core", objective: "Unified communication protocol.", members: 8),
  ].obs;
}
