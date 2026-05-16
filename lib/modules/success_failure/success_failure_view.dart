import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'success_failure_controller.dart';

class SuccessFailureView extends GetView<SuccessFailureController> {
  const SuccessFailureView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Success & Failure',
          style: TextStyle(
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
            color: onSurface,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: onSurface,
        iconTheme: IconThemeData(color: onSurface),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: [
              _buildHeader(context, isDark, onSurface),
              const SizedBox(height: 20),
              ..._sections.map(
                (s) => _buildSection(context, s, isDark, onSurface),
              ),
            ],
          ),
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
            Colors.orange.withValues(alpha: 0.15),
            Colors.deepOrange.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.orange.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.star, color: Colors.orange, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Success & Failure',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Learning from our journey',
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
            'We celebrate our victories and embrace our failures as learning opportunities. '
            'This transparent log documents what worked and what didn\'t.',
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
    title: 'Milestones Achieved',
    icon: Icons.emoji_events,
    color: Colors.amber,
    points: [
      'Reaching 1 million active users — a community milestone that validated the all-space model.',
      'Securing Series B funding, enabling the infrastructure and team growth needed for the next phase.',
      'Launching the flagship product on schedule after a disciplined 90-day sprint with zero critical bugs.',
      'Onboarding the first 100 Mazeasta-role members, proving the expert-tier model works at scale.',
    ],
  ),
  _Section(
    title: 'Lessons Learned',
    icon: Icons.error_outline,
    color: Colors.redAccent,
    points: [
      'Underestimating server scaling requirements during the first viral growth spike — now we pre-provision.',
      'Delayed feedback integration loops meant users waited too long to see their suggestions acted on.',
      'Marketing pivot in Q3 taught us that authentic community stories outperform polished ad copy every time.',
      'Shipping features without sufficient onboarding content led to low adoption — documentation ships with code now.',
    ],
  ),
  _Section(
    title: 'Growth Metrics',
    icon: Icons.bar_chart,
    color: Colors.green,
    points: [
      'Year-on-year revenue growth trajectory: 3× in Year 1, 2.2× in Year 2, targeting 1.8× in Year 3.',
      'Customer acquisition efficiency improved by 40% after switching to community-led growth channels.',
      'Market share expansion into three new regions, each with localised onboarding and language support.',
      'Net Promoter Score climbed from 34 to 61 over 18 months — a signal that trust is compounding.',
    ],
  ),
  _Section(
    title: 'Risk Management',
    icon: Icons.shield,
    color: Colors.indigo,
    points: [
      'Identifying potential failure points through quarterly red-team exercises before they become incidents.',
      'Contingency planning strategies for data loss, key-person dependency, and regulatory changes.',
      'Crisis response protocols tested in tabletop simulations so the team knows exactly who does what.',
      'Vendor diversification policy: no single supplier accounts for more than 30% of critical infrastructure.',
    ],
  ),
  _Section(
    title: 'Post-Mortem Practice',
    icon: Icons.manage_search_outlined,
    color: Colors.cyan,
    points: [
      'Every significant failure triggers a blameless post-mortem within 72 hours — facts, not finger-pointing.',
      'Root cause analysis follows the five-whys method to reach systemic causes, not surface symptoms.',
      'Action items from post-mortems are tracked publicly inside AIR so closure is visible to the whole team.',
      'Retrospective library is searchable — new team members learn from past incidents before they repeat them.',
    ],
  ),
  _Section(
    title: 'Celebration Rituals',
    icon: Icons.celebration_outlined,
    color: Colors.pinkAccent,
    points: [
      'Every shipped milestone is acknowledged in the team channel with a brief story of what it took.',
      'Quarterly "wins wall" compiles user testimonials, metrics jumps, and team contributions in one place.',
      'Individual contributors are named and thanked publicly — recognition is specific, not generic.',
      'Annual retrospective dinner where the team reflects on the full year\'s arc, not just the last sprint.',
    ],
  ),
  _Section(
    title: 'Future Momentum',
    icon: Icons.rocket_launch,
    color: Colors.blue,
    points: [
      'Scaling to new markets with localised product variants and community-first go-to-market strategies.',
      'Product line expansion into adjacent needs identified through the entity and union catalogue on the home tabs.',
      'Strategic partnerships with organisations whose values align with AIR\'s all-space philosophy.',
      'R&D investment in features that compound over time rather than one-time novelty releases.',
    ],
  ),
];
