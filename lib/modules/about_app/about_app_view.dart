import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'about_app_binding.dart';

class AboutAppView extends GetView<AboutAppController> {
  const AboutAppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tertiary = theme.colorScheme.tertiary;

    return Scaffold(
      appBar: AppBar(title: const Text('About AIR-APP')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: tertiary.withOpacity(0.1),
                ),
                child: Icon(Icons.air, color: tertiary, size: 80),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'AIR - All-Space Intelligence & Reasoning',
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Version 1.0.0 (Build 365)',
              style: TextStyle(color: theme.dividerColor),
            ),
            const SizedBox(height: 40),
            _buildSection(
              context,
              'The Vision',
              'To map every entity and union in all-space, ensuring absolute transparency and accountability across all nodes of existence.',
            ),
            const SizedBox(height: 24),
            _buildSection(
              context,
              'Technical Core',
              'Built on the Alifiyas-Mazeasta dual framework, the app serves as the primary interface for the all-space atlas.',
            ),
            const SizedBox(height: 40),
            const Divider(),
            const SizedBox(height: 20),
            Text(
              '© 2026 AIR Organization. All-Space Rights Reserved.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10, color: theme.dividerColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String body) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          body,
          style: const TextStyle(fontSize: 16, height: 1.6),
        ),
      ],
    );
  }
}
