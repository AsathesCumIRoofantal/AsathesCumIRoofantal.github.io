import 'package:get/get.dart';
import 'package:flutter/material.dart';

class DigitizedRecord {
  final String id;
  final String name;
  final String type;
  final DateTime date;
  final String size;
  final String status;

  DigitizedRecord({
    required this.id,
    required this.name,
    required this.type,
    required this.date,
    required this.size,
    required this.status,
  });
}

class DigitalizeRecordsController extends GetxController {
  final records = <DigitizedRecord>[
    DigitizedRecord(
      id: "REC-001",
      name: "Annual Space Budget 2025",
      type: "PDF",
      date: DateTime.now().subtract(const Duration(days: 1)),
      size: "2.4 MB",
      status: "Verified",
    ),
    DigitizedRecord(
      id: "REC-002",
      name: "Nebula Research Findings",
      type: "DOCX",
      date: DateTime.now().subtract(const Duration(days: 3)),
      size: "1.1 MB",
      status: "Processing",
    ),
    DigitizedRecord(
      id: "REC-003",
      name: "Community Engagement Report",
      type: "PDF",
      date: DateTime.now().subtract(const Duration(days: 7)),
      size: "4.8 MB",
      status: "Verified",
    ),
  ].obs;

  void digitalizeNewRecord() {
    Get.snackbar(
      "Digitalizing",
      "Scanning and processing new document...",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue.withOpacity(0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }
}
