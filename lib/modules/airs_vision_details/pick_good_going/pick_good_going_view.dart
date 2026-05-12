import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pick_good_going_controller.dart';

class PickGoodGoingView extends GetView<PickGoodGoingController> {
  const PickGoodGoingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("PICK GOOD GOING", style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Obx(() => ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: controller.highlights.length,
        itemBuilder: (context, index) {
          final item = controller.highlights[index];
          return _buildHighlightCard(context, item);
        },
      )),
    );
  }

  Widget _buildHighlightCard(BuildContext context, HighlightItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.withOpacity(0.1), Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.green.withOpacity(0.1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(item.icon, color: Colors.green, size: 32),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green)),
                const SizedBox(height: 8),
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
