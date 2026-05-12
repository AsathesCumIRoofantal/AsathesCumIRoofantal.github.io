import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'resume_tour_controller.dart';

class ResumeTourView extends GetView<ResumeTourController> {
  const ResumeTourView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("RESUME TOUR", style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildProgressCard(context),
          Expanded(
            child: Obx(() => ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: controller.tourSteps.length,
              itemBuilder: (context, index) {
                final step = controller.tourSteps[index];
                return _buildTourStep(context, step, index);
              },
            )),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24),
        child: ElevatedButton(
          onPressed: () => controller.resumeNextStep(),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          child: const Text("RESUME JOURNEY", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        ),
      ),
    );
  }

  Widget _buildProgressCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Your Progress", style: TextStyle(fontWeight: FontWeight.bold)),
              Obx(() => Text("${(controller.progress * 100).toInt()}%", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue))),
            ],
          ),
          const SizedBox(height: 12),
          Obx(() => LinearProgressIndicator(
            value: controller.progress,
            backgroundColor: Colors.blue.withOpacity(0.1),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            minHeight: 10,
            borderRadius: BorderRadius.circular(5),
          )),
        ],
      ),
    );
  }

  Widget _buildTourStep(BuildContext context, TourStep step, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: step.isCompleted ? Colors.green : Colors.grey, width: 2),
              ),
              child: CircleAvatar(
                radius: 12,
                backgroundColor: step.isCompleted ? Colors.green : Colors.transparent,
                child: step.isCompleted ? const Icon(Icons.check, size: 16, color: Colors.white) : Text("${index + 1}", style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ),
            ),
            if (index < controller.tourSteps.length - 1)
              Container(
                width: 2,
                height: 50,
                color: step.isCompleted ? Colors.green : Colors.grey[300],
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                step.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: step.isCompleted ? Colors.green[700] : null,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                step.description,
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }
}
