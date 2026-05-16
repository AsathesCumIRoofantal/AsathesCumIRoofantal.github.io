import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Reward {
  final String title;
  final int points;
  final String reason;
  final String category;
  final DateTime date;

  Reward({
    required this.title,
    required this.points,
    required this.reason,
    required this.category,
    required this.date,
  });
}

class RewardsCreditsController extends GetxController {
  final rewards = <Reward>[
    Reward(
      title: "Early Bird",
      points: 50,
      reason: "First login of the day",
      category: "Daily",
      date: DateTime.now(),
    ),
    Reward(
      title: "Bug Hunter",
      points: 250,
      reason: "Reported critical UI glitch",
      category: "Achievement",
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Reward(
      title: "Team Player",
      points: 150,
      reason: "Assisted in Project Nebula",
      category: "Social",
      date: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Reward(
      title: "Knowledge Master",
      points: 100,
      reason: "Completed Security Quiz",
      category: "Learning",
      date: DateTime.now().subtract(const Duration(days: 10)),
    ),
    Reward(
      title: "App Anniversary",
      points: 500,
      reason: "One year of excellence",
      category: "Milestone",
      date: DateTime.now().subtract(const Duration(days: 15)),
    ),
  ].obs;

  final titleController = TextEditingController();
  final pointsController = TextEditingController();
  final reasonController = TextEditingController();
  var selectedCategory = "General".obs;

  void addManualReward() {
    if (titleController.text.isNotEmpty && pointsController.text.isNotEmpty) {
      rewards.insert(
        0,
        Reward(
          title: titleController.text,
          points: int.tryParse(pointsController.text) ?? 0,
          reason: reasonController.text,
          category: selectedCategory.value,
          date: DateTime.now(),
        ),
      );

      titleController.clear();
      pointsController.clear();
      reasonController.clear();

      Get.back();
      Get.snackbar(
        "Reward Issued",
        "Points have been credited successfully.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.amber.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
    } else {
      Get.snackbar("Error", "Please fill required fields");
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    pointsController.dispose();
    reasonController.dispose();
    super.onClose();
  }
}
