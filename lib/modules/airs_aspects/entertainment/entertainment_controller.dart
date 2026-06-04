import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EntertainmentActivity {
  final String title;
  final String type;
  final String status;
  final IconData icon;

  EntertainmentActivity({required this.title, required this.type, required this.status, required this.icon});
}

class EntertainmentController extends GetxController {
  final activities = <EntertainmentActivity>[
    EntertainmentActivity(title: "Virtual Reality Tour", type: "Simulation", status: "Available", icon: Icons.vrpano_outlined),
    EntertainmentActivity(title: "Industrial Chess", type: "Game", status: "Live", icon: Icons.grid_view_outlined),
    EntertainmentActivity(title: "Retro Arcade", type: "Games", status: "Offline", icon: Icons.videogame_asset_outlined),
  ].obs;
}
