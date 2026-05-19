import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../_shared/_web_layout.dart';
import '../../_shared/web_shell.dart';
import 'web_knowledge_center_controller.dart';

class WebKnowledgeCenterView extends GetView<WebKnowledgeCenterController> {
  const WebKnowledgeCenterView({super.key});

  static const String routeName = '/web-air-space/knowledge-center';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = const Color(0xFF0284C7); // Sky Blue
    final isDesktop = WBreak.isDesktop(context);

    return WebShell(
      currentRoute: routeName,
      child: Scaffold(
        backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9),
        body: Column(
          children: [
            // ── TOP NAVIGATION BAR ──
            Container(
              height: 72,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: isDark ? WColors.cardDark : Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.05),
                  ),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_rounded, color: primary),
                    onPressed: () => Get.back(),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.library_books_rounded, color: primary, size: 22),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Knowledge Center',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: 300,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.03),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search documents, papers, reports...',
                        hintStyle: TextStyle(fontSize: 13, color: isDark ? Colors.white54 : Colors.black54),
                        prefixIcon: Icon(Icons.search, size: 18, color: isDark ? Colors.white54 : Colors.black54),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    icon: const Icon(Icons.cloud_upload_rounded, size: 18),
                    label: const Text('Upload Asset', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),

            // ── MAIN CONTENT (SIDEBAR + GRID) ──
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Taxonomy Sidebar (Desktop)
                  if (isDesktop)
                    Container(
                      width: 280,
                      decoration: BoxDecoration(
                        color: isDark ? WColors.cardDark : Colors.white,
                        border: Border(
                          right: BorderSide(
                            color: isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.05),
                          ),
                        ),
                      ),
                      child: _buildSidebar(primary, isDark),
                    ),
                    
                  // Assets Grid
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(() => Text(
                                controller.activeCategory.value,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                              )),
                              Row(
                                children: [
                                  IconButton(icon: const Icon(Icons.grid_view_rounded), onPressed: () {}),
                                  IconButton(icon: const Icon(Icons.list_rounded), onPressed: () {}),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 24),
                          Expanded(
                            child: SingleChildScrollView(
                              child: AnimationLimiter(
                                child: WGrid(
                                  children: List.generate(
                                    8,
                                    (index) => AnimationConfiguration.staggeredGrid(
                                      position: index,
                                      duration: const Duration(milliseconds: 400),
                                      columnCount: 4,
                                      child: ScaleAnimation(
                                        child: FadeInAnimation(
                                          child: _AssetCard(index: index, primary: primary),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebar(Color primary, bool isDark) {
    final categories = ['All Assets', 'Research Papers', 'Policy Documents', 'Project Reports', 'Meeting Minutes', 'Archived'];
    final icons = [Icons.all_inclusive, Icons.science, Icons.policy, Icons.assessment, Icons.groups, Icons.archive];

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      children: [
        Text(
          'CATEGORIES',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w900,
            color: isDark ? Colors.white54 : Colors.black45,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        ...List.generate(categories.length, (i) {
          return Obx(() {
            final active = controller.activeCategory.value == categories[i];
            return InkWell(
              onTap: () => controller.setCategory(categories[i]),
              borderRadius: BorderRadius.circular(8),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: active ? primary.withValues(alpha: 0.1) : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      icons[i],
                      size: 20,
                      color: active ? primary : (isDark ? Colors.white54 : Colors.black54),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      categories[i],
                      style: TextStyle(
                        fontWeight: active ? FontWeight.bold : FontWeight.normal,
                        color: active ? primary : (isDark ? Colors.white70 : Colors.black87),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        }),
        const SizedBox(height: 40),
        Text(
          'TAGS',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w900,
            color: isDark ? Colors.white54 : Colors.black45,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildTag('Q3 Data', primary),
            _buildTag('Public', primary),
            _buildTag('Confidential', primary),
            _buildTag('Draft', primary),
          ],
        ),
      ],
    );
  }

  Widget _buildTag(String text, Color primary) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: primary.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 11, color: primary, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _AssetCard extends StatefulWidget {
  final int index;
  final Color primary;
  const _AssetCard({required this.index, required this.primary});

  @override
  State<_AssetCard> createState() => _AssetCardState();
}

class _AssetCardState extends State<_AssetCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fileTypes = ['PDF', 'DOCX', 'XLSX', 'PPTX'];
    final colors = [Colors.redAccent, Colors.blueAccent, Colors.green, Colors.orange];
    
    final typeIndex = widget.index % 4;
    final type = fileTypes[typeIndex];
    final color = colors[typeIndex];

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, _isHovered ? -4 : 0, 0),
        decoration: BoxDecoration(
          color: isDark ? WColors.cardDark : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered ? widget.primary.withValues(alpha: 0.3) : (isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.05)),
          ),
          boxShadow: [
            if (_isHovered)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              ),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    type,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, letterSpacing: 1),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Strategic Plan 2026_v${widget.index + 1}.0',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : Colors.black87,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Updated 2 days ago',
                    style: TextStyle(fontSize: 11, color: isDark ? Colors.white54 : Colors.black45),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '2.4 MB',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: widget.primary),
                      ),
                      Row(
                        children: [
                          Icon(Icons.remove_red_eye_outlined, size: 18, color: isDark ? Colors.white54 : Colors.black45),
                          const SizedBox(width: 12),
                          Icon(Icons.file_download_outlined, size: 18, color: isDark ? Colors.white54 : Colors.black45),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
