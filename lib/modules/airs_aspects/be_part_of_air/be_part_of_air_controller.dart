import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ParticipationPath {
  final String title;
  final String action;
  final IconData icon;

  ParticipationPath({required this.title, required this.action, required this.icon});
}

class BePartOfAirController extends GetxController {
  final paths = <ParticipationPath>[
    ParticipationPath(title: "Join as Individual", action: "REGISTER NOW", icon: Icons.person_add_alt_1_outlined),
    ParticipationPath(title: "Register as Organization", action: "GET VERIFIED", icon: Icons.business_outlined),
    ParticipationPath(title: "Associate Partner", action: "APPLY NOW", icon: Icons.handshake_outlined),
  ].obs;

  void handleAction(String title) {
    Get.snackbar("Joining AIR", "Initiating $title process...");
  }
}
