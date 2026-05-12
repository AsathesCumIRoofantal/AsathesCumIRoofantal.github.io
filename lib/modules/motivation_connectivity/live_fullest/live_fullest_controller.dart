import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WellnessTip {
  final String title;
  final String description;
  final IconData icon;

  WellnessTip({required this.title, required this.description, required this.icon});
}

class LiveFullestController extends GetxController {
  final tips = <WellnessTip>[
    WellnessTip(title: "Deep Breathing", description: "Take 5 minutes every hour to reset your focus.", icon: Icons.air_rounded),
    WellnessTip(title: "Hydration Sync", description: "Drink 2.5L of water to maintain optimal cognitive load.", icon: Icons.water_drop_outlined),
    WellnessTip(title: "Mental Detox", description: "Disconnect from the industrial feed for 30 minutes daily.", icon: Icons.phonelink_off_outlined),
  ].obs;
}
