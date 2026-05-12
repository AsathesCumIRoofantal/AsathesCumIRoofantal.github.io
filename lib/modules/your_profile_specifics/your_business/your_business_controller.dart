import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusinessDeal {
  final String title;
  final String value;
  final String client;
  final String status;

  BusinessDeal({
    required this.title,
    required this.value,
    required this.client,
    required this.status,
  });
}

class YourBusinessController extends GetxController {
  final deals = <BusinessDeal>[
    BusinessDeal(
      title: "Satellite Integration",
      value: "\$500k",
      client: "Orbital Dynamics",
      status: "Negotiation",
    ),
  ].obs;

  final titleController = TextEditingController();
  final valueController = TextEditingController();
  final clientController = TextEditingController();

  void addDeal() {
    if (titleController.text.isNotEmpty) {
      deals.add(
        BusinessDeal(
          title: titleController.text,
          value: valueController.text,
          client: clientController.text,
          status: "Prospect",
        ),
      );
      titleController.clear();
      valueController.clear();
      clientController.clear();
      Get.back();
      Get.snackbar(
        "Business Updated",
        "New prospect registered in the pipeline.",
      );
    }
  }
}
