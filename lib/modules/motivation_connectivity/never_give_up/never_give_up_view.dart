import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'never_give_up_controller.dart';

class NeverGiveUpView extends GetView<NeverGiveUpController> {
  const NeverGiveUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("NEVER GIVE UP", style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Obx(() => ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: controller.stories.length,
        itemBuilder: (context, index) {
          final story = controller.stories[index];
          return _buildStoryCard(context, story);
        },
      )),
    );
  }

  Widget _buildStoryCard(BuildContext context, SuccessStory story) {
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
          Icon(story.icon, color: Colors.amber, size: 32),
          const SizedBox(height: 16),
          Text(story.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 1)),
          const SizedBox(height: 12),
          Text(
            story.content,
            style: TextStyle(color: Colors.grey[600], fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }
}
