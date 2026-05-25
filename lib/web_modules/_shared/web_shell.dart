// ============================================================
// web_modules/_shared/web_shell.dart
// Responsive shell — side drawer on desktop (collapsible), modal on mobile.
// ============================================================

import 'package:air_app/routes/app_pages.dart';
import 'package:air_app/web_modules/web_home/web_home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '_web_layout.dart';
import 'web_nav_data.dart';
import 'web_theme_controller.dart';

// ── Drawer state controller ───────────────────────────────────
class WebDrawerController extends GetxController {
  final isOpen = true.obs;
  void toggle() => isOpen.value = !isOpen.value;
  void open() => isOpen.value = true;
  void close() => isOpen.value = false;
}

WebDrawerController _getDrawerCtrl() {
  if (!Get.isRegistered<WebDrawerController>()) {
    return Get.put(WebDrawerController(), permanent: true);
  }
  return Get.find<WebDrawerController>();
}

class WebShell extends StatelessWidget {
  final Widget child;
  final String currentRoute;
  const WebShell({super.key, required this.child, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    final isDesktop = WBreak.isDesktop(context);
    final isTablet = WBreak.isTablet(context);
    final theme = Theme.of(context);
    final drawerCtrl = _getDrawerCtrl();

    if (isDesktop) {
      return Obx(() {
        final open = drawerCtrl.isOpen.value;
        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          body: Row(
            children: [
              // ── Animated sidebar ──────────────────────────
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: open ? 320 : 0,
                child: ClipRect(
                  child: OverflowBox(
                    alignment: Alignment.topLeft,
                    maxWidth: 320,
                    minWidth: 320,
                    child: SizedBox(
                      width: 320,
                      child: _WebDrawer(
                        currentRoute: currentRoute,
                        isNotMobile: (isTablet || isDesktop),
                        onCollapse: drawerCtrl.close,
                      ),
                    ),
                  ),
                ),
              ),
              // ── Main body ────────────────────────────────
              Expanded(
                child: Stack(
                  children: [
                    child,
                    // Floating hamburger when drawer is closed (desktop)
                    if (!open)
                      Positioned(
                        top: 16,
                        left: 16,
                        child: SafeArea(
                          child: _FloatingMenuButton(onTap: drawerCtrl.open),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      });
    }

    // ── Mobile: modal drawer ──────────────────────────────────
    return Scaffold(
      drawer: Drawer(
        width: 320,
        child: _WebDrawer(
          currentRoute: currentRoute,
          isNotMobile: false,
          onCollapse: null,
        ),
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
                      child: const Icon(
                        Icons.menu_rounded,
                        color: Colors.black87,
                      ),
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

// ── Floating menu button (desktop collapsed state) ────────────
class _FloatingMenuButton extends StatefulWidget {
  final VoidCallback onTap;
  const _FloatingMenuButton({required this.onTap});

  @override
  State<_FloatingMenuButton> createState() => _FloatingMenuButtonState();
}

class _FloatingMenuButtonState extends State<_FloatingMenuButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    )..forward();
    _scale = CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: widget.onTap,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [WColors.indigo, WColors.violet],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: WColors.indigo.withValues(alpha: 0.45),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: const Icon(
              Icons.menu_open_rounded,
              color: Colors.white,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }
}

// ── Drawer widget ─────────────────────────────────────────────
class _WebDrawer extends StatelessWidget {
  final String currentRoute;
  final bool isNotMobile;
  final VoidCallback? onCollapse;
  const _WebDrawer({
    required this.currentRoute,
    required this.isNotMobile,
    required this.onCollapse,
  });

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
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (!isNotMobile) return;
                            if (currentRoute != WebHomeView.routeName) {
                              Get.offAllNamed(AppRoutes.HOME_APP_OLD);
                            }
                          },
                          child: Row(
                            children: [
                              // const CircleAvatar(
                              //   radius: 22,
                              //   backgroundColor: Colors.white,
                              //   child: Icon(Icons.air, color: WColors.indigo),
                              // ),
                              // const SizedBox(width: 12),
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
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const WebThemeToggle(compact: true),
                      // ── Collapse button (desktop only) ──
                      if (isNotMobile) ...[
                        const SizedBox(width: 6),
                        Tooltip(
                          message: 'Collapse sidebar',
                          child: Material(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: onCollapse,
                              child: const Padding(
                                padding: EdgeInsets.all(6),
                                child: Icon(
                                  Icons.chevron_left_rounded,
                                  color: Colors.white,
                                  size: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
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
                      if (!isNotMobile) return;
                      if (currentRoute != WebHomeView.routeName) {
                        Get.offAllNamed(AppRoutes.HOME_APP_OLD);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: WColors.indigo,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.dashboard_rounded, size: 18),
                    label: const Text(
                      'Dashboard',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                      ),
                    ),
                  ),

                  if (!isNotMobile)
                    Column(
                      children: [
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                Get.toNamed(AppRoutes.HOME_APP_OLD);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: WColors.indigo,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 22,
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              icon: const Icon(Icons.explore_rounded),
                              label: const Text(
                                'Explore Base',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                            OutlinedButton.icon(
                              onPressed: () {
                                Get.offNamed(AppRoutes.LOGIN);
                              },
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
                              icon: const Icon(Icons.login_rounded),
                              label: const Text(
                                'Sign In',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ],
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () {
                        if (!isNotMobile) Navigator.of(context).pop();
                        if (currentRoute != section.route) {
                          Get.offAllNamed(section.route);
                        }
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
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
                                color: section.primary.withValues(
                                  alpha: active ? 0.22 : 0.12,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                section.icon,
                                size: 19,
                                color: section.primary,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    section.title,
                                    style: TextStyle(
                                      color: isDark
                                          ? Colors.white
                                          : const Color(0xFF0F172A),
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
                                      color: isDark
                                          ? Colors.white60
                                          : Colors.black54,
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
