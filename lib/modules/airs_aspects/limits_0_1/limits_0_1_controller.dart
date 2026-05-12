import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SystemLimit {
  final String title;
  final String description;
  final double threshold;

  SystemLimit({required this.title, required this.description, required this.threshold});
}

class Limits01Controller extends GetxController {
  final limits = <SystemLimit>[
    SystemLimit(title: "Binary Integrity", description: "Ensuring zero-data corruption across the network.", threshold: 0.99),
    SystemLimit(title: "Processing Delta", description: "Minimal latency variance allowed for real-time sync.", threshold: 0.05),
    SystemLimit(title: "Security Perimeter", description: "Maximum allowable anomalous packets before lockdown.", threshold: 0.01),
  ].obs;
}
