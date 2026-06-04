import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'enhancement_controller.dart';

class EnhancementView extends GetView<EnhancementController> {
  final bool isEmbedded;
  const EnhancementView({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [theme.scaffoldBackgroundColor, theme.colorScheme.surface]
              : [theme.colorScheme.surface, theme.scaffoldBackgroundColor],
        ),
      ),
      child: SafeArea(
        child: ListView(
          physics: isEmbedded ? const NeverScrollableScrollPhysics() : null,
          shrinkWrap: isEmbedded,
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          children: [
            _buildHeader(context, isDark, onSurface),
            const SizedBox(height: 20),
            ..._sections.map(
              (s) => _buildSection(context, s, isDark, onSurface),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.purpleAccent.withValues(alpha: 0.15),
            Colors.deepPurple.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.purpleAccent.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.purpleAccent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.auto_fix_high,
                  color: Colors.purpleAccent,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enhancement',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Continuous improvement',
                      style: TextStyle(
                        fontSize: 13,
                        color: onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'We believe that there is always room to grow. Explore our '
            'ongoing efforts to optimize processes, upgrade systems, and elevate the user experience.',
            style: TextStyle(
              fontSize: 14,
              color: onSurface.withValues(alpha: 0.75),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    _Section section,
    bool isDark,
    Color onSurface,
  ) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: isDark
            ? theme.cardColor.withValues(alpha: 0.35)
            : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.06)
              : theme.colorScheme.outline.withValues(alpha: 0.12),
        ),
      ),
      child: Theme(
        data: theme.copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: section.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(section.icon, color: section.color, size: 20),
          ),
          title: Text(
            section.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: onSurface,
            ),
          ),
          children: section.points
              .map((p) => _buildPoint(p, onSurface, section.color))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildPoint(String point, Color onSurface, Color accent) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              point,
              style: TextStyle(
                fontSize: 14,
                color: onSurface.withValues(alpha: 0.75),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Section {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> points;
  const _Section({
    required this.title,
    required this.icon,
    required this.color,
    required this.points,
  });
}

final List<_Section> _sections = [
  _Section(
    title: 'Performance Upgrades',
    icon: Icons.bolt,
    color: Colors.yellow,
    points: [
      'Load time optimisation: every screen targets a sub-300ms first paint so the app feels instant, not sluggish.',
      'Memory efficiency improvements that reduce background footprint and prevent the app from being killed by the OS.',
      'Throughput maximisation for data-heavy modules — batch requests, lazy loading, and smart caching work together.',
      'Profiling sessions run after every major release to catch regressions before users notice them.',
    ],
  ),
  _Section(
    title: 'User Experience Refinements',
    icon: Icons.touch_app,
    color: Colors.cyan,
    points: [
      'Interface refinements based on usability testing — tap targets, spacing, and contrast adjusted for real hands.',
      'Navigation streamlining: reducing the number of taps to reach any core action to three or fewer.',
      'Accessibility enhancements: screen reader support, dynamic text sizing, and high-contrast mode across all screens.',
      'Micro-interaction polish — subtle animations and haptic feedback that make the app feel alive without being distracting.',
    ],
  ),
  _Section(
    title: 'Feature Expansion',
    icon: Icons.add_circle,
    color: Colors.green,
    points: [
      'New capability development driven by the top-voted items from the community feedback queue each quarter.',
      'Integration partnerships with tools users already rely on — calendar, notes, and communication apps.',
      'Custom workflow support so power users can configure AIR to match their specific operating rhythm.',
      'API expansion for technical partners who want to build on top of AIR\'s data and identity layer.',
    ],
  ),
  _Section(
    title: 'Quality Assurance',
    icon: Icons.verified_user,
    color: Colors.teal,
    points: [
      'Comprehensive testing protocols: unit, integration, and end-to-end tests run on every pull request.',
      'Bug fixing automation: static analysis and linting catch common errors before they reach review.',
      'Performance benchmarking against baseline metrics so every release is provably not slower than the last.',
      'Regression test suite that grows with every bug fixed — once a bug is closed, it stays closed.',
    ],
  ),
  _Section(
    title: 'Incremental Delivery',
    icon: Icons.trending_up,
    color: Colors.purple,
    points: [
      'Feedback-driven iterations: small, frequent releases that compound into large improvements over months.',
      'Agile enhancement cycles with two-week sprints, clear acceptance criteria, and demo-driven sign-off.',
      'Feature flags allow gradual rollouts — 5% of users first, then 25%, then 100% — so risk is contained.',
      'Community-driven updates: the changelog is public and written in plain language, not engineering jargon.',
    ],
  ),
  _Section(
    title: 'UX & Visual Polish',
    icon: Icons.brush,
    color: Colors.purpleAccent,
    points: [
      'Refining interface interactions so every gesture, swipe, and tap feels intentional and satisfying.',
      'Improving accessibility features: colour-blind-safe palettes, focus indicators, and keyboard navigation.',
      'Adding user personalisation — theme choices, layout preferences, and notification cadence controls.',
      'Dark and light mode parity: every screen looks equally considered in both themes, not just one.',
    ],
  ),
  _Section(
    title: 'Technical Debt Reduction',
    icon: Icons.cleaning_services_outlined,
    color: Colors.deepOrangeAccent,
    points: [
      'Reducing application load times by refactoring legacy code paths that accumulated shortcuts over time.',
      'Minimising battery consumption through smarter background sync and reduced unnecessary wake-locks.',
      'Optimising database queries that were written for small datasets but now serve millions of records.',
      'Dependency audit every six months: remove unused packages, update stale ones, and document why each one exists.',
    ],
  ),
];
