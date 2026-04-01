import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'entities_controller.dart';

class EntitiesView extends GetView<EntitiesController> {
  EntitiesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.primary));
      }
      return ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemCount: controller.entities.length,
        itemBuilder: (context, index) {
          final entity = controller.entities[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3)),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
                  blurRadius: 10,
                  spreadRadius: 2,
                )
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5)),
                ),
                child: Icon(Icons.hub, color: Theme.of(context).colorScheme.primary),
              ),
              title: Text(entity.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Theme.of(context).textTheme.bodyLarge?.color)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(entity.description, style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Theme.of(context).colorScheme.primary),
                    ),
                    child: Text(entity.category, style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.primary)),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
