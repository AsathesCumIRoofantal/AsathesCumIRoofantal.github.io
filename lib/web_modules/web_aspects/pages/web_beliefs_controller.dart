import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebBeliefsController extends GetxController {
  // Core beliefs of the AIR space
  final List<Map<String, dynamic>> beliefs = [
    {
      'axiom': 'Sovereignty',
      'title': 'Knowledge Independence',
      'desc':
          'Every individual possesses the absolute right to the ownership and evolution of their own cognitive assets.',
      'icon': Icons.lock_person_rounded,
      'color': const Color(0xFFE11D48),
      'depth': 'Core',
    },
    {
      'axiom': 'Symmetry',
      'title': 'Collaborative Equilibrium',
      'desc':
          'Value is not extracted, but mirrored. When one contributes to the mesh, the entire network elevates proportionally.',
      'icon': Icons.balance_rounded,
      'color': const Color(0xFFFB7185),
      'depth': 'Advanced',
    },
    {
      'axiom': 'Evolution',
      'title': 'Continuous Iteration',
      'desc':
          'Stagnation is the only failure. The system must evolve daily, reflecting the fluid nature of human imagination.',
      'icon': Icons.auto_graph_rounded,
      'color': const Color(0xFFF43F5E),
      'depth': 'Foundational',
    },
    {
      'axiom': 'Transparency',
      'title': 'The Glass Architecture',
      'desc':
          'Trust is built on visibility. All systemic rules are open, immutable, and verifiable by any node in the space.',
      'icon': Icons.visibility_rounded,
      'color': const Color(0xFFB91C1C),
      'depth': 'Core',
    },
  ].obs;
}
