import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppealRequest {
  final String id;
  final String title;
  final String requester;
  final String type;
  final String status;
  final DateTime date;

  AppealRequest({
    required this.id,
    required this.title,
    required this.requester,
    required this.type,
    required this.status,
    required this.date,
  });
}

class ApprovalAppealsController extends GetxController {
  final appeals = <AppealRequest>[
    AppealRequest(
      id: "APP-301",
      title: "Vacation Leave Request",
      requester: "John Doe",
      type: "Leave",
      status: "Pending",
      date: DateTime.now().add(const Duration(days: 2)),
    ),
    AppealRequest(
      id: "APP-302",
      title: "Project Budget Overrun",
      requester: "Engineering Dept",
      type: "Budget",
      status: "Under Review",
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    AppealRequest(
      id: "APP-303",
      title: "Security Policy Waiver",
      requester: "Cyber Team",
      type: "Policy",
      status: "Escalated",
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ].obs;

  final titleController = TextEditingController();
  final requesterController = TextEditingController();
  var selectedType = "Leave".obs;

  void submitAppeal() {
    if (titleController.text.isNotEmpty) {
      appeals.insert(0, AppealRequest(
        id: "APP-${300 + appeals.length + 1}",
        title: titleController.text,
        requester: requesterController.text.isEmpty ? "System User" : requesterController.text,
        type: selectedType.value,
        status: "Submitted",
        date: DateTime.now(),
      ));
      
      titleController.clear();
      requesterController.clear();
      
      Get.back();
      Get.snackbar(
        "Appeal Filed",
        "Your request has been sent for approval.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.purple.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }

  void approveAppeal(int index) {
    // Logic to approve
    Get.snackbar("Approved", "Appeal ${appeals[index].id} has been approved.");
  }

  @override
  void onClose() {
    titleController.dispose();
    requesterController.dispose();
    super.onClose();
  }
}
