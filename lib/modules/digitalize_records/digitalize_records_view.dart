import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'digitalize_records_controller.dart';

class DigitalizeRecordsView extends GetView<DigitalizeRecordsController> {
  const DigitalizeRecordsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'DIGITALIZE RECORDS',
          style: TextStyle(letterSpacing: 2),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildScannerCard(context),
          const SizedBox(height: 24),
          _buildRecentSectionTitle(context),
          Expanded(child: _buildRecordsList(context)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => controller.digitalizeNewRecord(),
        label: const Text("START SCANNING"),
        icon: const Icon(Icons.document_scanner_outlined),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _buildScannerCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
            Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(
            Icons.cloud_upload_outlined,
            size: 60,
            color: Colors.white,
          ),
          const SizedBox(height: 16),
          const Text(
            "Ready for Digitalization",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Transform your physical assets into AIR's secure digital vault.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentSectionTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "RECENTLY DIGITALIZED",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              color: Theme.of(
                context,
              ).textTheme.bodyMedium?.color?.withValues(alpha: 0.6),
            ),
          ),
          TextButton(onPressed: () {}, child: const Text("VIEW ALL")),
        ],
      ),
    );
  }

  Widget _buildRecordsList(BuildContext context) {
    return Obx(
      () => ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: controller.records.length,
        itemBuilder: (context, index) {
          final record = controller.records[index];
          return _buildRecordItem(context, record);
        },
      ),
    );
  }

  Widget _buildRecordItem(BuildContext context, DigitizedRecord record) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              record.type == "PDF" ? Icons.picture_as_pdf : Icons.description,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  record.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "${record.size} • ${DateFormat('MMM dd, yyyy').format(record.date)}",
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.color?.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: record.status == "Verified"
                  ? Colors.green.withValues(alpha: 0.1)
                  : Colors.orange.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              record.status.toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: record.status == "Verified"
                    ? Colors.green
                    : Colors.orange,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
