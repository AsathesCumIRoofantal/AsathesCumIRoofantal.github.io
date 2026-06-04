import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '_web_layout.dart';
import 'web_nav_data.dart';
import 'web_shell.dart';

class ShowcaseMetric {
  final String value;
  final String label;

  const ShowcaseMetric({required this.value, required this.label});
}

class ShowcaseSpotlight {
  final String title;
  final String body;
  final IconData icon;

  const ShowcaseSpotlight({
    required this.title,
    required this.body,
    required this.icon,
  });
}

class ShowcaseTimelineEntry {
  final String label;
  final String title;
  final String body;

  const ShowcaseTimelineEntry({
    required this.label,
    required this.title,
    required this.body,
  });
}

class ShowcasePageTemplate extends StatelessWidget {
  final String currentRoute;
  final WebNavSection section;
  final String pageTitle;
  final String pageSubtitle;
  final IconData heroIcon;
  final List<ShowcaseMetric> metrics;
  final List<ShowcaseSpotlight> spotlights;
  final List<WebNavItem> items;
  final List<ShowcaseTimelineEntry> timeline;
  final List<Widget> footerBlocks;
  final RxString? searchQuery;
  final ValueChanged<String>? onSearchChanged;
  final String searchHint;

  const ShowcasePageTemplate({
    super.key,
    required this.currentRoute,
    required this.section,
    required this.pageTitle,
    required this.pageSubtitle,
    required this.heroIcon,
    required this.metrics,
    required this.spotlights,
    required this.items,
    required this.timeline,
    this.footerBlocks = const [],
    this.searchQuery,
    this.onSearchChanged,
    this.searchHint = 'Search inner topics...',
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final filteredItems = searchQuery == null
        ? items
        : items.where((item) {
            final q = searchQuery!.value.trim().toLowerCase();
            if (q.isEmpty) return true;
            return item.title.toLowerCase().contains(q) ||
                item.description.toLowerCase().contains(q);
          }).toList();

    return WebShell(
      currentRoute: currentRoute,
      child: Scaffold(
        backgroundColor: isDark
            ? WColors.surfaceDark
            : section.accent.withValues(alpha: 0.35),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: WBreak.isMobile(context) ? 570 : 442,
              pinned: true,
              elevation: 0,
              backgroundColor: section.primary,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_rounded),
                onPressed: () => Get.back(),
              ),
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  pageTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  ),
                ),
                background: _ShowcaseHero(
                  section: section,
                  pageTitle: pageTitle,
                  pageSubtitle: pageSubtitle,
                  heroIcon: heroIcon,
                  metrics: metrics,
                ),
              ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 20)),
            if (searchQuery != null && onSearchChanged != null)
              SliverPersistentHeader(
                pinned: true,
                delegate: _PinnedSearchDelegate(
                  color: section.primary,
                  minHeight: 88,
                  maxHeight: 88,
                  searchQuery: searchQuery!,
                  onChanged: onSearchChanged!,
                  hintText: searchHint,
                ),
              ),
            SliverToBoxAdapter(child: const SizedBox(height: 24)),
            SliverToBoxAdapter(
              child: WMaxWidth(
                child: WSectionHeader(
                  eyebrow: '${items.length} focused topics',
                  title: 'A premium Flutter showcase for ${section.title}',
                  subtitle:
                      'This page uses slivers, layered gradients, responsive grids, hover feedback, animated metrics, and section-driven content to show what Flutter can do cleanly on web.',
                  accent: section.primary,
                ),
              ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 28)),
            SliverToBoxAdapter(
              child: WMaxWidth(
                child: AnimationLimiter(
                  child: WGrid(
                    children: List.generate(spotlights.length, (index) {
                      final spot = spotlights[index];
                      return AnimationConfiguration.staggeredGrid(
                        position: index,
                        columnCount: WBreak.cols(context).toInt(),
                        duration: const Duration(milliseconds: 500),
                        child: ScaleAnimation(
                          child: FadeInAnimation(
                            child: _SpotlightCard(
                              section: section,
                              spotlight: spot,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 32)),
            SliverToBoxAdapter(
              child: WMaxWidth(child: _CapabilityBanner(section: section)),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 32)),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: filteredItems.isEmpty
                  ? SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Center(
                          child: Text(
                            'No inner topics match your search.',
                            style: TextStyle(
                              color: isDark ? Colors.white60 : Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    )
                  : SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: WBreak.cols(context).toInt(),
                        childAspectRatio: 0.95,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          columnCount: WBreak.cols(context).toInt(),
                          duration: const Duration(milliseconds: 550),
                          child: ScaleAnimation(
                            scale: 0.92,
                            child: FadeInAnimation(
                              child: _InnerTopicCard(
                                item: filteredItems[index],
                                section: section,
                                index: index,
                              ),
                            ),
                          ),
                        );
                      }, childCount: filteredItems.length),
                    ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 40)),
            SliverToBoxAdapter(
              child: WMaxWidth(
                child: _TimelinePanel(section: section, timeline: timeline),
              ),
            ),
            ...footerBlocks.map((widget) => SliverToBoxAdapter(child: widget)),
            SliverToBoxAdapter(child: const SizedBox(height: 56)),
          ],
        ),
      ),
    );
  }
}

