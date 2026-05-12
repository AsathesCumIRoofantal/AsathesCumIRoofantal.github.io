import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'process_controller.dart';

class ProcessView extends GetView<ProcessController> {
  const ProcessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("STAGE 2: PROCESS", style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildCpuLoadHeader(context),
          Expanded(
            child: Obx(() => ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.activeJobs.length,
              itemBuilder: (context, index) {
                final job = controller.activeJobs[index];
                return _buildJobCard(context, job);
              },
            )),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => controller.optimizeProcess(),
        label: const Text("OPTIMIZE THROUGHTPUT"),
        icon: const Icon(Icons.speed),
        backgroundColor: Colors.deepOrange,
      ),
    );
  }

  Widget _buildCpuLoadHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("CORE LOAD DISTRIBUTION", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey)),
              Text("82%", style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: List.generate(12, (index) => Expanded(
              child: Container(
                height: 30,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: index < 9 ? Colors.deepOrange : Colors.grey[200],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }

  Widget _buildJobCard(BuildContext context, ProcessingJob job) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.deepOrange.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(job.id, style: const TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold, fontSize: 12)),
              Text("ETA: ${job.eta}", style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 12),
          Text(job.algorithm, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: job.progress,
                    minHeight: 10,
                    backgroundColor: Colors.deepOrange.withOpacity(0.1),
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Text("${(job.progress * 100).toInt()}%", style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}
