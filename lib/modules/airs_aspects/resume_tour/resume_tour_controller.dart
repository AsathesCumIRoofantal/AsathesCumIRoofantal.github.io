import 'package:get/get.dart';

class TourStep {
  final String title;
  final String description;
  final bool isCompleted;

  TourStep({required this.title, required this.description, this.isCompleted = false});
}

class ResumeTourController extends GetxController {
  final tourSteps = <TourStep>[
    TourStep(title: "Identity Setup", description: "Complete your profile and biometric registration.", isCompleted: true),
    TourStep(title: "Record Digitalization", description: "Upload your first physical asset to the AIR vault.", isCompleted: true),
    TourStep(title: "Collaboration Hub", description: "Connect with a partner entity in the network.", isCompleted: false),
    TourStep(title: "Reward System", description: "Earn your first 500 AIR credits.", isCompleted: false),
    TourStep(title: "Public Influence", description: "Share your first update in the community feed.", isCompleted: false),
  ].obs;

  double get progress => tourSteps.where((s) => s.isCompleted).length / tourSteps.length;

  void resumeNextStep() {
    Get.snackbar("Tour Resuming", "Navigating to your next pending milestone...");
  }
}
