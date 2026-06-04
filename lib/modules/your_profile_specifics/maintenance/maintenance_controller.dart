import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MaintenanceRequest {
  final String id;
  final String assetName;
  final String issue;
  final String priority;
  final String status;
  final DateTime requestedAt;

  MaintenanceRequest({
    required this.id,
    required this.assetName,
    required this.issue,
    required this.priority,
    required this.status,
    required this.requestedAt,
  });
}

class MaintenanceController extends GetxController {
  final requests = <MaintenanceRequest>[
    MaintenanceRequest(
      id: "MNT-201",
      assetName: "Server Rack A-12",
      issue: "Cooling fan noise",
      priority: "Medium",
      status: "Pending",
      requestedAt: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    MaintenanceRequest(
      id: "MNT-202",
      assetName: "Bio-Waste System",
      issue: "Filter replacement required",
      priority: "High",
      status: "Scheduled",
      requestedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    MaintenanceRequest(
      id: "MNT-203",
      assetName: "Solar Array 4",
      issue: "Dust accumulation on sensors",
      priority: "Low",
      status: "In Progress",
      requestedAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    MaintenanceRequest(
      id: "MNT-204",
      assetName: "Oxygen Scrubber",
      issue: "Low pressure warning",
      priority: "High",
      status: "Critical",
      requestedAt: DateTime.now().subtract(const Duration(minutes: 30)),
    ),
    MaintenanceRequest(
      id: "MNT-205",
      assetName: "Docking Clamp 3",
      issue: "Hydraulic fluid leak",
      priority: "High",
      status: "Under Review",
      requestedAt: DateTime.now().subtract(const Duration(hours: 12)),
    ),
  ].obs;

  var searchQuery = "".obs;
  List<MaintenanceRequest> get filteredRequests {
    if (searchQuery.value.isEmpty) return requests;
    return requests.where((r) => 
      r.assetName.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
      r.issue.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
      r.id.toLowerCase().contains(searchQuery.value.toLowerCase())
    ).toList();
  }

  final assetController = TextEditingController();
  final issueController = TextEditingController();
  var selectedPriority = "Low".obs;

  void addRequest() {
    if (assetController.text.isNotEmpty && issueController.text.isNotEmpty) {
      requests.add(MaintenanceRequest(
        id: "MNT-${200 + requests.length + 1}",
        assetName: assetController.text,
        issue: issueController.text,
        priority: selectedPriority.value,
        status: "Open",
        requestedAt: DateTime.now(),
      ));
      
      assetController.clear();
      issueController.clear();
      
      Get.back();
      Get.snackbar("Success", "Maintenance request submitted");
    }
  }
}
