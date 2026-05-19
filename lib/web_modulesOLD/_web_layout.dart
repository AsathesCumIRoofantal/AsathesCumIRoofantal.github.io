// ============================================================
// web_modules/_web_layout.dart
// Shared responsive utilities for all Web* pages
// ============================================================

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ── Breakpoints ──────────────────────────────────────────────
class WBreak {
  static bool isMobile(BuildContext ctx) => MediaQuery.of(ctx).size.width < 600;
  static bool isTablet(BuildContext ctx) =>
      MediaQuery.of(ctx).size.width >= 600 &&
      MediaQuery.of(ctx).size.width < 1024;
  static bool isDesktop(BuildContext ctx) =>
      MediaQuery.of(ctx).size.width >= 1024;

  static double cols(BuildContext ctx) {
    final w = MediaQuery.of(ctx).size.width;
    if (w < 600) return 1;
    if (w < 1024) return 2;
    return 3;
  }

  static double maxWidth(BuildContext ctx) {
    final w = MediaQuery.of(ctx).size.width;
    if (w < 600) return w;
    if (w < 1024) return 720;
    return 1100;
  }
}

// ── Brand tokens ─────────────────────────────────────────────
class WColors {
  static const indigo = Color(0xFF4F46E5);
  static const indigoLight = Color(0xFF6366F1);
  static const amber = Color(0xFFF59E0B);
  static const teal = Color(0xFF0D9488);
  static const rose = Color(0xFFE11D48);
  static const emerald = Color(0xFF059669);
  static const sky = Color(0xFF0284C7);
  static const violet = Color(0xFF7C3AED);
  static const surface = Color(0xFFF8FAFC);
  static const surfaceDark = Color(0xFF0F172A);
  static const cardDark = Color(0xFF1E293B);
  static const cardLight = Colors.white;
  static const gold = Color(0xFFD4AF37);
}

// ── Centered max-width wrapper ────────────────────────────────
class WMaxWidth extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  const WMaxWidth({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: WBreak.maxWidth(context)),
        child: Padding(
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
          child: child,
        ),
      ),
    );
  }
}

// ── Responsive grid ──────────────────────────────────────────
class WGrid extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final int? forceColumns;
  const WGrid({
    super.key,
    required this.children,
    this.spacing = 16,
    this.forceColumns,
  });

  @override
  Widget build(BuildContext context) {
    final cols = forceColumns ?? WBreak.cols(context).toInt();
    final rows = (children.length / cols).ceil();

    return Column(
      children: List.generate(rows, (row) {
        final start = row * cols;
        final end = (start + cols).clamp(0, children.length);
        final rowItems = children.sublist(start, end);

        return Padding(
          padding: EdgeInsets.only(bottom: spacing),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                List.generate(rowItems.length * 2 - 1, (i) {
                  if (i.isOdd) return SizedBox(width: spacing);
                  return Expanded(child: rowItems[i ~/ 2]);
                })..addAll(
                  List.generate(
                    (cols - rowItems.length) * 2,
                    (_) => const Expanded(child: SizedBox()),
                  ),
                ),
          ),
        );
      }),
    );
  }
}

// ── Section header ───────────────────────────────────────────
class WSectionHeader extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String? subtitle;
  final Color accent;
  const WSectionHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    this.subtitle,
    this.accent = WColors.indigo,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 36, height: 3, color: accent),
            const SizedBox(width: 10),
            Text(
              eyebrow.toUpperCase(),
              style: TextStyle(
                color: accent,
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 2.2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: WBreak.isMobile(context) ? 22 : 28,
            fontWeight: FontWeight.w800,
            color: isDark ? Colors.white : const Color(0xFF0F172A),
            height: 1.2,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(
            subtitle!,
            style: TextStyle(
              fontSize: 15,
              height: 1.6,
              color: isDark ? Colors.white60 : Colors.black54,
            ),
          ),
        ],
      ],
    );
  }
}

// ── Feature card ─────────────────────────────────────────────
class WFeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;
  final Color color;
  final String? routeName;
  const WFeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
    this.routeName,
    this.color = WColors.indigo,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (routeName != null) Get.toNamed(routeName!);
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? WColors.cardDark : WColors.cardLight,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.18)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.06),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 14),
            Text(
              title,
              style: TextStyle(
                fontSize: 15.5,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              body,
              style: TextStyle(
                fontSize: 13.5,
                height: 1.55,
                color: isDark ? Colors.white60 : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Stat chip ────────────────────────────────────────────────
class WStatChip extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  const WStatChip({
    super.key,
    required this.value,
    required this.label,
    this.color = WColors.indigo,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.12),
            color.withValues(alpha: 0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white60 : Colors.black54,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Hero banner ──────────────────────────────────────────────
class WHeroBanner extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color colorA;
  final Color colorB;
  final IconData icon;
  final List<Widget>? actions;
  const WHeroBanner({
    super.key,
    required this.title,
    required this.subtitle,
    this.colorA = WColors.indigo,
    this.colorB = WColors.violet,
    this.icon = Icons.star_rounded,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final isMob = WBreak.isMobile(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorA, colorB],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: WMaxWidth(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: isMob ? 40 : 60,
        ),
        child: isMob
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    icon,
                    color: Colors.white.withValues(alpha: 0.5),
                    size: 56,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 15,
                      height: 1.6,
                    ),
                  ),
                  if (actions != null) ...[
                    const SizedBox(height: 24),
                    Wrap(spacing: 12, runSpacing: 12, children: actions!),
                  ],
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 38,
                            fontWeight: FontWeight.w900,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          subtitle,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 16,
                            height: 1.7,
                          ),
                        ),
                        if (actions != null) ...[
                          const SizedBox(height: 28),
                          Wrap(spacing: 12, runSpacing: 12, children: actions!),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 40),
                  Icon(
                    icon,
                    color: Colors.white.withValues(alpha: 0.25),
                    size: 120,
                  ),
                ],
              ),
      ),
    );
  }
}

// ── Pill badge ───────────────────────────────────────────────
class WBadge extends StatelessWidget {
  final String label;
  final Color color;
  const WBadge({super.key, required this.label, this.color = WColors.indigo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// ── Divider with label ────────────────────────────────────────
class WDividerLabel extends StatelessWidget {
  final String label;
  const WDividerLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}

// ── Web nav bar ──────────────────────────────────────────────
class WNavBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color color;
  final List<Widget>? actions;
  const WNavBar({
    super.key,
    required this.title,
    this.color = WColors.indigo,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color,
      foregroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.white),
      elevation: 0,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.5,
        ),
      ),
      actions: actions,
    );
  }
}
