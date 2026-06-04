import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Collaboration {
  final String projectName;
  final String partner;
  final String type;
  final String status;

  Collaboration({required this.projectName, required this.partner, required this.type, required this.status});
}

class ConnectCollaborateController extends GetxController {
  final collaborations = <Collaboration>[
    Collaboration(projectName: "Lunar Habitat", partner: "SpaceX", type: "Research", status: "Active"),
  ].obs;

  final projectController = TextEditingController();
  final partnerController = TextEditingController();

  void startCollaboration() {
    if (projectController.text.isNotEmpty) {
      collaborations.add(Collaboration(
        projectName: projectController.text,
        partner: partnerController.text,
        type: "New Venture",
        status: "Initiating",
      ));
      projectController.clear();
      partnerController.clear();
      Get.back();
      Get.snackbar("Collaboration Started", "New partnership registered.");
    }
  }
}
