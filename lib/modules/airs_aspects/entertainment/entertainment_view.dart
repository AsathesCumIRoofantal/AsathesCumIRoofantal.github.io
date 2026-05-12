import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'entertainment_controller.dart';

class EntertainmentView extends GetView<EntertainmentController> {
  const EntertainmentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("ENTERTAINMENT", style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Obx(() => GridView.builder(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        itemCount: controller.activities.length,
        itemBuilder: (context, index) {
          final activity = controller.activities[index];
          return _buildActivityCard(context, activity);
        },
      )),
    );
  }

  Widget _buildActivityCard(BuildContext context, EntertainmentActivity activity) {
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
          Icon(activity.icon, size: 48, color: Colors.purple),
          const SizedBox(height: 16),
          Text(
            activity.title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(activity.type, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: activity.status == "Available" ? Colors.green.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              activity.status.toUpperCase(),
              style: TextStyle(color: activity.status == "Available" ? Colors.green : Colors.grey, fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
