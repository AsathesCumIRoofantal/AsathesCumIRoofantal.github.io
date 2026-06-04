import 'package:get/get.dart';

class AccountabilityMetric {
  final String title;
  final double score;
  final String status;

  AccountabilityMetric({required this.title, required this.score, required this.status});
}

class AccountableController extends GetxController {
  final metrics = <AccountabilityMetric>[
    AccountabilityMetric(title: "Data Accuracy", score: 0.98, status: "Excellent"),
    AccountabilityMetric(title: "Compliance Sync", score: 0.85, status: "Good"),
    AccountabilityMetric(title: "System Integrity", score: 1.0, status: "Perfect"),
  ].obs;
}
