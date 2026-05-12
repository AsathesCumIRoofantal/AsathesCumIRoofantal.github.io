import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrainingModule {
  final String title;
  final String category;
  final double progress;

  TrainingModule({required this.title, required this.category, required this.progress});
}

class TrainingController extends GetxController {
  final modules = <TrainingModule>[
    TrainingModule(title: "Registry Protocol", category: "Core", progress: 1.0),
    TrainingModule(title: "Anomaly Detection", category: "Security", progress: 0.65),
    TrainingModule(title: "Direct Ingestion", category: "Technical", progress: 0.2),
  ].obs;
}
