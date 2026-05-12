import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'limits_0_1_controller.dart';

class Limits01View extends GetView<Limits01Controller> {
  const Limits01View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('LIMITS 0-1', style: TextStyle(color: Colors.white, letterSpacing: 4, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildBinaryHeader(),
          Expanded(
            child: Obx(() => ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: controller.limits.length,
              itemBuilder: (context, index) {
                final limit = controller.limits[index];
                return _buildLimitMonitor(context, limit);
              },
            )),
          ),
        ],
      ),
    );
  }

  Widget _buildBinaryHeader() {
    return Container(
      padding: const EdgeInsets.all(40),
      child: const Column(
        children: [
          Text("010101010101", style: TextStyle(color: Colors.blue, fontSize: 10, fontFamily: 'monospace')),
          SizedBox(height: 8),
          Text("THRESHOLD MONITOR", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2)),
          SizedBox(height: 8),
          Text("Active Binary Safeguards", style: TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildLimitMonitor(BuildContext context, SystemLimit limit) {
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(limit.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              Text("${(limit.threshold * 100).toInt()}%", style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          Text(limit.description, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: limit.threshold,
            backgroundColor: Colors.grey[900],
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            minHeight: 2,
          ),
        ],
      ),
    );
  }
}
