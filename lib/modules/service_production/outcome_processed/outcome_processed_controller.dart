import 'package:get/get.dart';

class ProcessedOutcome {
  final String title;
  final String type;
  final String size;
  final DateTime completedAt;

  ProcessedOutcome({required this.title, required this.type, required this.size, required this.completedAt});
}

class OutcomeProcessedController extends GetxController {
  final outcomes = <ProcessedOutcome>[
    ProcessedOutcome(title: "Master Ledger v1.2", type: "JSON", size: "45 MB", completedAt: DateTime.now().subtract(const Duration(minutes: 5))),
    ProcessedOutcome(title: "Security Audit Report", type: "PDF", size: "12 MB", completedAt: DateTime.now().subtract(const Duration(hours: 1))),
    ProcessedOutcome(title: "User Graph Data", type: "CSV", size: "156 MB", completedAt: DateTime.now().subtract(const Duration(days: 1))),
  ].obs;

  void downloadOutcome(String title) {
    Get.snackbar("Download Started", "Transferring $title to local storage...");
  }
}
