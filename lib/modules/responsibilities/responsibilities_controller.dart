import 'package:get/get.dart';

class Responsibility {
  final String title;
  final String description;
  final double progress;

  Responsibility({required this.title, required this.description, required this.progress});
}

class ResponsibilitiesController extends GetxController {
  final duties = <Responsibility>[
    Responsibility(title: "Data Integrity", description: "Ensure all records are digitized correctly.", progress: 0.85),
    Responsibility(title: "Security Compliance", description: "Maintain zero-vulnerability status.", progress: 1.0),
    Responsibility(title: "Community Growth", description: "Foster positive collaboration in the feed.", progress: 0.45),
  ].obs;

  void updateDutyProgress(int index, double newProgress) {
    // Logic to update progress
  }
}
