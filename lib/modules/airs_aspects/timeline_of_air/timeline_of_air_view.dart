import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'timeline_of_air_controller.dart';

class TimelineOfAirView extends GetView<TimelineOfAirController> {
  const TimelineOfAirView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("TIMELINE OF AIR", style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Obx(() => ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: controller.events.length,
        itemBuilder: (context, index) {
          final event = controller.events[index];
          return _buildTimelineEvent(context, event, index);
        },
      )),
    );
  }

  Widget _buildTimelineEvent(BuildContext context, TimelineEvent event, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 50,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                event.year,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.blue),
              ),
            ),
            if (index < controller.events.length - 1)
              Container(
                width: 2,
                height: 80,
                color: Colors.blue.withOpacity(0.2),
              ),
          ],
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(event.icon, size: 20, color: Colors.amber),
                  const SizedBox(width: 8),
                  Text(event.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                event.description,
                style: TextStyle(color: Colors.grey[600], fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ],
    );
  }
}
