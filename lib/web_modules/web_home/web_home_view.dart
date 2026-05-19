// web_modules/web_home/web_home_view.dart
// Landing page — hero + grid of section cards, each linking to a dedicated page.

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../_shared/_web_layout.dart';
import '../_shared/web_nav_data.dart';
import '../_shared/web_shell.dart';
import 'web_home_controller.dart';

class WebHomeView extends GetView<WebHomeController> {
  const WebHomeView({super.key});

  static const String routeName = WebNavData.homeRoute;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return WebShell(
      currentRoute: routeName,
      child: Scaffold(
        backgroundColor: isDark ? WColors.surfaceDark : WColors.surface,
        body: SingleChildScrollView(
          controller: controller.scrollController,
          child: Column(
            children: [
              // ── HERO ──
              const WHeroBanner(
                title: 'Everything in One Space',
                subtitle:
                    'AIR — Alifiyas Integrated Reality — is a living platform where '
                    'knowledge, identity, creativity, and community converge into a '
                    'single All-Space. Eleven workspaces, one atlas.',
                colorA: WColors.indigo,
                colorB: WColors.violet,
                icon: Icons.public_rounded,
              ),

              // ── STATS ──
              Container(
                color: isDark ? WColors.cardDark : Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 28),
                child: WMaxWidth(
                  child: WBreak.isMobile(context)
                      ? Column(
                          children: const [
                            WStatChip(value: '11', label: 'Workspaces', color: WColors.indigo),
                            SizedBox(height: 12),
                            WStatChip(value: '150+', label: 'Linked Topics', color: WColors.teal),
                            SizedBox(height: 12),
                            WStatChip(value: '∞', label: 'Room to Grow', color: WColors.amber),
                          ],
                        )
                      : Row(
                          children: const [
                            Expanded(child: WStatChip(value: '11', label: 'Workspaces', color: WColors.indigo)),
                            SizedBox(width: 12),
                            Expanded(child: WStatChip(value: '150+', label: 'Linked Topics', color: WColors.teal)),
                            SizedBox(width: 12),
                            Expanded(child: WStatChip(value: '∞', label: 'Room to Grow', color: WColors.amber)),
                          ],
                        ),
                ),
              ),

              const SizedBox(height: 48),
              WMaxWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const WSectionHeader(
                      eyebrow: 'The Atlas',
                      title: 'Pick a workspace',
                      subtitle:
                          'Each card opens its own page with the full menu, hero, '
                          'and topic detail. Use the drawer to jump anywhere, anytime.',
                      accent: WColors.indigo,
                    ),
                    const SizedBox(height: 32),
                    WGrid(
                      children: [
              _SectionCard(
                section: WebNavData.bySlug('explore'),
              ),
              _SectionCard(
                section: WebNavData.bySlug('wisdom'),
              ),
              _SectionCard(
                section: WebNavData.bySlug('be_you'),
              ),
              _SectionCard(
                section: WebNavData.bySlug('air_space'),
              ),
              _SectionCard(
                section: WebNavData.bySlug('profile'),
              ),
              _SectionCard(
                section: WebNavData.bySlug('aspects'),
              ),
              _SectionCard(
                section: WebNavData.bySlug('service'),
              ),
              _SectionCard(
                section: WebNavData.bySlug('vision'),
              ),
              _SectionCard(
                section: WebNavData.bySlug('motivation'),
              ),
              _SectionCard(
                section: WebNavData.bySlug('setup'),
              ),
              _SectionCard(
                section: WebNavData.bySlug('system'),
              ),
                      ],
                    ),
                    const SizedBox(height: 56),
                  ],
                ),
              ),

              // ── FOOTER CTA ──
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [WColors.teal, WColors.sky]),
                ),
                padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 20),
                child: WMaxWidth(
                  child: Column(
                    children: [
                      const Text(
                        'Ready to enter All-Space?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Open the drawer, pick a workspace, and start mapping your part of AIR.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontSize: 15,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final WebNavSection section;
  const _SectionCard({required this.section});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => Get.toNamed(section.route),
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: isDark ? WColors.cardDark : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: section.primary.withValues(alpha: 0.25)),
          boxShadow: [
            BoxShadow(
              color: section.primary.withValues(alpha: 0.10),
              blurRadius: 22,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [section.primary, section.secondary],
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(section.icon, color: Colors.white, size: 26),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: section.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    '${section.items.length} items',
                    style: TextStyle(
                      color: section.primary,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              section.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
                letterSpacing: 0.4,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              section.tagline,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: section.primary,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              section.blurb,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                height: 1.55,
                color: isDark ? Colors.white70 : Colors.black54,
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Text(
                  'Open workspace',
                  style: TextStyle(
                    color: section.primary,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(width: 6),
                Icon(Icons.arrow_forward_rounded, color: section.primary, size: 18),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
