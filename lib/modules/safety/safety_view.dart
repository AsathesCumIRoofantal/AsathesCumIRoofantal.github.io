import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'safety_controller.dart';

class SafetyView extends GetView<SafetyController> {
  const SafetyView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;
    final primary = theme.colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Safety',
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
              _buildHeader(context, isDark, onSurface, primary),
              const SizedBox(height: 20),
              ..._safetySections.map(
                (s) => _buildSection(context, s, isDark, onSurface),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    bool isDark,
    Color onSurface,
    Color primary,
  ) {
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
                child: const Icon(
                  Icons.shield_rounded,
                  color: Colors.orange,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Safety Matters',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Guidelines for a secure environment',
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
            'We are committed to maintaining a safe environment for everyone. '
            'These guidelines outline the safety standards, emergency procedures, '
            'and shared responsibilities that keep our community protected.',
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
    _SafetySection section,
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

class _SafetySection {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> points;
  const _SafetySection({
    required this.title,
    required this.icon,
    required this.color,
    required this.points,
  });
}

final List<_SafetySection> _safetySections = [
  _SafetySection(
    title: 'Physical Safety',
    icon: Icons.personal_injury_outlined,
    color: Colors.orange,
    points: [
      'Always be aware of your surroundings in shared spaces.',
      'Report hazards, spills, or unsafe conditions immediately.',
      'Follow posted safety signs and emergency exit routes.',
      'Do not block emergency exits or access routes at any time.',
    ],
  ),
  _SafetySection(
    title: 'Digital & Data Safety',
    icon: Icons.lock_outline_rounded,
    color: Colors.blue,
    points: [
      'Never share your login credentials with anyone.',
      'Use strong, unique passwords and enable two-factor authentication.',
      'Be cautious of phishing emails and suspicious links.',
      'Report any suspected data breach to the admin immediately.',
      'Keep devices locked when unattended.',
    ],
  ),
  _SafetySection(
    title: 'Emotional & Psychological Safety',
    icon: Icons.favorite_border_rounded,
    color: Colors.pink,
    points: [
      'Everyone deserves to feel safe and respected.',
      'Bullying, harassment, and intimidation are strictly prohibited.',
      'Speak up if you or someone else feels unsafe or uncomfortable.',
      'Mental health resources are available — do not hesitate to seek help.',
    ],
  ),
  _SafetySection(
    title: 'Emergency Procedures',
    icon: Icons.emergency_rounded,
    color: Colors.red,
    points: [
      'In case of emergency, dial the relevant local emergency services.',
      'Familiarize yourself with the nearest first-aid kit location.',
      'Follow the instructions of designated safety officers.',
      'Assemble at the designated meeting point during evacuations.',
    ],
  ),
  _SafetySection(
    title: 'Reporting Incidents',
    icon: Icons.report_outlined,
    color: Colors.deepPurple,
    points: [
      'Report all incidents, near-misses, or unsafe conditions.',
      'Reporting is confidential and will be handled with care.',
      'Retaliation against anyone who reports in good faith is prohibited.',
      'All reports will be investigated and appropriate action taken.',
    ],
  ),
];
