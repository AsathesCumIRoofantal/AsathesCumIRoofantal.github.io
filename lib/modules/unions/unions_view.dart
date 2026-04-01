import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'unions_controller.dart';

class UnionsView extends GetView<UnionsController> {
  UnionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator(color: Theme.of(context).colorScheme.secondary));
      }
      return ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemCount: controller.unions.length,
        itemBuilder: (context, index) {
          final union = controller.unions[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Theme.of(context).cardColor, Theme.of(context).scaffoldBackgroundColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.4)),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.05),
                  blurRadius: 15,
                  spreadRadius: 1,
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.bubble_chart, color: Theme.of(context).colorScheme.secondary, size: 28),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(union.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color, letterSpacing: 1)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(union.description, style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color, fontSize: 14, height: 1.4)),
                  const SizedBox(height: 16),
                  Text('COMPOSED OF:', style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.bold, fontSize: 10, letterSpacing: 2)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: union.unionedEntities
                        .map((e) => Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.5)),
                              ),
                              child: Text(e, style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.secondary)),
                            ))
                        .toList(),
                  )
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