class _PinnedSearchDelegate extends SliverPersistentHeaderDelegate {
  final Color color;
  final double minHeight;
  final double maxHeight;
  final RxString searchQuery;
  final ValueChanged<String> onChanged;
  final String hintText;

  _PinnedSearchDelegate({
    required this.color,
    required this.minHeight,
    required this.maxHeight,
    required this.searchQuery,
    required this.onChanged,
    required this.hintText,
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
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: color.withValues(alpha: 0.18)),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.12),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: TextField(
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: Icon(Icons.search_rounded, color: color),
              suffixIcon: Obx(() {
                return searchQuery.value.isNotEmpty
                    ? IconButton(
                        onPressed: () => onChanged(''),
                        icon: Icon(Icons.close_rounded, color: color),
                      )
                    : const SizedBox();
              }),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _PinnedSearchDelegate oldDelegate) => false;

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;
}

class _ShowcaseHero extends StatefulWidget {
  final WebNavSection section;
  final String pageTitle;
  final String pageSubtitle;
  final IconData heroIcon;
  final List<ShowcaseMetric> metrics;

  const _ShowcaseHero({
    required this.section,
    required this.pageTitle,
    required this.pageSubtitle,
    required this.heroIcon,
    required this.metrics,
  });

  @override
  State<_ShowcaseHero> createState() => _ShowcaseHeroState();
}

