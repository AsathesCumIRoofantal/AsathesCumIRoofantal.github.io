import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'contribute_to_air_controller.dart';

class ContributeToAirView extends GetView<ContributeToAirController> {
  const ContributeToAirView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("CONTRIBUTE TO AIR", style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Obx(() => ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: controller.types.length,
        itemBuilder: (context, index) {
          final type = controller.types[index];
          return _buildContributionCard(context, type);
        },
      )),
    );
  }

  Widget _buildContributionCard(BuildContext context, ContributionType type) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(type.icon, color: Colors.amber[800], size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(type.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      const SizedBox(height: 4),
                      Text(type.reward, style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              type.description,
              style: TextStyle(color: Colors.grey[600], fontSize: 14, height: 1.5),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => controller.startContribution(type.title),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text("START CONTRIBUTION"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
