import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ValueItem {
  final String title;
  final String description;
  final IconData icon;

  ValueItem({required this.title, required this.description, required this.icon});
}

class BeliefsValuesController extends GetxController {
  final values = <ValueItem>[
    ValueItem(title: "Transparency", description: "Open and accessible data for all registered entities.", icon: Icons.visibility_outlined),
    ValueItem(title: "Accountability", description: "Every action is logged and verifiable via the AIR ledger.", icon: Icons.verified_user_outlined),
    ValueItem(title: "Efficiency", description: "Automation first approach to minimize industrial friction.", icon: Icons.bolt_outlined),
    ValueItem(title: "Security", description: "State-of-the-art encryption to protect organizational assets.", icon: Icons.security_outlined),
    ValueItem(title: "Collaboration", description: "Fostering partnerships to drive global industrial growth.", icon: Icons.handshake_outlined),
  ].obs;
}
