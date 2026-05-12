import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'system_all_together_controller.dart';

class SystemAllTogetherView extends GetView<SystemAllTogetherController> {
  const SystemAllTogetherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("SYSTEM ALL TOGETHER", style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildGlobalHealthIndicator(context),
            const SizedBox(height: 32),
            Obx(() => GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
              ),
              itemCount: controller.components.length,
              itemBuilder: (context, index) {
                final component = controller.components[index];
                return _buildComponentCard(context, component);
              },
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => controller.restartSystem(),
        label: const Text("SYNC GLOBAL CORE"),
        icon: const Icon(Icons.sync_rounded),
      ),
    );
  }

  Widget _buildGlobalHealthIndicator(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.05),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.blue.withOpacity(0.1), width: 2),
      ),
      child: Column(
        children: [
          const Text("SYSTEM HEALTH", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 2, color: Colors.grey)),
          const SizedBox(height: 8),
          Text(
            "${(controller.components.fold(0.0, (sum, c) => sum + c.health) / controller.components.length * 100).toInt()}%",
            style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          const Text("OPERATIONAL", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.green)),
        ],
      ),
    );
  }

  Widget _buildComponentCard(BuildContext context, SystemComponent component) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(component.icon, color: Colors.blue, size: 32),
          const SizedBox(height: 12),
          Text(component.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 4),
          Text(component.status, style: TextStyle(color: Colors.grey[600], fontSize: 10)),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: component.health,
            backgroundColor: Colors.blue.withOpacity(0.1),
            valueColor: AlwaysStoppedAnimation<Color>(component.health > 0.9 ? Colors.green : Colors.blue),
            minHeight: 4,
            borderRadius: BorderRadius.circular(2),
          ),
        ],
      ),
    );
  }
}
