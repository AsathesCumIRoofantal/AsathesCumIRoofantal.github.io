// web_modules/web_air_space/web_air_space_view.dart
// Section workspace — unique palette, hero, item grid, and detail.
// ENHANCED: Slivers, pinned header, parallax scrolling, advanced animations

import 'package:air_app/web_modules/web_air_space/pages/web_utilities_guest_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'dart:math' as math;

import '../_shared/_web_layout.dart';
import '../_shared/web_nav_data.dart';
import '../_shared/web_shell.dart';
import 'web_air_space_controller.dart';

class WebAirSpaceView extends GetView<WebAirSpaceController> {
  const WebAirSpaceView({super.key});

  static const String routeName = '/web-air_space';
  static final WebNavSection section = WebNavData.bySlug('air_space');

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
        body: CustomScrollView(
          controller: controller.scrollController,
          slivers: [
            // ── PARALLAX HERO WITH SLIVER APP BAR ──
            SliverAppBar(
              expandedHeight: WBreak.isMobile(context) ? 300 : 400,
              pinned: true,
              backgroundColor: section.primary,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  section.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  ),
                ),
                background: _ParallaxHero(section: section),
              ),
            ),

            // ── FLOATING SEARCH BAR ──
            SliverPersistentHeader(
              pinned: true,
              delegate: _SearchBarDelegate(
                controller: controller,
                color: section.primary,
                minHeight: 80,
                maxHeight: 80,
              ),
            ),

            SliverToBoxAdapter(child: const SizedBox(height: 20)),

            // ── SECTION HEADER ──
            SliverToBoxAdapter(
              child: WMaxWidth(
                child: AnimationConfiguration.staggeredList(
                  position: 0,
                  duration: const Duration(milliseconds: 600),
                  child: FadeInAnimation(
                    child: WSectionHeader(
                      eyebrow: '${section.items.length} topics',
                      title: 'Explore AIR\'s Space & Resources',
                      subtitle:
                          'Each tile is a focused topic inside ${section.title}. '
                          'Tap to read its purpose and how to use it.',
                      accent: section.primary,
                    ),
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(child: const SizedBox(height: 24)),

            // ── ANIMATED GRID WITH SLIVERS ──
            Obx(() {
              final q = controller.searchQuery.value.toLowerCase();
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
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Center(
                      child: Text(
                        'No topics match "$q".',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: WBreak.cols(context).toInt(),
                    childAspectRatio: 0.95,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 500),
                      columnCount: WBreak.cols(context).toInt(),
                      child: ScaleAnimation(
                        scale: 0.5,
                        child: FadeInAnimation(
                          child: _EnhancedItemCard(
                            item: items[index],
                            color: section.primary,
                          ),
                        ),
                      ),
                    );
                  }, childCount: items.length),
                ),
              );
            }),

            SliverToBoxAdapter(child: const SizedBox(height: 48)),

            // ── CALL TO ACTION ──
            SliverToBoxAdapter(
              child: WMaxWidth(child: _CallToAction(section: section)),
            ),

            SliverToBoxAdapter(child: const SizedBox(height: 56)),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
// ENHANCED WIDGETS
// ══════════════════════════════════════════════════════════════

class _ParallaxHero extends StatefulWidget {
  final WebNavSection section;
  const _ParallaxHero({required this.section});

  @override
  State<_ParallaxHero> createState() => _ParallaxHeroState();
}

