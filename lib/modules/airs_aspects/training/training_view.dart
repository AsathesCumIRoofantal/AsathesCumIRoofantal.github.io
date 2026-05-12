import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'training_controller.dart';

class TrainingView extends GetView<TrainingController> {
  const TrainingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("TRAINING CENTER", style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Obx(() => ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: controller.modules.length,
        itemBuilder: (context, index) {
          final module = controller.modules[index];
          return _buildModuleCard(context, module);
        },
      )),
    );
  }

  Widget _buildModuleCard(BuildContext context, TrainingModule module) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(24),
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
              Text(module.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(module.category.toUpperCase(), style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 10)),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: module.progress,
              minHeight: 12,
              backgroundColor: Colors.blue.withOpacity(0.1),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
          const SizedBox(height: 8),
          Text("${(module.progress * 100).toInt()}% Completed", style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        ],
      ),
    );
  }
}
