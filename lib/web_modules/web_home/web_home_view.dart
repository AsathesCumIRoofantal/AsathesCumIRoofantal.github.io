// web_modules/web_home/web_home_view.dart
// Landing page — hero + grid of section cards, each linking to a dedicated page.
// ENHANCED: Advanced animations, slivers, parallax effects

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'dart:math' as math;

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
        body: CustomScrollView(
          controller: controller.scrollController,
          slivers: [
            // ── HERO WITH PARALLAX ──
            SliverAppBar(
              expandedHeight: WBreak.isMobile(context) ? 320 : 450,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(background: _AnimatedHero()),
            ),

            // ── REAL-TIME CHAT ──
            SliverToBoxAdapter(
              child: Container(
                color: isDark ? WColors.cardDark : Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 28),
                child: WMaxWidth(
                  child: AnimationLimiter(
                    child: WBreak.isMobile(context)
                        ? Column(
                            children: AnimationConfiguration.toStaggeredList(
                              duration: const Duration(milliseconds: 500),
                              childAnimationBuilder: (widget) => SlideAnimation(
                                verticalOffset: 30.0,
                                child: FadeInAnimation(child: widget),
                              ),
                              children: [
                                WebRTCChip(
                                  value: '1',
                                  label: 'Custom RTC',
                                  color: WColors.indigo,
                                  onTap: () {
                                    Get.toNamed(WebNavData.homeWebRtcRoute);
                                  },
                                ),
                                SizedBox(height: 12),
                                WebRTCChip(
                                  value: '2',
                                  label: 'Agora',
                                  color: WColors.teal,
                                  onTap: () {
                                    Get.toNamed(WebNavData.homeAgoraRoute);
                                  },
                                ),
                                SizedBox(height: 12),
                                WebRTCChip(
                                  value: '3',
                                  label: 'Livekit',
                                  color: WColors.amber,
                                  onTap: () {
                                    // Get.toNamed(WebNavData.homeLivekitRtcRoute);
                                  },
                                ),
                              ],
                            ),
                          )
                        : Row(
                            children: AnimationConfiguration.toStaggeredList(
                              duration: const Duration(milliseconds: 600),
                              childAnimationBuilder: (widget) => ScaleAnimation(
                                child: FadeInAnimation(child: widget),
                              ),
                              children: [
                                WebRTCChip(
                                  value: '1',
                                  label: 'Custom RTC',
                                  color: WColors.indigo,
                                  onTap: () {
                                    Get.toNamed(WebNavData.homeWebRtcRoute);
                                  },
                                ),
                                SizedBox(width: 12),
                                WebRTCChip(
                                  value: '2',
                                  label: 'Agora',
                                  color: WColors.teal,
                                  onTap: () {
                                    Get.toNamed(WebNavData.homeAgoraRoute);
                                  },
                                ),
                                SizedBox(width: 12),
                                WebRTCChip(
                                  value: '3',
                                  label: 'Livekit',
                                  color: WColors.amber,
                                  onTap: () {
                                    // Get.toNamed(
                                    //   WebNavData.homeLivekitRtcRoute,
                                    // );
                                  },
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
              ),
            ),

            // ── STATS WITH ANIMATION ──
            SliverToBoxAdapter(
              child: Container(
                color: isDark ? WColors.cardDark : Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 28),
                child: WMaxWidth(
                  child: AnimationLimiter(
                    child: WBreak.isMobile(context)
                        ? Column(
                            children: AnimationConfiguration.toStaggeredList(
                              duration: const Duration(milliseconds: 500),
                              childAnimationBuilder: (widget) => SlideAnimation(
                                verticalOffset: 30.0,
                                child: FadeInAnimation(child: widget),
                              ),
                              children: const [
                                WStatChip(
                                  value: '11',
                                  label: 'Workspaces',
                                  color: WColors.indigo,
                                ),
                                SizedBox(height: 12),
                                WStatChip(
                                  value: '150+',
                                  label: 'Linked Topics',
                                  color: WColors.teal,
                                ),
                                SizedBox(height: 12),
                                WStatChip(
                                  value: '∞',
                                  label: 'Room to Grow',
                                  color: WColors.amber,
                                ),
                              ],
                            ),
                          )
                        : Row(
                            children: AnimationConfiguration.toStaggeredList(
                              duration: const Duration(milliseconds: 600),
                              childAnimationBuilder: (widget) => ScaleAnimation(
                                child: FadeInAnimation(child: widget),
                              ),
                              children: const [
                                WStatChip(
                                  value: '11',
                                  label: 'Workspaces',
                                  color: WColors.indigo,
                                ),
                                SizedBox(width: 12),
                                WStatChip(
                                  value: '150+',
                                  label: 'Linked Topics',
                                  color: WColors.teal,
                                ),
                                SizedBox(width: 12),
                                WStatChip(
                                  value: '∞',
                                  label: 'Room to Grow',
                                  color: WColors.amber,
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(child: const SizedBox(height: 12)),

            // ── SECTION HEADER ──
            SliverToBoxAdapter(
              child: WMaxWidth(
                child: AnimationConfiguration.staggeredList(
                  position: 0,
                  duration: const Duration(milliseconds: 800),
                  child: const FadeInAnimation(
                    child: WSectionHeader(
                      eyebrow: 'The Atlas',
                      title: 'Pick a workspace',
                      subtitle:
                          'Each card opens its own page with the full menu, hero, '
                          'and topic detail. Use the drawer to jump anywhere, anytime.',
                      accent: WColors.indigo,
                    ),
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(child: const SizedBox(height: 12)),

            // ── ANIMATED GRID ──
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: WBreak.cols(context).toInt(),
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                delegate: SliverChildListDelegate([
                  _AnimatedSectionCard(
                    section: WebNavData.bySlug('explore'),
                    index: 0,
                  ),
                  _AnimatedSectionCard(
                    section: WebNavData.bySlug('wisdom'),
                    index: 1,
                  ),
                  _AnimatedSectionCard(
                    section: WebNavData.bySlug('be_you'),
                    index: 2,
                  ),
                  _AnimatedSectionCard(
                    section: WebNavData.bySlug('air_space'),
                    index: 3,
                  ),
                  _AnimatedSectionCard(
                    section: WebNavData.bySlug('profile'),
                    index: 4,
                  ),
                  _AnimatedSectionCard(
                    section: WebNavData.bySlug('aspects'),
                    index: 5,
                  ),
                  _AnimatedSectionCard(
                    section: WebNavData.bySlug('service'),
                    index: 6,
                  ),
                  _AnimatedSectionCard(
                    section: WebNavData.bySlug('vision'),
                    index: 7,
                  ),
                  _AnimatedSectionCard(
                    section: WebNavData.bySlug('motivation'),
                    index: 8,
                  ),
                  _AnimatedSectionCard(
                    section: WebNavData.bySlug('setup'),
                    index: 9,
                  ),
                  _AnimatedSectionCard(
                    section: WebNavData.bySlug('system'),
                    index: 10,
                  ),
                ]),
              ),
            ),

            SliverToBoxAdapter(child: const SizedBox(height: 56)),

            // ── FOOTER CTA ──
            SliverToBoxAdapter(child: _AnimatedFooter()),

            SliverToBoxAdapter(child: const SizedBox(height: 40)),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
// ENHANCED WIDGETS WITH ADVANCED ANIMATIONS
// ══════════════════════════════════════════════════════════════

class _AnimatedHero extends StatefulWidget {
  @override
  State<_AnimatedHero> createState() => _AnimatedHeroState();
}

class _AnimatedHeroState extends State<_AnimatedHero>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
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
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [WColors.indigo, WColors.violet, WColors.teal],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children: [
              // Floating circles animation
              Positioned(
                top:
                    (50 + math.sin(_controller.value * 2 * math.pi) * 20) - 120,
                right: 40,
                child: Opacity(
                  opacity: 0.15,
                  child: Transform.rotate(
                    angle: _controller.value * 2 * math.pi,
                    child: const Icon(
                      Icons.circle,
                      size: 100,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 80 + math.cos(_controller.value * 2 * math.pi) * 30,
                left: 60,
                child: Opacity(
                  opacity: 0.1,
                  child: Transform.rotate(
                    angle: -_controller.value * 2 * math.pi,
                    child: const Icon(
                      Icons.hexagon_outlined,
                      size: 80,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              // Content
              WMaxWidth(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: WBreak.isMobile(context) ? 60 : 100,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AnimationConfiguration.staggeredList(
                      position: 0,
                      duration: const Duration(milliseconds: 600),
                      child: const FadeInAnimation(
                        delay: Duration(milliseconds: 200),
                        child: Icon(
                          Icons.public_rounded,
                          color: Colors.white70,
                          size: 60,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    AnimationConfiguration.staggeredList(
                      position: 1,
                      duration: const Duration(milliseconds: 600),
                      child: const FadeInAnimation(
                        delay: Duration(milliseconds: 400),
                        child: Text(
                          'Everything in One Space',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 38,
                            fontWeight: FontWeight.w900,
                            height: 1.1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    AnimationConfiguration.staggeredList(
                      position: 2,
                      duration: const Duration(milliseconds: 600),
                      child: FadeInAnimation(
                        delay: const Duration(milliseconds: 600),
                        child: Text(
                          'AIR — Alifiyas Integrated Reality — is a living platform where '
                          'knowledge, identity, creativity, and community converge into a '
                          'single All-Space. Eleven workspaces, one atlas.',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 15,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _AnimatedSectionCard extends StatefulWidget {
  final WebNavSection section;
  final int index;
  const _AnimatedSectionCard({required this.section, required this.index});

  @override
  State<_AnimatedSectionCard> createState() => _AnimatedSectionCardState();
}

class _AnimatedSectionCardState extends State<_AnimatedSectionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AnimationConfiguration.staggeredGrid(
      position: widget.index,
      duration: const Duration(milliseconds: 600),
      columnCount: WBreak.cols(context).toInt(),
      child: ScaleAnimation(
        scale: 0.5,
        child: FadeInAnimation(
          child: MouseRegion(
            onEnter: (_) {
              setState(() => _isHovered = true);
              _hoverController.forward();
            },
            onExit: (_) {
              setState(() => _isHovered = false);
              _hoverController.reverse();
            },
            child: AnimatedBuilder(
              animation: _hoverController,
              builder: (context, child) {
                return Transform.scale(
                  scale: 1.0 + (_hoverController.value * 0.05),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => Get.toNamed(widget.section.route),
                    child: Container(
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: isDark ? WColors.cardDark : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: widget.section.primary.withValues(
                            alpha: 0.25 + _hoverController.value * 0.25,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: widget.section.primary.withValues(
                              alpha: 0.10 + _hoverController.value * 0.15,
                            ),
                            blurRadius: 22 + _hoverController.value * 10,
                            offset: Offset(0, 8 + _hoverController.value * 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Hero(
                                tag: 'section_${widget.section.slug}',
                                child: Container(
                                  width: 52,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        widget.section.primary,
                                        widget.section.secondary,
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Icon(
                                    widget.section.icon,
                                    color: Colors.white,
                                    size: 26,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: widget.section.primary.withValues(
                                    alpha: 0.12,
                                  ),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Text(
                                  '${widget.section.items.length} items',
                                  style: TextStyle(
                                    color: widget.section.primary,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            widget.section.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: isDark
                                  ? Colors.white
                                  : const Color(0xFF0F172A),
                              letterSpacing: 0.4,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            widget.section.tagline,
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: widget.section.primary,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.section.blurb,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 13,
                                    height: 1.55,
                                    color: isDark
                                        ? Colors.white70
                                        : Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
                          Row(
                            children: [
                              Text(
                                'Open workspace',
                                style: TextStyle(
                                  color: widget.section.primary,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(width: 6),
                              AnimatedRotation(
                                turns: _isHovered ? 0.0 : -0.125,
                                duration: const Duration(milliseconds: 200),
                                child: Icon(
                                  Icons.arrow_forward_rounded,
                                  color: widget.section.primary,
                                  size: 18,
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
          ),
        ),
      ),
    );
  }
}

class _AnimatedFooter extends StatefulWidget {
  @override
  State<_AnimatedFooter> createState() => _AnimatedFooterState();
}

class _AnimatedFooterState extends State<_AnimatedFooter>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                WColors.teal,
                Color.lerp(WColors.teal, WColors.sky, _pulseController.value)!,
                WColors.sky,
              ],
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 20),
          child: WMaxWidth(
            child: Column(
              children: [
                AnimationConfiguration.staggeredList(
                  position: 0,
                  duration: const Duration(milliseconds: 600),
                  child: ScaleAnimation(
                    scale: 0.8,
                    child: const FadeInAnimation(
                      child: Text(
                        'Ready to enter All-Space?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                AnimationConfiguration.staggeredList(
                  position: 1,
                  duration: const Duration(milliseconds: 600),
                  child: FadeInAnimation(
                    delay: const Duration(milliseconds: 200),
                    child: Text(
                      'Open the drawer, pick a workspace, and start mapping your part of AIR.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 15,
                        height: 1.6,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
