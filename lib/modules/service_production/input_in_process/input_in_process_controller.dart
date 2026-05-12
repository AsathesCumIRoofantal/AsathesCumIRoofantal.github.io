import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputTask {
  final String title;
  final String source;
  final String status;
  final double load;

  InputTask({required this.title, required this.source, required this.status, required this.load});
}

class InputInProcessController extends GetxController {
  final inputTasks = <InputTask>[
    InputTask(title: "Sensor Stream A", source: "Sector 4 Hub", status: "Ingesting", load: 0.75),
    InputTask(title: "Legacy PDF Batch", source: "Archive 01", status: "Queued", load: 0.2),
    InputTask(title: "User Biometrics", source: "Auth Portal", status: "Verifying", load: 0.95),
  ].obs;

  void startNewInput() {
    Get.snackbar("Input Started", "Initializing new data ingestion pipeline...");
  }
}
