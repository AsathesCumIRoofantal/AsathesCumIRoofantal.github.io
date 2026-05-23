// web_modules/web_be_you/web_be_you_view.dart
// Section workspace — unique palette, hero, item grid, and detail.

import 'package:air_app/web_modules/web_be_you/pages/web_identities_earnings_b_view.dart';
import 'package:air_app/web_modules/web_be_you/pages/web_identities_earnings_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../_shared/_web_layout.dart';
import '../_shared/web_nav_data.dart';
import '../_shared/web_shell.dart';
import 'web_be_you_controller.dart';

class WebBeYouView extends GetView<WebBeYouController> {
  const WebBeYouView({super.key});

  static const String routeName = '/web-be_you';
  static final WebNavSection section = WebNavData.bySlug('be_you');

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark
        ? WColors.surfaceDark
        : section.accent.withValues(alpha: 0.35);

    return WebShell(
      currentRoute: routeName,
      child: Scaffold(
        backgroundColor: bg,
        body: SingleChildScrollView(
          controller: controller.scrollController,
          child: Column(
            children: [
              _SectionHero(section: section),
              const SizedBox(height: 32),
              WMaxWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WSectionHeader(
                      eyebrow: '${section.items.length} topics',
                      title: 'Workspaces in this section',
                      subtitle:
                          'Each tile is a focused topic inside ${section.title}. '
                          'Tap to read its purpose and how to use it.',
                      accent: section.primary,
                    ),
                    const SizedBox(height: 24),
                    _SearchBar(controller: controller, color: section.primary),
                    const SizedBox(height: 20),
                    Obx(() {
                      final q = controller.searchQuery.value;
                      final items = q.isEmpty
                          ? section.items
                          : section.items
                                .where(
                                  (it) =>
                                      it.title.toLowerCase().contains(q) ||
                                      it.description.toLowerCase().contains(q),
                                )
                                .toList();
                      if (items.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: Center(
                            child: Text(
                              'No topics match "$q".',
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ),
                        );
                      }
                      return WGrid(
                        children: items
                            .map(
                              (it) =>
                                  _ItemCard(item: it, color: section.primary),
                            )
                            .toList(),
                      );
                    }),
                    const SizedBox(height: 48),
                    _CallToAction(section: section),
                    const SizedBox(height: 56),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHero extends StatelessWidget {
  final WebNavSection section;
  const _SectionHero({required this.section});

  @override
  Widget build(BuildContext context) {
    final isMob = WBreak.isMobile(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [section.primary, section.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: isMob ? 64 : 96),
      child: WMaxWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 10,
              runSpacing: 8,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(section.icon, color: Colors.white, size: 16),
                      const SizedBox(width: 8),
                      Text(
                        section.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 11,
                          letterSpacing: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    '${section.items.length} topics',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            Text(
              section.tagline,
              style: TextStyle(
                color: Colors.white,
                fontSize: isMob ? 28 : 42,
                fontWeight: FontWeight.w900,
                height: 1.15,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 14),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Text(
                section.blurb,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.92),
                  fontSize: isMob ? 14.5 : 16,
                  height: 1.7,
                ),
              ),
            ),
            const SizedBox(height: 28),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ElevatedButton.icon(
                  onPressed: () => Get.toNamed(WebNavData.homeRoute),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: section.primary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  icon: const Icon(Icons.dashboard_rounded),
                  label: const Text(
                    'Back to atlas',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white54),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  icon: const Icon(Icons.bookmark_add_outlined),
                  label: const Text(
                    'Save workspace',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final WebBeYouController controller;
  final Color color;
  const _SearchBar({required this.controller, required this.color});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? WColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: TextField(
        onChanged: controller.setQuery,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: color),
          hintText: 'Filter topics in this workspace…',
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}

class _ItemCard extends StatelessWidget {
  final WebNavItem item;
  final Color color;
  const _ItemCard({required this.item, required this.color});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => _openDetail(context),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isDark ? WColors.cardDark : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.18)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.22 : 0.04),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(item.icon, color: color, size: 22),
            ),
            const SizedBox(height: 14),
            Text(
              item.title,
              style: TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              item.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.5,
                height: 1.55,
                color: isDark ? Colors.white60 : Colors.black54,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  'Open',
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(Icons.arrow_forward_rounded, color: color, size: 14),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _openDetail(BuildContext context) {
    if (item.title == 'Share Experience') {
      Get.toNamed('/web-be-you/share-experience');
      return;
    } else if (item.title == 'Record Your Post') {
      Get.toNamed('/web-be_you/record-post');
      return;
    } else if (item.title == 'Identities Cum Earnings') {
      // THIS IS THE NEWLY IMPLEMENTED ROUTE
      Get.toNamed(WebIdentitiesEarningsBView.routeName);
      return;
      Get.toNamed(WebIdentitiesEarningsView.routeName);
      return;
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(item.icon, color: color, size: 30),
            ),
            const SizedBox(height: 16),
            Text(
              item.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 10),
            Text(
              item.description,
              style: const TextStyle(
                fontSize: 14.5,
                height: 1.6,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Got it',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class _CallToAction extends StatelessWidget {
  final WebNavSection section;
  const _CallToAction({required this.section});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 36),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            section.primary.withValues(alpha: 0.10),
            section.secondary.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: section.primary.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Use this workspace alongside the home tabs',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: section.secondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            section.blurb,
            style: const TextStyle(
              fontSize: 14,
              height: 1.6,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              ElevatedButton.icon(
                onPressed: () => Get.toNamed(WebNavData.homeRoute),
                style: ElevatedButton.styleFrom(
                  backgroundColor: section.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                icon: const Icon(Icons.dashboard_rounded),
                label: const Text(
                  'Explore other workspaces',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
