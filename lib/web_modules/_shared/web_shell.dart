// ============================================================
// web_modules/_shared/web_shell.dart
// Responsive shell — side drawer on desktop, modal drawer on mobile.
// ============================================================

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '_web_layout.dart';
import 'web_nav_data.dart';
import 'web_theme_controller.dart';

class WebShell extends StatelessWidget {
  final Widget child;
  final String currentRoute;
  const WebShell({super.key, required this.child, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    final isDesktop = WBreak.isDesktop(context);
    final theme = Theme.of(context);

    if (isDesktop) {
      return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: Row(
          children: [
            SizedBox(
              width: 320,
              child: _WebDrawer(currentRoute: currentRoute, isDesktop: true),
            ),
            Expanded(child: child),
          ],
        ),
      );
    }

    return Scaffold(
      drawer: Drawer(
        width: 320,
        child: _WebDrawer(currentRoute: currentRoute, isDesktop: false),
      ),
      body: Stack(
        children: [
          child,
          Positioned(
            top: 12,
            left: 12,
            child: SafeArea(
              child: Builder(
                builder: (ctx) => Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () => Scaffold.of(ctx).openDrawer(),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.95),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.12),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.menu_rounded, color: Colors.black87),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WebDrawer extends StatelessWidget {
  final String currentRoute;
  final bool isDesktop;
  const _WebDrawer({required this.currentRoute, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      color: isDark ? const Color(0xFF0B1220) : Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            // ── header ──
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 22),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [WColors.indigo, WColors.violet],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (!isDesktop) Navigator.of(context).pop();
                      if (currentRoute != WebNavData.homeRoute) {
                        Get.offAllNamed(WebNavData.homeRoute);
                      }
                    },
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.air, color: WColors.indigo),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'AIR · ALL-SPACE',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Alifiyas-Mazeasta · Web',
                                style: TextStyle(color: Colors.white70, fontSize: 11),
                              ),
                            ],
                          ),
                        ),
                        const WebThemeToggle(compact: true),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'This drawer mirrors your all-space atlas. Each link opens a focused workspace.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.88),
                      fontSize: 11.5,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (!isDesktop) Navigator.of(context).pop();
                      if (currentRoute != WebNavData.homeRoute) {
                        Get.offAllNamed(WebNavData.homeRoute);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: WColors.indigo,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.dashboard_rounded, size: 18),
                    label: const Text(
                      'Dashboard',
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),

            // ── sections ──
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 12),
                itemCount: WebNavData.sections.length,
                itemBuilder: (ctx, i) {
                  final section = WebNavData.sections[i];
                  final active = currentRoute == section.route;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () {
                        if (!isDesktop) Navigator.of(context).pop();
                        if (currentRoute != section.route) {
                          Get.offAllNamed(section.route);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        decoration: BoxDecoration(
                          color: active
                              ? section.primary.withValues(alpha: 0.12)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: active
                                ? section.primary.withValues(alpha: 0.35)
                                : Colors.transparent,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                color: section.primary.withValues(alpha: active ? 0.22 : 0.12),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(section.icon, size: 19, color: section.primary),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    section.title,
                                    style: TextStyle(
                                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    '${section.items.length} items · ${section.tagline}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: isDark ? Colors.white60 : Colors.black54,
                                      fontSize: 10.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 12,
                              color: active ? section.primary : Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
