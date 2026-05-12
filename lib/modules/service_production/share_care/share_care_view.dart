import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'share_care_controller.dart';

class ShareCareView extends GetView<ShareCareController> {
  const ShareCareView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("SHARE & CARE", style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Obx(() => ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: controller.activeTickets.length,
        itemBuilder: (context, index) {
          final ticket = controller.activeTickets[index];
          return _buildTicketCard(context, ticket);
        },
      )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => controller.provideSupport(),
        label: const Text("CONTACT SUPPORT"),
        icon: const Icon(Icons.support_agent_rounded),
      ),
    );
  }

  Widget _buildTicketCard(BuildContext context, SupportTicket ticket) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(ticket.user, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.blue)),
              _buildUrgencyBadge(ticket.urgency),
            ],
          ),
          const SizedBox(height: 12),
          Text(ticket.issue, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.chat_bubble_outline_rounded, size: 14, color: Colors.grey),
              const SizedBox(width: 6),
              Text("RESPOND TO REQUEST", style: TextStyle(color: Colors.grey[600], fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUrgencyBadge(String urgency) {
    Color color = urgency == "High" ? Colors.red : Colors.orange;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        urgency.toUpperCase(),
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }
}
