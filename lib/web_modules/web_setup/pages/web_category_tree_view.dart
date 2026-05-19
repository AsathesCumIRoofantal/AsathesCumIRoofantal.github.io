import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../_shared/_web_layout.dart';
import '../../_shared/web_shell.dart';
import 'web_category_tree_controller.dart';

class WebCategoryTreeView extends GetView<WebCategoryTreeController> {
  const WebCategoryTreeView({super.key});

  static const String routeName = '/web-setup/category-tree';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = const Color(0xFF64748B); // Slate/Grey from Setup section
    final bg = isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC);

    return WebShell(
      currentRoute: routeName,
      child: Scaffold(
        backgroundColor: bg,
        body: Column(
          children: [
            // ── HEADER ──
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              decoration: BoxDecoration(
                color: isDark ? WColors.cardDark : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_rounded, color: primary),
                    onPressed: () => Get.back(),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.account_tree_rounded, color: primary),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Category Tree',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      Text(
                        'Hierarchical mapping of the AIR system.',
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark ? Colors.white60 : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Add Node', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),

            // ── TREE MAP VIEW ──
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(48),
                child: WMaxWidth(
                  child: Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: isDark ? WColors.cardDark : Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.05),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTreeNode(
                          id: 'root',
                          title: 'AIR Global System',
                          subtitle: 'Master Node',
                          icon: Icons.public,
                          primary: primary,
                          isDark: isDark,
                          children: [
                            _buildTreeNode(
                              id: 'org',
                              title: 'Organizational Structure',
                              subtitle: 'Roles & Access',
                              icon: Icons.corporate_fare,
                              primary: primary,
                              isDark: isDark,
                              children: [
                                _buildLeafNode('Mazeasta Hub', primary, isDark),
                                _buildLeafNode('Alifiyas Onboarding', primary, isDark),
                              ],
                            ),
                            _buildTreeNode(
                              id: 'data',
                              title: 'Data Centers',
                              subtitle: 'Storage & Logs',
                              icon: Icons.storage,
                              primary: primary,
                              isDark: isDark,
                              children: [
                                _buildLeafNode('Active Traces', primary, isDark),
                                _buildLeafNode('Archived Knowledge', primary, isDark),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTreeNode({
    required String id,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color primary,
    required bool isDark,
    required List<Widget> children,
  }) {
    return Obx(() {
      final isExpanded = controller.expandedNodes.contains(id);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => controller.toggleNode(id),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isExpanded ? primary.withValues(alpha: 0.3) : Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(12),
                color: isExpanded ? primary.withValues(alpha: 0.05) : Colors.transparent,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedRotation(
                    turns: isExpanded ? 0.25 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(Icons.chevron_right, color: isDark ? Colors.white54 : Colors.black45),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon, size: 20, color: primary),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? Colors.white54 : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity, height: 0),
            secondChild: Container(
              margin: const EdgeInsets.only(left: 32, top: 8, bottom: 8),
              padding: const EdgeInsets.only(left: 24),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: primary.withValues(alpha: 0.2),
                    width: 2,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),
            ),
            crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      );
    });
  }

  Widget _buildLeafNode(String title, Color primary, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.02) : Colors.black.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.05),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.horizontal_rule_rounded, size: 16, color: primary.withValues(alpha: 0.5)),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