class _ShowcaseHeroState extends State<_ShowcaseHero>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = WBreak.isMobile(context);
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [widget.section.primary, widget.section.secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 50 + math.sin(_controller.value * 2 * math.pi) * 20,
                right: 50,
                child: Icon(
                  widget.heroIcon,
                  size: isMobile ? 90 : 140,
                  color: Colors.white.withValues(alpha: 0.12),
                ),
              ),
              Positioned(
                bottom: 40 + math.cos(_controller.value * 2 * math.pi) * 18,
                left: 30,
                child: Transform.rotate(
                  angle: _controller.value * 2 * math.pi,
                  child: Icon(
                    Icons.blur_on_rounded,
                    size: isMobile ? 70 : 100,
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                ),
              ),
              WMaxWidth(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: isMobile ? 88 : 94,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    WBadge(label: widget.section.title, color: Colors.white),
                    const SizedBox(height: 18),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 720),
                      child: Text(
                        widget.pageTitle,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isMobile ? 30 : 42,
                          fontWeight: FontWeight.w900,
                          height: 1.1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 720),
                      child: Text(
                        widget.pageSubtitle,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 15,
                          height: 1.7,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: widget.metrics
                          .map(
                            (metric) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.18),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    metric.value,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Text(
                                    metric.label,
                                    style: TextStyle(
                                      color: Colors.white.withValues(
                                        alpha: 0.8,
                                      ),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SpotlightCard extends StatelessWidget {
  final WebNavSection section;
  final ShowcaseSpotlight spotlight;

  const _SpotlightCard({required this.section, required this.spotlight});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? WColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: section.primary.withValues(alpha: 0.16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [section.primary, section.secondary],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(spotlight.icon, color: Colors.white),
          ),
          const SizedBox(height: 18),
          Text(
            spotlight.title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: isDark ? Colors.white : const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            spotlight.body,
            style: TextStyle(
              color: isDark ? Colors.white70 : Colors.black54,
              height: 1.6,
              fontSize: 13.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _CapabilityBanner extends StatelessWidget {
  final WebNavSection section;

  const _CapabilityBanner({required this.section});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            section.primary.withValues(alpha: 0.12),
            section.secondary.withValues(alpha: 0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: section.primary.withValues(alpha: 0.18)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: section.primary.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(Icons.auto_awesome_rounded, color: section.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'What Flutter does best here',
                  style: TextStyle(
                    color: section.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Flutter can render a consistent premium interface across web, mobile, and desktop with the same widget tree. Slivers handle large scroll narratives, implicit and explicit animations keep motion smooth, and composable widgets make each section feel custom without duplicating architecture.',
                  style: TextStyle(height: 1.65),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InnerTopicCard extends StatefulWidget {
  final WebNavItem item;
  final WebNavSection section;
  final int index;

  const _InnerTopicCard({
    required this.item,
    required this.section,
    required this.index,
  });

  @override
  State<_InnerTopicCard> createState() => _InnerTopicCardState();
}

class _InnerTopicCardState extends State<_InnerTopicCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        transform: Matrix4.translationValues(0, _hovered ? -8 : 0, 0),
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: isDark ? WColors.cardDark : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: widget.section.primary.withValues(
              alpha: _hovered ? 0.32 : 0.14,
            ),
            width: 1.4,
          ),
          boxShadow: [
            if (_hovered)
              BoxShadow(
                color: widget.section.primary.withValues(alpha: 0.16),
                blurRadius: 28,
                offset: const Offset(0, 14),
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
                      colors: [
                        widget.section.primary,
                        widget.section.secondary,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(widget.item.icon, color: Colors.white),
                ),
                const Spacer(),
                WBadge(
                  label: 'Item ${widget.index + 1}',
                  color: widget.section.primary,
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              widget.item.title,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w900,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Text(
                widget.item.description,
                style: TextStyle(
                  fontSize: 13.5,
                  height: 1.6,
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Row(
            //   children: [
            //     Text(
            //       'Designed as a Flutter-ready inner section',
            //       style: TextStyle(
            //         color: widget.section.primary,
            //         fontSize: 12,
            //         fontWeight: FontWeight.w800,
            //       ),
            //     ),
            //     const Spacer(),
            //     Icon(
            //       Icons.arrow_forward_rounded,
            //       color: widget.section.primary,
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

class _TimelinePanel extends StatelessWidget {
  final WebNavSection section;
  final List<ShowcaseTimelineEntry> timeline;

  const _TimelinePanel({required this.section, required this.timeline});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? WColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: section.primary.withValues(alpha: 0.14)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WSectionHeader(
            eyebrow: 'Showcase flow',
            title: 'How this section turns content into an experience',
            subtitle:
                'A good Flutter page is not just a grid. It layers hierarchy, search, motion, and progressive disclosure into one scroll story.',
            accent: section.primary,
          ),
          const SizedBox(height: 24),
          ...List.generate(timeline.length, (index) {
            final entry = timeline[index];
            final last = index == timeline.length - 1;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: section.primary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: section.primary.withValues(alpha: 0.25),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),
                    if (!last)
                      Container(
                        width: 2,
                        height: 78,
                        color: section.primary.withValues(alpha: 0.2),
                      ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.label,
                          style: TextStyle(
                            color: section.primary,
                            fontSize: 11.5,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.1,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          entry.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: isDark
                                ? Colors.white
                                : const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          entry.body,
                          style: TextStyle(
                            height: 1.6,
                            color: isDark ? Colors.white70 : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
