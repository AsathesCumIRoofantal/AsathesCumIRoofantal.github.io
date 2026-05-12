import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CategoryNode {
  final String title;
  final IconData icon;
  final List<CategoryNode> children;
  var isExpanded = false.obs;

  CategoryNode({
    required this.title,
    required this.icon,
    this.children = const [],
  });
}

class CategoryTreeController extends GetxController {
  final categories = <CategoryNode>[
    CategoryNode(
      title: 'Infrastructure',
      icon: Icons.business_rounded,
      children: [
        CategoryNode(title: 'Civil Works', icon: Icons.construction),
        CategoryNode(title: 'Electrical Systems', icon: Icons.electrical_services),
        CategoryNode(title: 'Water Supply', icon: Icons.water_drop),
      ],
    ),
    CategoryNode(
      title: 'Digital Resources',
      icon: Icons.computer_rounded,
      children: [
        CategoryNode(title: 'Cloud Storage', icon: Icons.cloud_queue),
        CategoryNode(title: 'Compute Units', icon: Icons.memory),
        CategoryNode(title: 'Network Bandwidth', icon: Icons.speed),
      ],
    ),
    CategoryNode(
      title: 'Human Capital',
      icon: Icons.people_alt_rounded,
      children: [
        CategoryNode(title: 'Skill Development', icon: Icons.psychology),
        CategoryNode(title: 'Management Training', icon: Icons.supervisor_account),
        CategoryNode(title: 'Welfare Programs', icon: Icons.health_and_safety),
      ],
    ),
    CategoryNode(
      title: 'Operational Assets',
      icon: Icons.inventory_2_rounded,
      children: [
        CategoryNode(title: 'Vehicles', icon: Icons.local_shipping),
        CategoryNode(title: 'Machinery', icon: Icons.settings_suggest),
        CategoryNode(title: 'Office Supplies', icon: Icons.print),
      ],
    ),
  ].obs;

  void toggleNode(CategoryNode node) {
    node.isExpanded.value = !node.isExpanded.value;
  }
}
