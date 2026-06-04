import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'loop_hole_controller.dart';

class LoopHoleView extends GetView<LoopHoleController> {
  final bool isEmbedded;
  const LoopHoleView({super.key, this.isEmbedded = false});

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
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.red.withValues(alpha: 0.15),
            Colors.orange.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.red.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.loop, color: Colors.red, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Loop Hole',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Identify and resolve vulnerabilities',
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
            'Explore identified system gaps, security vulnerabilities, and process loop holes. '
            'We proactively analyze risks and formulate mitigation strategies.',
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
    title: 'Security Audits',
    icon: Icons.security,
    color: Colors.red,
    points: [
      'Regular penetration testing.',
      'Codebase vulnerability scanning.',
      'Access control reviews.',
    ],
  ),
  _Section(
    title: 'Process Gaps',
    icon: Icons.account_tree_outlined,
    color: Colors.orange,
    points: [
      'Identifying workflow bottlenecks.',
      'Analyzing miscommunication channels.',
      'Improving task handovers.',
    ],
  ),
  _Section(
    title: 'Compliance & Standards',
    icon: Icons.verified,
    color: Colors.purple,
    points: [
      'Regulatory requirement alignment.',
      'Industry standard compliance.',
      'Certification maintenance.',
    ],
  ),
  _Section(
    title: 'Risk Mitigation',
    icon: Icons.shield,
    color: Colors.indigo,
    points: [
      'Proactive threat identification.',
      'Incident response protocols.',
      'Disaster recovery planning.',
    ],
  ),
  _Section(
    title: 'Continuous Improvement',
    icon: Icons.refresh,
    color: Colors.teal,
    points: [
      'Regular security updates.',
      'Process optimization.',
      'Best practices implementation.',
    ],
  ),
];
