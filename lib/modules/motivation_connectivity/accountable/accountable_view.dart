import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'accountable_controller.dart';

class AccountableView extends GetView<AccountableController> {
  const AccountableView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("ACCOUNTABLE", style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Obx(() => ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: controller.metrics.length,
        itemBuilder: (context, index) {
          final metric = controller.metrics[index];
          return _buildMetricCard(context, metric);
        },
      )),
    );
  }

  Widget _buildMetricCard(BuildContext context, AccountabilityMetric metric) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(metric.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(metric.status, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 20),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(
                  value: metric.score,
                  strokeWidth: 10,
                  backgroundColor: Colors.grey[200],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ),
              Text("${(metric.score * 100).toInt()}%", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
