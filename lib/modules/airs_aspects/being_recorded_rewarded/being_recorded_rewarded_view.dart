import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'being_recorded_rewarded_controller.dart';

class BeingRecordedRewardedView extends GetView<BeingRecordedRewardedController> {
  const BeingRecordedRewardedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("RECORDED & REWARDED", style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Obx(() => ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: controller.records.length,
        itemBuilder: (context, index) {
          final record = controller.records[index];
          return _buildRecordCard(context, record);
        },
      )),
    );
  }

  Widget _buildRecordCard(BuildContext context, RewardRecord record) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.amber.withOpacity(0.1), shape: BoxShape.circle),
            child: const Icon(Icons.stars_rounded, color: Colors.amber),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(record.action, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(DateFormat('MMM dd, yyyy').format(record.date), style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          Text(record.reward, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}
