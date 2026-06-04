import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'utility_facilities_controller.dart';

class UtilityFacilitiesView extends GetView<UtilityFacilitiesController> {
  final bool isEmbedded;
  const UtilityFacilitiesView({super.key, this.isEmbedded = false});

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
            ..._utilitySections.map(
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
            Colors.indigo.withValues(alpha: 0.15),
            Colors.blue.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.indigo.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.indigo.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.amp_stories_rounded,
                  color: Colors.indigo,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Utility & Facilities',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Resources for your convenience',
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
            'Explore the comprehensive utilities and modern facilities available. '
            'We provide an environment fully equipped to support your daily needs '
            'with efficiency, comfort, and state-of-the-art infrastructure.',
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
    _UtilitySection section,
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

class _UtilitySection {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> points;
  const _UtilitySection({
    required this.title,
    required this.icon,
    required this.color,
    required this.points,
  });
}

final List<_UtilitySection> _utilitySections = [
  _UtilitySection(
    title: 'Workspace Environment',
    icon: Icons.desk,
    color: Colors.indigo,
    points: [
      'Ergonomic seating and well-lit workstations.',
      'High-speed Wi-Fi network and wired connections.',
      'Climate-controlled areas for optimal comfort.',
      'Quiet zones for focused and uninterrupted work.',
    ],
  ),
  _UtilitySection(
    title: 'Meeting & Conference Rooms',
    icon: Icons.meeting_room_outlined,
    color: Colors.blueAccent,
    points: [
      'Smart boards and video conferencing equipment.',
      'Easy online booking and scheduling system.',
      'Soundproofed rooms for privacy and confidentiality.',
      'Catering services available for long meetings.',
    ],
  ),
  _UtilitySection(
    title: 'Cafeteria & Dining',
    icon: Icons.local_dining_rounded,
    color: Colors.orange,
    points: [
      'Nutritious meal options with varied daily menus.',
      'Coffee stations and beverage dispensers.',
      'Clean dining spaces with adequate seating.',
      'Microwaves and refrigerators for personal use.',
    ],
  ),
  _UtilitySection(
    title: 'Wellness & Recreation',
    icon: Icons.fitness_center_rounded,
    color: Colors.green,
    points: [
      'In-house gym facilities with modern equipment.',
      'Lounge areas with comfortable seating for breaks.',
      'Indoor games and recreational activities.',
      'Dedicated meditation and prayer rooms.',
    ],
  ),
  _UtilitySection(
    title: 'Support Services',
    icon: Icons.support_agent_rounded,
    color: Colors.purple,
    points: [
      '24/7 IT support desk for technical issues.',
      'On-site facility management and maintenance staff.',
      'Mailroom and courier dispatch services.',
      'Dedicated reception area for visitor management.',
    ],
  ),
  _UtilitySection(
    title: 'Parking & Transport',
    icon: Icons.directions_car_filled_outlined,
    color: Colors.teal,
    points: [
      'Spacious parking areas with designated spots.',
      'EV charging stations available for electric vehicles.',
      'Shuttle services to major transit hubs.',
      'Bicycle parking racks to support eco-friendly commute.',
    ],
  ),
];
