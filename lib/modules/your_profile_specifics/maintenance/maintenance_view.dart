import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'maintenance_controller.dart';

class MaintenanceView extends GetView<MaintenanceController> {
  const MaintenanceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MAINTENANCE', style: TextStyle(letterSpacing: 2))),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (val) => controller.searchQuery.value = val,
              decoration: InputDecoration(
                hintText: "Search assets or issues...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: controller.filteredRequests.length,
              itemBuilder: (context, index) {
                final request = controller.filteredRequests[index];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              request.id,
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            _buildPriorityBadge(request.priority),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          request.assetName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          request.issue,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Icon(Icons.schedule, size: 14, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              DateFormat('MMM dd, HH:mm').format(request.requestedAt),
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                request.status.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            )),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddRequestSheet(context),
        label: const Text("ADD MAINTENANCE REQUEST"),
        icon: const Icon(Icons.build_circle_outlined),
      ),
    );
  }

  Widget _buildPriorityBadge(String priority) {
    Color color = priority == "High" ? Colors.red : (priority == "Medium" ? Colors.orange : Colors.green);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
      child: Text(priority, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  void _showAddRequestSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("NEW MAINTENANCE REQUEST", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(controller: controller.assetController, decoration: const InputDecoration(labelText: "Asset Name")),
            TextField(controller: controller.issueController, decoration: const InputDecoration(labelText: "Issue Description")),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: () => controller.addRequest(), child: const Text("SUBMIT REQUEST")),
          ],
        ),
      ),
    );
  }
}
