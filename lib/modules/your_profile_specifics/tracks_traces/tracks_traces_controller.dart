import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TraceRecord {
  final String id;
  final String objectName;
  final String location;
  final DateTime timestamp;

  TraceRecord({required this.id, required this.objectName, required this.location, required this.timestamp});
}

class TracksTracesController extends GetxController {
  final traces = <TraceRecord>[
    TraceRecord(id: "TRC-501", objectName: "Cargo Container B", location: "Dock 4", timestamp: DateTime.now()),
  ].obs;

  final objectController = TextEditingController();
  final locationController = TextEditingController();

  void addTrace() {
    if (objectController.text.isNotEmpty) {
      traces.add(TraceRecord(
        id: "TRC-${500 + traces.length + 1}",
        objectName: objectController.text,
        location: locationController.text,
        timestamp: DateTime.now(),
      ));
      objectController.clear();
      locationController.clear();
      Get.back();
      Get.snackbar("Trace Added", "Tracking data synchronized.");
    }
  }
}
