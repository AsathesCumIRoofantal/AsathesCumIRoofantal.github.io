import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'category_tree_controller.dart';

class CategoryTreeView extends GetView<CategoryTreeController> {
  const CategoryTreeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Category Tree',
          style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.scaffoldBackgroundColor,
              theme.colorScheme.surface.withOpacity(0.8),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: controller.categories.length,
                    itemBuilder: (context, index) {
                      return _buildCategoryNode(context, controller.categories[index]);
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'HIERARCHICAL CLASSIFICATION',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Explore the organizational structure of AIR assets and resources.',
            style: TextStyle(fontSize: 14, color: Colors.white54),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryNode(BuildContext context, CategoryNode node) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Obx(() {
      final isExpanded = node.isExpanded.value;
      return Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: theme.cardColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: (isExpanded ? primary : Colors.white10).withOpacity(0.2),
          ),
        ),
        child: Column(
          children: [
            ListTile(
              onTap: () => controller.toggleNode(node),
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(node.icon, color: primary, size: 20),
              ),
              title: Text(
                node.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Icon(
                isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                color: Colors.white38,
              ),
            ),
            if (isExpanded && node.children.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 32, right: 16, bottom: 16),
                child: Column(
                  children: node.children.map((child) => _buildChildNode(context, child)).toList(),
                ),
              ),
          ],
        ),
      );
    });
  }

  Widget _buildChildNode(BuildContext context, CategoryNode child) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(child.icon, size: 16, color: theme.colorScheme.tertiary),
          const SizedBox(width: 12),
          Text(
            child.title,
            style: const TextStyle(fontSize: 13, color: Colors.white70),
          ),
          const Spacer(),
          const Icon(Icons.chevron_right, size: 14, color: Colors.white24),
        ],
      ),
    );
  }
}
