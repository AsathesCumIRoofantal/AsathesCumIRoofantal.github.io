import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'connect_collaborate_controller.dart';

class ConnectCollaborateView extends GetView<ConnectCollaborateController> {
  const ConnectCollaborateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CONNECT & COLLABORATE', style: TextStyle(letterSpacing: 2))),
      body: Obx(() => ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.collaborations.length,
        itemBuilder: (context, index) {
          final collab = controller.collaborations[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.handshake_outlined)),
              title: Text(collab.projectName, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("${collab.partner} • ${collab.type}"),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                child: Text(collab.status, style: const TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ),
          );
        },
      )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showStartCollabSheet(context),
        label: const Text("START COLLABORATION"),
        icon: const Icon(Icons.add_link_outlined),
      ),
    );
  }

  void _showStartCollabSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("INITIATE NEW PARTNERSHIP", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(controller: controller.projectController, decoration: const InputDecoration(labelText: "Project Name")),
            TextField(controller: controller.partnerController, decoration: const InputDecoration(labelText: "Partner Entity")),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: () => controller.startCollaboration(), child: const Text("LAUNCH COLLABORATION")),
          ],
        ),
      ),
    );
  }
}
