import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpertiseCourse {
  final String title;
  final String difficulty;
  final int duration;
  final bool isCompleted;

  ExpertiseCourse({required this.title, required this.difficulty, required this.duration, this.isCompleted = false});
}

class PracticeExpertiseController extends GetxController {
  final courses = <ExpertiseCourse>[
    ExpertiseCourse(title: "Advanced Data Parsing", difficulty: "Expert", duration: 120, isCompleted: true),
    ExpertiseCourse(title: "Network Security 101", difficulty: "Beginner", duration: 45, isCompleted: false),
    ExpertiseCourse(title: "AI Model Tuning", difficulty: "Advanced", duration: 90, isCompleted: false),
  ].obs;

  void enrollInCourse(String title) {
    Get.snackbar("Enrolled", "Starting your training session for $title...");
  }
}
