import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../_shared/_web_layout.dart';
import '../../_shared/web_shell.dart';
import 'web_timeline_of_air_controller.dart';

class WebTimelineOfAirView extends GetView<WebTimelineOfAirController> {
  const WebTimelineOfAirView({super.key});

  static const String routeName = '/web-aspects/timeline-of-air';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = const Color(0xFFE11D48); // Rose/Crimson color for Aspects
    final isDesktop = WBreak.isDesktop(context);

    return WebShell(
      currentRoute: routeName,
      child: Scaffold(
        backgroundColor: isDark
            ? const Color(0xFF0F172A)
            : const Color(0xFFFFF1F2),
        body: CustomScrollView(
          slivers: [
            // ── HERO HEADER ──
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 48,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      primary.withValues(alpha: 0.1),
                      primary.withValues(alpha: 0.02),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_rounded, color: primary),
                          onPressed: () => Get.back(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: primary.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.timeline_rounded,
                        size: 48,
                        color: primary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Timeline of AIR',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: isDark ? Colors.white : Colors.black87,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: Text(
                        'Historical beats, upcoming milestones, and the evolving narrative of the organisation documented on one continuum.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.6,
                          color: isDark ? Colors.white70 : Colors.black54,
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),
                    _buildYearSelector(primary, isDark),
                  ],
                ),
              ),
            ),

            // ── TIMELINE CONTENT ──
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 64),
              sliver: SliverToBoxAdapter(
                child: WMaxWidth(
                  child: AnimationLimiter(
                    child: Column(
                      children: List.generate(5, (index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 600),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: _TimelineNode(
                                index: index,
                                primary: primary,
                                isDark: isDark,
                                isDesktop: isDesktop,
                              ),
                            ),
                          ),
                        );
                      }),
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

  Widget _buildYearSelector(Color primary, bool isDark) {
    final years = ['2023', '2024', '2025', '2026', 'Future'];
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: years.map((year) {
        return Obx(() {
          final active = controller.activeYear.value == year;
          return InkWell(
            onTap: () => controller.setYear(year),
            borderRadius: BorderRadius.circular(100),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: active
                    ? primary
                    : (isDark ? WColors.cardDark : Colors.white),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: active ? primary : primary.withValues(alpha: 0.2),
                ),
                boxShadow: [
                  if (active)
                    BoxShadow(
                      color: primary.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                ],
              ),
              child: Text(
                year,
                style: TextStyle(
                  color: active
                      ? Colors.white
                      : (isDark ? Colors.white70 : Colors.black87),
                  fontWeight: active ? FontWeight.w900 : FontWeight.w600,
                ),
              ),
            ),
          );
        });
      }).toList(),
    );
  }
}

class _TimelineNode extends StatelessWidget {
  final int index;
  final Color primary;
  final bool isDark;
  final bool isDesktop;

  const _TimelineNode({
    required this.index,
    required this.primary,
    required this.isDark,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    final isLeft = index % 2 == 0;

    final titles = [
      'Inception of AIR Framework',
      'First Alifiyas Cohort',
      'Mazeasta Rules Drafted',
      'Global Workspace Expansion',
      'The Next Frontier',
    ];

    final dates = [
      'Jan 15, 2026',
      'Mar 22, 2026',
      'Jun 10, 2026',
      'Sep 01, 2026',
      'Dec 31, 2026',
    ];

    if (!isDesktop) {
      // Mobile Layout: Line on left, card on right
      return _buildMobileNode(titles[index], dates[index]);
    }

    // Desktop Layout: Alternating Timeline
    return SizedBox(
      height: 250,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Center Line
          Positioned(
            top: 0,
            bottom: 0,
            width: 4,
            child: Container(color: primary.withValues(alpha: 0.2)),
          ),

          // Center Dot
          Positioned(
            top: 100, // Align with card
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF0F172A)
                    : const Color(0xFFFFF1F2),
                border: Border.all(color: primary, width: 4),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: primary.withValues(alpha: 0.4),
                    blurRadius: 12,
                  ),
                ],
              ),
            ),
          ),

          // Content Card
          Positioned(
            top: 0,
            left: isLeft ? 0 : null,
            right: isLeft ? null : 0,
            width: 400, // Fixed width for desktop cards
            child: _buildCard(titles[index], dates[index]),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileNode(String title, String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Line and Dot
          Column(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF0F172A)
                      : const Color(0xFFFFF1F2),
                  border: Border.all(color: primary, width: 4),
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 4,
                height: 200,
                color: primary.withValues(alpha: 0.2),
              ),
            ],
          ),
          const SizedBox(width: 24),
          // Content
          Expanded(child: _buildCard(title, date)),
        ],
      ),
    );
  }

  Widget _buildCard(String title, String date) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: isDark ? WColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.05),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              date,
              style: TextStyle(
                color: primary,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: isDark ? Colors.white : Colors.black87,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'This event marked a critical milestone in the evolution of AIR, expanding our capabilities and reinforcing the core values established by Mazeasta.',
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: isDark ? Colors.white60 : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
