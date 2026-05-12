import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'imagination_features_controller.dart';

class ImaginationFeaturesView extends GetView<ImaginationFeaturesController> {
  const ImaginationFeaturesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('IMAGINATION FEATURES', style: TextStyle(color: Colors.cyanAccent, letterSpacing: 2, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Obx(() => ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: controller.ideas.length,
        itemBuilder: (context, index) {
          final idea = controller.ideas[index];
          return _buildIdeaCard(context, idea);
        },
      )),
    );
  }

  Widget _buildIdeaCard(BuildContext context, FutureIdea idea) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.cyanAccent.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(color: Colors.cyanAccent.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(idea.icon, color: Colors.cyanAccent, size: 32),
          const SizedBox(height: 16),
          Text(idea.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 1)),
          const SizedBox(height: 12),
          Text(
            idea.description,
            style: TextStyle(color: Colors.grey[400], fontSize: 14, height: 1.5),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.cyanAccent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text("EXPERIMENTAL", style: TextStyle(color: Colors.cyanAccent, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
