import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'innovation_key_controller.dart';

class InnovationKeyView extends GetView<InnovationKeyController> {
  const InnovationKeyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("INNOVATION IS KEY", style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Obx(() => GridView.builder(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.9,
        ),
        itemCount: controller.innovations.length,
        itemBuilder: (context, index) {
          final item = controller.innovations[index];
          return _buildInnovationCard(context, item);
        },
      )),
    );
  }

  Widget _buildInnovationCard(BuildContext context, TechInnovation item) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(item.icon, size: 40, color: Colors.blue),
          const SizedBox(height: 16),
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: item.status == "Live" ? Colors.green.withOpacity(0.1) : Colors.amber.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              item.status.toUpperCase(),
              style: TextStyle(color: item.status == "Live" ? Colors.green : Colors.amber[800], fontSize: 8, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
