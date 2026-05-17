import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'utilities_guest_binding.dart';

class UtilitiesGuestView extends GetView<UtilitiesGuestController> {
  final bool isEmbedded;
  const UtilitiesGuestView({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Scaffold(
      appBar: AppBar(title: const Text('Guest Utilities')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [theme.scaffoldBackgroundColor, theme.colorScheme.surface],
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.utilities.length,
          itemBuilder: (context, index) {
            final util = controller.utilities[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(20),
                leading: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(_getIcon(util['icon'] as String), color: primary),
                ),
                title: Text(
                  util['name'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Text(util['desc'] as String),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  Get.snackbar(
                    'Guest Access',
                    'Please sign in for full utility access.',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: theme.colorScheme.surface,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'search':
        return Icons.search;
      case 'calculate':
        return Icons.calculate_outlined;
      case 'map':
        return Icons.map_outlined;
      case 'analytics':
        return Icons.analytics_outlined;
      default:
        return Icons.extension;
    }
  }
}



