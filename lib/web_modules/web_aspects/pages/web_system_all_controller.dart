import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebSystemAllController extends GetxController {
  final systemSynergy = 94.0.obs; // %

  final List<Map<String, dynamic>> systemOverview = [
    {
      'name': 'Core Essence',
      'status': 'Stable',
      'load': 0.2,
      'icon': Icons.settings_input_component,
    },
    {
      'name': 'User Persona',
      'status': 'Synced',
      'load': 0.4,
      'icon': Icons.face,
    },
    {
      'name': 'Sliver Engine',
      'status': 'Peak',
      'load': 0.1,
      'icon': Icons.layers,
    },
    {
      'name': 'Knowledge Mesh',
      'status': 'Expanding',
      'load': 0.7,
      'icon': Icons.hub,
    },
    {
      'name': 'Financial Logic',
      'status': 'Stable',
      'load': 0.3,
      'icon': Icons.payments,
    },
    {
      'name': 'Security Layer',
      'status': 'Encrypted',
      'load': 0.1,
      'icon': Icons.security,
    },
  ].obs;
}
