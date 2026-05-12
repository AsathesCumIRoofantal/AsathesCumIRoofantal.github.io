import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'tracks_traces_controller.dart';

class TracksTracesView extends GetView<TracksTracesController> {
  const TracksTracesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TRACKS & TRACES', style: TextStyle(letterSpacing: 2))),
      body: Obx(() => ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.traces.length,
        itemBuilder: (context, index) {
          final trace = controller.traces[index];
          return ListTile(
            leading: const Icon(Icons.location_searching),
            title: Text(trace.objectName, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(trace.location),
            trailing: Text(DateFormat('HH:mm').format(trace.timestamp), style: const TextStyle(color: Colors.grey)),
          );
        },
      )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddTraceSheet(context),
        label: const Text("CREATE TRACK STUFF"),
        icon: const Icon(Icons.add_location_alt_outlined),
      ),
    );
  }

  void _showAddTraceSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("NEW TRACKING POINT", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(controller: controller.objectController, decoration: const InputDecoration(labelText: "Object/Asset")),
            TextField(controller: controller.locationController, decoration: const InputDecoration(labelText: "Current Location")),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: () => controller.addTrace(), child: const Text("LOG TRACKING")),
          ],
        ),
      ),
    );
  }
}
