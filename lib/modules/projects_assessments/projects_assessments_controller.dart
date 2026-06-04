import 'package:get/get.dart';

class Project {
  final String title;
  final String status;
  final double progress;
  final String deadline;

  Project({required this.title, required this.status, required this.progress, required this.deadline});
}

class Assessment {
  final String title;
  final int score;
  final String date;

  Assessment({required this.title, required this.score, required this.date});
}

class ProjectsAssessmentsController extends GetxController {
  final projects = <Project>[
    Project(title: "AI Integration Phase 1", status: "In Progress", progress: 0.65, deadline: "2026-06-15"),
    Project(title: "Database Migration", status: "Pending", progress: 0.1, deadline: "2026-07-01"),
    Project(title: "UI Overhaul", status: "Completed", progress: 1.0, deadline: "2026-05-10"),
  ].obs;

  final assessments = <Assessment>[
    Assessment(title: "Logic & Reasoning", score: 88, date: "2026-05-01"),
    Assessment(title: "Technical Proficiency", score: 92, date: "2026-04-20"),
    Assessment(title: "Compliance Audit", score: 95, date: "2026-05-11"),
  ].obs;
}
