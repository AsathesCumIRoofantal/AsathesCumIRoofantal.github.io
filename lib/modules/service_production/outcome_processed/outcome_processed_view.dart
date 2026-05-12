import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'outcome_processed_controller.dart';

class OutcomeProcessedView extends GetView<OutcomeProcessedController> {
  const OutcomeProcessedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("OUTCOME PROCESSED", style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Obx(() => ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: controller.outcomes.length,
        itemBuilder: (context, index) {
          final outcome = controller.outcomes[index];
          return _buildOutcomeCard(context, outcome);
        },
      )),
    );
  }

  Widget _buildOutcomeCard(BuildContext context, ProcessedOutcome outcome) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(_getFileIcon(outcome.type), color: Colors.green, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(outcome.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text("${outcome.type} • ${outcome.size}", style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              ],
            ),
          ),
          IconButton(
            onPressed: () => controller.downloadOutcome(outcome.title),
            icon: const Icon(Icons.download_for_offline_outlined, color: Colors.blue),
          ),
        ],
      ),
    );
  }

  IconData _getFileIcon(String type) {
    switch (type) {
      case "PDF": return Icons.picture_as_pdf_outlined;
      case "JSON": return Icons.code_rounded;
      case "CSV": return Icons.table_chart_outlined;
      default: return Icons.insert_drive_file_outlined;
    }
  }
}
