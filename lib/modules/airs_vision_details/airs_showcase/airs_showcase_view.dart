import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'airs_showcase_controller.dart';

class AirsShowcaseView extends GetView<AirsShowcaseController> {
  const AirsShowcaseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("AIR'S SHOWCASE", style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Obx(() => ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: controller.items.length,
        itemBuilder: (context, index) {
          final item = controller.items[index];
          return _buildShowcaseCard(context, item);
        },
      )),
    );
  }

  Widget _buildShowcaseCard(BuildContext context, ShowcaseItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              image: const DecorationImage(
                image: NetworkImage("https://images.unsplash.com/photo-1451187580459-43490279c0fa?auto=format&fit=crop&q=80&w=1000"), // Placeholder
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.category.toUpperCase(),
                  style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 10, letterSpacing: 2),
                ),
                const SizedBox(height: 8),
                Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                const SizedBox(height: 12),
                Text(
                  item.description,
                  style: TextStyle(color: Colors.grey[600], fontSize: 14, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
