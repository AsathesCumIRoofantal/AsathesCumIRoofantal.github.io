import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'your_business_controller.dart';

class YourBusinessView extends GetView<YourBusinessController> {
  const YourBusinessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('YOUR BUSINESS', style: TextStyle(letterSpacing: 2))),
      body: Obx(() => ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.deals.length,
        itemBuilder: (context, index) {
          final deal = controller.deals[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              title: Text(deal.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("${deal.client} • Value: ${deal.value}"),
              trailing: Chip(label: Text(deal.status, style: const TextStyle(fontSize: 10))),
            ),
          );
        },
      )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddDealSheet(context),
        label: const Text("CREATE BUSINESS STUFF"),
        icon: const Icon(Icons.business_center_outlined),
      ),
    );
  }

  void _showAddDealSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("REGISTER NEW BUSINESS DEAL", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(controller: controller.titleController, decoration: const InputDecoration(labelText: "Deal Title")),
            TextField(controller: controller.clientController, decoration: const InputDecoration(labelText: "Client Entity")),
            TextField(controller: controller.valueController, decoration: const InputDecoration(labelText: "Estimated Value")),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: () => controller.addDeal(), child: const Text("SAVE PROSPECT")),
          ],
        ),
      ),
    );
  }
}
