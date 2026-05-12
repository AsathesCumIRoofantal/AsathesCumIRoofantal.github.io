import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'onboard_controller.dart';

class OnboardView extends GetView<OnboardController> {
  const OnboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("ONBOARDING", style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Obx(() => ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: controller.steps.length,
        itemBuilder: (context, index) {
          final step = controller.steps[index];
          return _buildOnboardStep(context, step);
        },
      )),
    );
  }

  Widget _buildOnboardStep(BuildContext context, OnboardStep step) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: CheckboxListTile(
        value: step.isDone,
        onChanged: (val) {},
        title: Text(step.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(step.description, style: const TextStyle(fontSize: 12)),
        secondary: Icon(Icons.verified_user_outlined, color: step.isDone ? Colors.green : Colors.grey),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        tileColor: Theme.of(context).colorScheme.surface,
      ),
    );
  }
}
