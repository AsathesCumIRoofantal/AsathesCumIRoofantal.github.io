import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TechInnovation {
  final String title;
  final String status;
  final IconData icon;

  TechInnovation({required this.title, required this.status, required this.icon});
}

class InnovationKeyController extends GetxController {
  final innovations = <TechInnovation>[
    TechInnovation(title: "Quantum Ledger", status: "In Development", icon: Icons.auto_awesome_rounded),
    TechInnovation(title: "Decentralized AI", status: "Live", icon: Icons.psychology_outlined),
    TechInnovation(title: "Edge Sync v3", status: "Prototyping", icon: Icons.hub_outlined),
  ].obs;
}
