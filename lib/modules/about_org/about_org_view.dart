import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'about_org_binding.dart';

class AboutOrgView extends GetView<AboutOrgController> {
  const AboutOrgView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Scaffold(
      appBar: AppBar(title: const Text('AIR Organization')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primary.withOpacity(0.2), primary.withOpacity(0.05)],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.corporate_fare, color: primary, size: 80),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'The Steward of All-Space',
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            _buildOrgSection(
              context,
              'Who We Are',
              'The AIR Organization is a global collective of researchers, experts, and systemic architects dedicated to the Alifiyas-Mazeasta mission.',
              Icons.groups_outlined,
            ),
            const SizedBox(height: 32),
            _buildOrgSection(
              context,
              'Governance',
              'Managed by dual councils: Alifiyas (Public/Explore) and Mazeasta (Expert/Rule), ensuring a balanced ecosystem.',
              Icons.gavel_outlined,
            ),
            const SizedBox(height: 32),
            _buildOrgSection(
              context,
              'Location',
              'Distributed across all-space, with core nodes globally synchronized.',
              Icons.public,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrgSection(BuildContext context, String title, String body, IconData icon) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: theme.colorScheme.tertiary),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                body,
                style: TextStyle(color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7), height: 1.5),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
