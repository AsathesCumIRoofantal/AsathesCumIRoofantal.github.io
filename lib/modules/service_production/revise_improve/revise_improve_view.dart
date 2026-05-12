import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'revise_improve_controller.dart';

class ReviseImproveView extends GetView<ReviseImproveController> {
  const ReviseImproveView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("REVISE & IMPROVE", style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Obx(() => ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: controller.feedbacks.length,
        itemBuilder: (context, index) {
          final item = controller.feedbacks[index];
          return _buildFeedbackCard(context, item);
        },
      )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => controller.submitImprovement(),
        label: const Text("LOG IMPROVEMENT"),
        icon: const Icon(Icons.auto_fix_high_outlined),
      ),
    );
  }

  Widget _buildFeedbackCard(BuildContext context, FeedbackItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              _buildPriorityBadge(item.priority),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "Suggestion:",
            style: TextStyle(color: Colors.grey[400], fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1),
          ),
          const SizedBox(height: 4),
          Text(item.suggestedChange, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.hourglass_empty_rounded, size: 14, color: Colors.blue),
              const SizedBox(width: 6),
              Text(item.status, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriorityBadge(String priority) {
    Color color = priority == "High" ? Colors.red : (priority == "Medium" ? Colors.orange : Colors.green);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        priority.toUpperCase(),
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }
}
