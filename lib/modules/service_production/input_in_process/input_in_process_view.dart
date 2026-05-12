import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'input_in_process_controller.dart';

class InputInProcessView extends GetView<InputInProcessController> {
  const InputInProcessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("INPUT IN PROCESS", style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildLiveMonitor(context),
          Expanded(
            child: Obx(() => ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.inputTasks.length,
              itemBuilder: (context, index) {
                final task = controller.inputTasks[index];
                return _buildInputRow(context, task);
              },
            )),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => controller.startNewInput(),
        label: const Text("INITIALIZE INPUT"),
        icon: const Icon(Icons.add_to_photos_outlined),
      ),
    );
  }

  Widget _buildLiveMonitor(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("LIVE INGESTION MONITOR", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1.5)),
              Icon(Icons.radar, color: Colors.blue, size: 16),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem("Active Streams", "08", Colors.blue),
              _buildStatItem("Load Factor", "64%", Colors.amber),
              _buildStatItem("Error Rate", "0.02%", Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(value, style: TextStyle(color: color, fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 10)),
      ],
    );
  }

  Widget _buildInputRow(BuildContext context, InputTask task) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).dividerColor.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.input_rounded, size: 20, color: Colors.blue),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(task.source, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
              Text(task.status, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 10)),
            ],
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: task.load,
            backgroundColor: Colors.blue.withOpacity(0.1),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            minHeight: 4,
            borderRadius: BorderRadius.circular(2),
          ),
        ],
      ),
    );
  }
}
