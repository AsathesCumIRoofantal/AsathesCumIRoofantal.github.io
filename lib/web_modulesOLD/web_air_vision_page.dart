// ============================================================
// web_modules/web_air_vision_page.dart
// Route: /web-air-vision  →  WebAirVisionPage
// ============================================================

import 'package:flutter/material.dart';

import '_web_layout.dart';

class WebAirVisionPage extends StatelessWidget {
  const WebAirVisionPage({super.key});

  static const String routeName = '/web-air-vision';

  static const _milestones = [
    _Mile(
      'Conception',
      'The original idea of a unified living platform crystallised — AIR was born as a concept that refuses to stay small.',
      '2018',
      WColors.indigo,
    ),
    _Mile(
      'All-Space Blueprint',
      'Architecture of the eight core sections designed. Entity, Union, Identity — the three pillars of membership formalised.',
      '2020',
      WColors.teal,
    ),
    _Mile(
      'First Wave',
      'Early adopters entered All-Space. Wisdom modules, learning tracks, and identity profiles went live.',
      '2022',
      WColors.amber,
    ),
    _Mile(
      'Mazeasta Governance',
      'The rule engine and expert moderation layer activated, ensuring quality and accountability across all content.',
      '2023',
      WColors.violet,
    ),
    _Mile(
      'Open Horizon',
      'Web, mobile, and API access unified. Third-party integrations and community-contributed modules launched.',
      '2025',
      WColors.emerald,
    ),
  ];

  static const _visionPoints = [
    _VP(
      Icons.public_rounded,
      'Universal Access',
      'Every person, regardless of geography or background, has an equal place inside All-Space.',
      WColors.indigo,
    ),
    _VP(
      Icons.groups_2_rounded,
      'Community Governance',
      'Decisions are shaped by those who live inside AIR, guided by the wisdom of appointed experts.',
      WColors.teal,
    ),
    _VP(
      Icons.auto_fix_high_rounded,
      'Continuous Innovation',
      'All-Space evolves — new modules, new connections, and new possibilities emerge every season.',
      WColors.amber,
    ),
    _VP(
      Icons.balance_rounded,
      'Ethical Foundation',
      'Every system within AIR is rooted in respect, fairness, and the long-term well-being of its members.',
      WColors.rose,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? WColors.surfaceDark : WColors.surface,
      appBar: WNavBar(title: "AIR'S VISION", color: WColors.sky),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero
            WHeroBanner(
              title: "AIR's Vision",
              subtitle:
                  'A world where every individual has an organised, meaningful, '
                  'and purposeful presence in All-Space — recorded, recognised, '
                  'and rewarded.',
              colorA: const Color(0xFF075985),
              colorB: const Color(0xFF0284C7),
              icon: Icons.remove_red_eye_rounded,
            ),

            const SizedBox(height: 48),

            // Vision points
            WMaxWidth(
              child: Column(
                children: [
                  const WSectionHeader(
                    eyebrow: "The Big Picture",
                    title: 'What AIR is building towards',
                    subtitle:
                        'Every decision, module, and feature traces back to '
                        'four foundational promises.',
                    accent: WColors.sky,
                  ),
                  const SizedBox(height: 28),
                  WGrid(
                    children: _visionPoints
                        .map(
                          (v) => WFeatureCard(
                            icon: v.icon,
                            title: v.title,
                            body: v.body,
                            color: v.color,
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 48),

            // Timeline
            Container(
              width: double.infinity,
              color: isDark ? const Color(0xFF0C1A2E) : const Color(0xFFE0F2FE),
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: WMaxWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const WSectionHeader(
                      eyebrow: 'Timeline of AIR',
                      title: 'How we got here',
                      accent: WColors.sky,
                    ),
                    const SizedBox(height: 28),
                    ..._milestones.map(
                      (m) => _MilestoneRow(m: m, isDark: isDark),
                    ),
                  ],
                ),
              ),
            ),

            // Mission
            const SizedBox(height: 48),
            WMaxWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const WSectionHeader(
                    eyebrow: "AIR's Mission",
                    title: 'Doing the work every day',
                    accent: WColors.sky,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          WColors.sky.withValues(alpha: 0.08),
                          WColors.indigo.withValues(alpha: 0.04),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: WColors.sky.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'To organise, digitise, and amplify the potential of '
                          'every individual and organisation within All-Space '
                          'through a platform that is simultaneously a learning '
                          'hub, a governance system, a creative arena, and a '
                          'community of trust.',
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.75,
                            color: isDark
                                ? Colors.white70
                                : const Color(0xFF0C4A6E),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const WBadge(
                          label: 'AIR Organisation Mission Statement',
                          color: WColors.sky,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}

// ── Data classes ─────────────────────────────────────────────
class _Mile {
  final String title;
  final String body;
  final String year;
  final Color color;
  const _Mile(this.title, this.body, this.year, this.color);
}

class _VP {
  final IconData icon;
  final String title;
  final String body;
  final Color color;
  const _VP(this.icon, this.title, this.body, this.color);
}

class _MilestoneRow extends StatelessWidget {
  final _Mile m;
  final bool isDark;
  const _MilestoneRow({required this.m, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Year bubble
          Column(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: m.color,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    m.year,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              Container(
                width: 2,
                height: 32,
                color: m.color.withValues(alpha: 0.3),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Text(
                  m.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15.5,
                    color: isDark ? Colors.white : const Color(0xFF0C4A6E),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  m.body,
                  style: TextStyle(
                    fontSize: 13.5,
                    height: 1.55,
                    color: isDark ? Colors.white60 : Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
