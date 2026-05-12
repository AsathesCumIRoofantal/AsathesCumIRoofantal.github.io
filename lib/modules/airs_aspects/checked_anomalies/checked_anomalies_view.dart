import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'anomalies_controller.dart';

class CheckedAnomaliesView extends GetView<AnomaliesController> {
  const CheckedAnomaliesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("CHECKED ANOMALIES", style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Obx(() => ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: controller.checkedAnomalies.length,
        itemBuilder: (context, index) {
          final anomaly = controller.checkedAnomalies[index];
          return _buildAnomalyCard(context, anomaly);
        },
      )),
    );
  }

  Widget _buildAnomalyCard(BuildContext context, Anomaly anomaly) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, color: Colors.green),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(anomaly.id, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.blue)),
                const SizedBox(height: 4),
                Text(anomaly.description, style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
          const Text("RESOLVED", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 10)),
        ],
      ),
    );
  }
}
