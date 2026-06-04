import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LiabilityItem {
  final String title;
  final String consequence;
  final IconData icon;

  LiabilityItem({required this.title, required this.consequence, required this.icon});
}

class ResponsibilitiesController extends GetxController {
  final liabilities = <LiabilityItem>[
    LiabilityItem(
      title: "Data Integrity Breach",
      consequence: "Immediate suspension of sync privileges.",
      icon: Icons.gpp_maybe_rounded,
    ),
    LiabilityItem(
      title: "Unauthorized Access",
      consequence: "Formal inquiry and potential legal escalation.",
      icon: Icons.security_rounded,
    ),
    LiabilityItem(
      title: "Misuse of AI Tools",
      consequence: "Revocation of advanced computational credits.",
      icon: Icons.psychology_alt_rounded,
    ),
  ].obs;
}
