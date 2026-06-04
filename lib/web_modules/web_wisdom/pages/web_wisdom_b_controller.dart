import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebWisdomBController extends GetxController {
  final isLoading = false.obs;

  // Mock data for the "Internal Wisdom" categories
  final List<Map<String, dynamic>> wisdomCategories = [
    {
      'title': 'The Core Axioms',
      'description': 'The fundamental truths that govern the AIR space logic.',
      'items': [
        'Integrity over Velocity',
        'Collaborativeism',
        'Sovereignty of Knowledge',
      ],
      'icon': Icons.auto_awesome_mosaic,
    },
    {
      'title': 'Operational Rules',
      'description': 'Guidelines for interaction and systemic maintenance.',
      'items': [
        'Asynchronous First',
        'Documentation as Code',
        'Zero-Debt Architecture',
      ],
      'icon': Icons.gavel_rounded,
    },
    {
      'title': 'Ethical Framework',
      'description':
          'The moral compass guiding the evolution of the organization.',
      'items': [
        'Radical Transparency',
        'Universal Accessibility',
        'Inclusive Evolution',
      ],
      'icon': Icons.shield_rounded,
    },
  ].obs;
}
