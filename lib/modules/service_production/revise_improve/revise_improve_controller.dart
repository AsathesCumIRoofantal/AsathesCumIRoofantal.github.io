import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedbackItem {
  final String title;
  final String suggestedChange;
  final String status;
  final String priority;

  FeedbackItem({required this.title, required this.suggestedChange, required this.status, required this.priority});
}

class ReviseImproveController extends GetxController {
  final feedbacks = <FeedbackItem>[
    FeedbackItem(title: "UI Contrast", suggestedChange: "Increase font weight on dashboard.", status: "Implementing", priority: "Medium"),
    FeedbackItem(title: "Sync Latency", suggestedChange: "Use WebSocket for real-time updates.", status: "Reviewed", priority: "High"),
    FeedbackItem(title: "Dark Mode", suggestedChange: "Add OLED black theme option.", status: "Pending", priority: "Low"),
  ].obs;

  void submitImprovement() {
    Get.snackbar("Improvement Logged", "Your suggestion has been added to the revision queue.");
  }
}
