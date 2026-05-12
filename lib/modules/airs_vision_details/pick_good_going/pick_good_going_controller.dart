import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HighlightItem {
  final String title;
  final String description;
  final IconData icon;

  HighlightItem({required this.title, required this.description, required this.icon});
}

class PickGoodGoingController extends GetxController {
  final highlights = <HighlightItem>[
    HighlightItem(title: "Efficiency Up 40%", description: "New OCR engine has significantly reduced manual data entry time.", icon: Icons.trending_up_rounded),
    HighlightItem(title: "Community Growth", description: "Over 10,000 active industrial partners joined AIR this month.", icon: Icons.groups_outlined),
    HighlightItem(title: "Security Milestone", description: "100 consecutive days with zero unauthorized access attempts.", icon: Icons.verified_user_outlined),
  ].obs;
}
