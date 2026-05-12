import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'responsibilities_controller.dart';

class ResponsibilitiesView extends GetView<ResponsibilitiesController> {
  const ResponsibilitiesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('RESPONSIBILITIES', style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Obx(() => ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: controller.duties.length,
        itemBuilder: (context, index) {
          final duty = controller.duties[index];
          return _buildDutyCard(context, duty);
        },
      )),
    );
  }

  Widget _buildDutyCard(BuildContext context, Responsibility duty) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(duty.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text("${(duty.progress * 100).toInt()}%", style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          Text(duty.description, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: duty.progress,
              minHeight: 8,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(duty.progress == 1.0 ? Colors.green : Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
