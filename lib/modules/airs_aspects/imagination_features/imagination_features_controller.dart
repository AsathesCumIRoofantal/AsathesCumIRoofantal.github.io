import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FutureIdea {
  final String title;
  final String description;
  final IconData icon;

  FutureIdea({required this.title, required this.description, required this.icon});
}

class ImaginationFeaturesController extends GetxController {
  final ideas = <FutureIdea>[
    FutureIdea(title: "Holographic Inventory", description: "Visualize warehouse data in 3D AR space.", icon: Icons.view_in_ar_rounded),
    FutureIdea(title: "Neural Sync v2", description: "Direct cognitive data ingestion via neural-link.", icon: Icons.psychology_outlined),
    FutureIdea(title: "Teleport Logistics", description: "Instant material transfer across registry sectors.", icon: Icons.auto_awesome_rounded),
  ].obs;
}
