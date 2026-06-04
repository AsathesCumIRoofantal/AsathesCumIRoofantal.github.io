import 'package:get/get.dart';

class OnboardStep {
  final String title;
  final String description;
  final bool isDone;

  OnboardStep({required this.title, required this.description, this.isDone = false});
}

class OnboardController extends GetxController {
  final steps = <OnboardStep>[
    OnboardStep(title: "Security Clearance", description: "Complete level 1 biometric background check.", isDone: true),
    OnboardStep(title: "Hardware Sync", description: "Register your mobile node with the central core.", isDone: false),
    OnboardStep(title: "First Ingestion", description: "Upload a physical asset record for digitalization.", isDone: false),
  ].obs;
}
