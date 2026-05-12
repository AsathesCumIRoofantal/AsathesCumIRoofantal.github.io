import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'live_fullest_controller.dart';

class LiveFullestView extends GetView<LiveFullestController> {
  const LiveFullestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("LIVE TO FULLEST", style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Obx(() => ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: controller.tips.length,
        itemBuilder: (context, index) {
          final tip = controller.tips[index];
          return _buildTipCard(context, tip);
        },
      )),
    );
  }

  Widget _buildTipCard(BuildContext context, WellnessTip tip) {
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(tip.icon, color: Colors.blue, size: 28),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tip.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 1)),
                const SizedBox(height: 8),
                Text(
                  tip.description,
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
