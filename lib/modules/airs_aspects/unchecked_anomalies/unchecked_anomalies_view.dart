import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../checked_anomalies/anomalies_controller.dart';

class UncheckedAnomaliesView extends GetView<AnomaliesController> {
  const UncheckedAnomaliesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("UNCHECKED ANOMALIES", style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Obx(() => ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: controller.uncheckedAnomalies.length,
        itemBuilder: (context, index) {
          final anomaly = controller.uncheckedAnomalies[index];
          return _buildAnomalyCard(context, anomaly);
        },
      )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => controller.reportAnomaly(),
        label: const Text("REPORT NEW ANOMALY"),
        icon: const Icon(Icons.report_problem_outlined),
        backgroundColor: Colors.red[700],
      ),
    );
  }

  Widget _buildAnomalyCard(BuildContext context, Anomaly anomaly) {
    Color severityColor = anomaly.severity == "Critical" ? Colors.red : (anomaly.severity == "High" ? Colors.orange : Colors.blue);
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: severityColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: severityColor),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(anomaly.id, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.blue)),
                    Text(anomaly.severity.toUpperCase(), style: TextStyle(color: severityColor, fontWeight: FontWeight.bold, fontSize: 10)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(anomaly.description, style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
