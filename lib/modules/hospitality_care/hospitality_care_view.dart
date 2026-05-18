import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'hospitality_care_controller.dart';

class HospitalityCareView extends GetView<HospitalityCareController> {
  final bool isEmbedded;
  const HospitalityCareView({super.key, this.isEmbedded = false});

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
            ..._hospitalitySections.map(
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
            Colors.teal.withValues(alpha: 0.15),
            Colors.cyan.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.teal.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.teal.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.self_improvement_rounded,
                  color: Colors.teal,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hospitality & Care',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Warmth, respect, and compassion for all',
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
            'Genuine hospitality means going beyond the basics — it is about creating '
            'an atmosphere where every person feels welcomed, valued, and cared for. '
            'These principles guide how we treat one another and those we serve.',
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
    _HospitalitySection section,
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
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
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
          iconColor: onSurface.withValues(alpha: 0.5),
          collapsedIconColor: onSurface.withValues(alpha: 0.4),
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

class _HospitalitySection {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> points;
  const _HospitalitySection({
    required this.title,
    required this.icon,
    required this.color,
    required this.points,
  });
}

final List<_HospitalitySection> _hospitalitySections = [
  _HospitalitySection(
    title: 'Welcoming Attitude',
    icon: Icons.waving_hand_rounded,
    color: Colors.teal,
    points: [
      'Greet everyone with warmth and a genuine smile.',
      'Make newcomers feel at home from their very first interaction.',
      'Be attentive and proactively offer assistance.',
      'Use inclusive and welcoming language at all times.',
    ],
  ),
  _HospitalitySection(
    title: 'Empathy & Compassion',
    icon: Icons.favorite_rounded,
    color: Colors.pink,
    points: [
      'Listen actively and with full attention.',
      'Acknowledge feelings before jumping to solutions.',
      'Show genuine care for the well-being of others.',
      'Treat every person as an individual with unique needs.',
    ],
  ),
  _HospitalitySection(
    title: 'Service Excellence',
    icon: Icons.star_outline_rounded,
    color: Colors.amber,
    points: [
      'Go beyond the minimum — strive for outstanding service.',
      'Anticipate needs before they are expressed.',
      'Follow up to ensure satisfaction after helping someone.',
      'Continuously seek feedback and improve your approach.',
    ],
  ),
  _HospitalitySection(
    title: 'Cultural Sensitivity',
    icon: Icons.public_rounded,
    color: Colors.indigo,
    points: [
      'Respect and celebrate diversity in all its forms.',
      'Learn about different cultural practices and preferences.',
      'Avoid assumptions based on appearance, background, or beliefs.',
      'Adapt your communication style to suit different audiences.',
    ],
  ),
  _HospitalitySection(
    title: 'Care for Well-being',
    icon: Icons.spa_outlined,
    color: Colors.green,
    points: [
      'Check in on those who may be struggling silently.',
      'Encourage healthy habits and a balanced lifestyle.',
      'Create spaces where people feel safe to express themselves.',
      'Support each other through challenges with patience and kindness.',
    ],
  ),
  _HospitalitySection(
    title: 'Conflict Resolution',
    icon: Icons.handshake_outlined,
    color: Colors.deepOrange,
    points: [
      'Address disagreements calmly and respectfully.',
      'Seek to understand before seeking to be understood.',
      'Focus on finding solutions, not assigning blame.',
      'Involve a neutral mediator when direct resolution fails.',
    ],
  ),
];
