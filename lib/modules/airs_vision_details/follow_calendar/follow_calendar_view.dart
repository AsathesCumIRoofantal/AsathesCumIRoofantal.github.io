import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'follow_calendar_controller.dart';

class FollowCalendarView extends GetView<FollowCalendarController> {
  const FollowCalendarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("FOLLOW CALENDAR", style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildDatePickerHeader(context),
          Expanded(
            child: Obx(() => ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: controller.events.length,
              itemBuilder: (context, index) {
                final event = controller.events[index];
                return _buildEventTile(context, event);
              },
            )),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePickerHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      color: Colors.blue.withOpacity(0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("TODAY", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
              Text("MAY 12, 2026", style: TextStyle(color: Colors.grey, fontSize: 14)),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.calendar_month_outlined, color: Colors.blue),
          ),
        ],
      ),
    );
  }

  Widget _buildEventTile(BuildContext context, CalendarEvent event) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Column(
            children: [
              Text(event.time.split(' ')[0], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(event.time.split(' ')[1], style: const TextStyle(color: Colors.grey, fontSize: 10)),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _getEventTypeColor(event.type).withOpacity(0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(event.type, style: TextStyle(color: _getEventTypeColor(event.type), fontSize: 10, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getEventTypeColor(String type) {
    switch (type) {
      case "Operational": return Colors.red;
      case "Social": return Colors.purple;
      case "Update": return Colors.green;
      default: return Colors.blue;
    }
  }
}