class _ParallaxHeroState extends State<_ParallaxHero>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMob = WBreak.isMobile(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [widget.section.primary, widget.section.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children: [
              // Animated background patterns
              Positioned(
                top: 40 + math.sin(_controller.value * 2 * math.pi) * 15,
                left: 30,
                child: Opacity(
                  opacity: 0.1,
                  child: Transform.rotate(
                    angle: _controller.value * 2 * math.pi,
                    child: Icon(
                      widget.section.icon,
                      size: 120,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 60 + math.cos(_controller.value * 2 * math.pi) * 20,
                right: 50,
                child: Opacity(
                  opacity: 0.08,
                  child: Transform.rotate(
                    angle: -_controller.value * 2 * math.pi,
                    child: const Icon(
                      Icons.hexagon,
                      size: 90,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              // Content
              Positioned(
                bottom: isMob ? 60 : 80,
                left: 20,
                right: 20,
                child: WMaxWidth(
                  padding: EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: 'section_${widget.section.slug}',
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                widget.section.icon,
                                color: Colors.white,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${widget.section.items.length} topics',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.section.tagline,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isMob ? 24 : 36,
                          fontWeight: FontWeight.w900,
                          height: 1.15,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 600),
                        child: Text(
                          widget.section.blurb,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 14,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SearchBarDelegate extends SliverPersistentHeaderDelegate {
  final WebAirSpaceController controller;
  final Color color;
  final double minHeight;
  final double maxHeight;

  _SearchBarDelegate({
    required this.controller,
    required this.color,
    required this.minHeight,
    required this.maxHeight,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      color: isDark ? WColors.surfaceDark : WColors.surface,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: WMaxWidth(
        padding: EdgeInsets.zero,
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? WColors.cardDark : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withValues(alpha: 0.3)),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.15),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            onChanged: controller.setQuery,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: color, size: 24),
              suffixIcon: Obx(() {
                return controller.searchQuery.value.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, color: color),
                        onPressed: () => controller.setQuery(''),
                      )
                    : const SizedBox();
              }),
              hintText: 'Search topics in this workspace…',
              hintStyle: TextStyle(
                color: isDark ? Colors.white38 : Colors.black38,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(_SearchBarDelegate oldDelegate) => false;

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;
}

class _EnhancedItemCard extends StatefulWidget {
  final WebNavItem item;
  final Color color;
  const _EnhancedItemCard({required this.item, required this.color});

  @override
  State<_EnhancedItemCard> createState() => _EnhancedItemCardState();
}

class _EnhancedItemCardState extends State<_EnhancedItemCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _controller.reverse();
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, -_controller.value * 8),
            child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () => _openDetail(context, widget.item),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark ? WColors.cardDark : Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: widget.color.withValues(
                      alpha: 0.18 + _controller.value * 0.2,
                    ),
                    width: 1 + _controller.value,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: isDark ? 0.3 : 0.06,
                      ),
                      blurRadius: 14 + _controller.value * 10,
                      offset: Offset(0, 4 + _controller.value * 4),
                    ),
                    BoxShadow(
                      color: widget.color.withValues(
                        alpha: _controller.value * 0.2,
                      ),
                      blurRadius: 20,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: widget.color.withValues(
                              alpha: 0.12 + _controller.value * 0.08,
                            ),
                            borderRadius: BorderRadius.circular(
                              12 + _controller.value * 4,
                            ),
                          ),
                          child: Icon(
                            widget.item.icon,
                            color: widget.color,
                            size: 24 + _controller.value * 2,
                          ),
                        ),
                        const Spacer(),
                        if (_isHovered)
                          FadeInAnimation(
                            duration: const Duration(milliseconds: 200),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: widget.color.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.arrow_forward_rounded,
                                color: widget.color,
                                size: 16,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.item.title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Text(
                        widget.item.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12.5,
                          height: 1.5,
                          color: isDark ? Colors.white60 : Colors.black54,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text(
                          'Learn more',
                          style: TextStyle(
                            color: widget.color,
                            fontWeight: FontWeight.w800,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 4),
                        AnimatedRotation(
                          turns: _isHovered ? 0.0 : -0.125,
                          duration: const Duration(milliseconds: 300),
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            color: widget.color,
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _openDetail(BuildContext context, WebNavItem item) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (item.title == 'Knowledge Center') {
      Get.toNamed('/web-air-space/knowledge-center');
      return;
    } else if (item.title == 'Products & Services') {
      Get.toNamed('/web-air_space/products-services');
      return;
    } else if (item.title == 'Query & Discussion') {
      Get.toNamed('/web-air_space/query-discussion');
      return;
    } else if (item.title == 'Utilities as Guest') {
      Get.toNamed(WebUtilitiesGuestView.routeName);
      return;
    }
    // else if (item.title == 'Record Your Post') {
    //   Get.toNamed('/web-be_you/record-post');
    //   return;
    // }
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: isDark ? WColors.cardDark : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [widget.color, widget.color.withValues(alpha: 0.6)],
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(widget.item.icon, color: Colors.white, size: 36),
            ),
            const SizedBox(height: 20),
            Text(
              widget.item.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.item.description,
              style: TextStyle(
                fontSize: 15,
                height: 1.6,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.color,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Got it',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AnimationConfiguration.staggeredList(
      position: 0,
      duration: const Duration(milliseconds: 600),
      child: FadeInAnimation(
        delay: const Duration(milliseconds: 400),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: section.primary.withValues(alpha: 0.3)),
            gradient: LinearGradient(
              colors: [
                section.primary.withValues(alpha: isDark ? 0.2 : 0.12),
                section.secondary.withValues(alpha: isDark ? 0.15 : 0.08),
              ],
            ),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.rocket_launch_rounded,
                color: section.primary,
                size: 40,
              ),
              const SizedBox(height: 16),
              Text(
                'Ready to explore more?',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: section.secondary,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                section.blurb,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.6,
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
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
                        horizontal: 24,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    icon: const Icon(Icons.dashboard_rounded),
                    label: const Text(
                      'View all workspaces',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: section.primary,
                      side: BorderSide(color: section.primary),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    icon: const Icon(Icons.bookmark_add_outlined),
                    label: const Text(
                      'Save for later',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
