import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'approval_appeals_controller.dart';

class ApprovalAppealsView extends GetView<ApprovalAppealsController> {
  const ApprovalAppealsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('APPROVAL & APPEALS', style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildFilterChips(context),
          Expanded(
            child: Obx(() => ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.appeals.length,
              itemBuilder: (context, index) {
                final appeal = controller.appeals[index];
                return _buildAppealCard(context, appeal, index);
              },
            )),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showFileAppealSheet(context),
        label: const Text("CREATE APPEAL STUFF"),
        icon: const Icon(Icons.gavel_rounded),
        backgroundColor: Colors.purple[700],
      ),
    );
  }

  Widget _buildFilterChips(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: ["All", "Pending", "Approved", "Rejected"].map((filter) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(filter, style: const TextStyle(fontSize: 12)),
              onSelected: (val) {},
              selected: filter == "All",
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAppealCard(BuildContext context, AppealRequest appeal, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: CircleAvatar(
              backgroundColor: _getTypeColor(appeal.type).withOpacity(0.1),
              child: Icon(_getTypeIcon(appeal.type), color: _getTypeColor(appeal.type)),
            ),
            title: Text(appeal.title, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text("Requester: ${appeal.requester}"),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(DateFormat('MMM dd').format(appeal.date), style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    const Spacer(),
                    _buildStatusBadge(appeal.status),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: () {}, child: const Text("VIEW DETAILS")),
                ElevatedButton(
                  onPressed: () => controller.approveAppeal(index),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green[700], foregroundColor: Colors.white),
                  child: const Text("APPROVE"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(status.toUpperCase(), style: const TextStyle(color: Colors.orange, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case "Leave": return Colors.blue;
      case "Budget": return Colors.green;
      case "Policy": return Colors.purple;
      default: return Colors.grey;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case "Leave": return Icons.time_to_leave;
      case "Budget": return Icons.monetization_on_outlined;
      case "Policy": return Icons.policy_outlined;
      default: return Icons.help_outline;
    }
  }

  void _showFileAppealSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: const BorderRadius.vertical(top: Radius.circular(30))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("FILE NEW APPEAL", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2)),
            const SizedBox(height: 24),
            TextField(controller: controller.titleController, decoration: const InputDecoration(labelText: "Appeal Title")),
            const SizedBox(height: 16),
            TextField(controller: controller.requesterController, decoration: const InputDecoration(labelText: "Your Name/Dept")),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () => controller.submitAppeal(), child: const Text("SUBMIT APPEAL")),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
