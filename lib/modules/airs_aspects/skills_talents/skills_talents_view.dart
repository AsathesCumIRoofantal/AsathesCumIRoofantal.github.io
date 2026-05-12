import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'skills_talents_controller.dart';

class SkillsTalentsView extends GetView<SkillsTalentsController> {
  const SkillsTalentsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("SKILLS & TALENTS", style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Obx(() => ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: controller.skills.length,
        itemBuilder: (context, index) {
          final skill = controller.skills[index];
          return _buildSkillCard(context, skill);
        },
      )),
    );
  }

  Widget _buildSkillCard(BuildContext context, Skill skill) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
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
              Text(skill.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(skill.category.toUpperCase(), style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 10)),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: skill.level,
              minHeight: 12,
              backgroundColor: Colors.blue.withOpacity(0.1),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "${(skill.level * 100).toInt()}% Proficiency",
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
        ],
      ),
    );
  }
}
