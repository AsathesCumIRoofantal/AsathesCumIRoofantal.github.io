import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'together_unison_controller.dart';

class TogetherUnisonView extends GetView<TogetherUnisonController> {
  const TogetherUnisonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("TOGETHER UNISON", style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Obx(() => ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: controller.projects.length,
        itemBuilder: (context, index) {
          final project = controller.projects[index];
          return _buildProjectCard(context, project);
        },
      )),
    );
  }

  Widget _buildProjectCard(BuildContext context, TeamProject project) {
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
              Text(project.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 1)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    const Icon(Icons.people_outline, size: 12, color: Colors.blue),
                    const SizedBox(width: 4),
                    Text("${project.members}", style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 10)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            project.objective,
            style: TextStyle(color: Colors.grey[600], fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }
}
