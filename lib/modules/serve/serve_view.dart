import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'serve_controller.dart';

class ServeView extends GetView<ServeController> {
  const ServeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Serve',
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
              ..._serveSections.map(
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
            Colors.pink.withValues(alpha: 0.15),
            Colors.redAccent.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.pink.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.pink.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.volunteer_activism,
                  color: Colors.pink,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Serve',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Community engagement & volunteering',
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
            'Discover opportunities to give back. Join our community initiatives, '
            'participate in local volunteering events, and make a positive impact '
            'in the lives of those around us.',
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
    _ServeSection section,
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

class _ServeSection {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> points;
  const _ServeSection({
    required this.title,
    required this.icon,
    required this.color,
    required this.points,
  });
}

final List<_ServeSection> _serveSections = [
  _ServeSection(
    title: 'Volunteer Programs',
    icon: Icons.group_add,
    color: Colors.pink,
    points: [
      'Join local community cleanup initiatives — sign up, show up, and log your hours directly in AIR for recognition.',
      'Mentorship and youth outreach: pair with a young person in your community for weekly 30-minute guidance sessions.',
      'Participate in food drives and charity runs — AIR coordinates logistics so you just need to show up ready.',
      'Skills-based volunteering: offer your professional expertise (design, legal, tech, finance) to NGOs that need it.',
      'Virtual volunteering options for those who cannot be physically present — tutoring, translation, and content creation.',
    ],
  ),
  _ServeSection(
    title: 'Seva & Spiritual Service',
    icon: Icons.volunteer_activism,
    color: Colors.deepOrange,
    points: [
      'Seva (selfless service) log: record acts of service done without expectation of return — small or large.',
      'Community kitchen participation: help prepare and distribute meals at local shelters or community centres.',
      'Temple, mosque, church, and gurdwara service opportunities listed and coordinated through AIR.',
      'Seva is not about hours logged — it\'s about the quality of presence and intention you bring to each act.',
    ],
  ),
  _ServeSection(
    title: 'Social Impact',
    icon: Icons.public,
    color: Colors.blueAccent,
    points: [
      'Corporate sustainability and green initiatives: tree planting, waste reduction, and carbon offset programmes.',
      'Partnering with local non-profit organisations to amplify their reach using AIR\'s community network.',
      'Annual impact reports published transparently — hours served, lives touched, and funds mobilised.',
      'Social impact scoring: see how your individual contributions add up to collective community change over time.',
    ],
  ),
  _ServeSection(
    title: 'Donations & Giving',
    icon: Icons.redeem,
    color: Colors.amber,
    points: [
      'Information on company-matched charity donations — AIR doubles contributions to approved causes.',
      'Sponsor a cause or set up automated monthly giving to organisations you believe in.',
      'Emergency relief fund contribution pools activated within 24 hours of a declared crisis.',
      'Transparent fund tracking: see exactly where donated money goes, with receipts and impact reports.',
    ],
  ),
  _ServeSection(
    title: 'Care for the Elderly & Vulnerable',
    icon: Icons.elderly_outlined,
    color: Colors.teal,
    points: [
      'Regular visits to elderly community members who live alone — companionship is a form of service too.',
      'Grocery and errand assistance for those with mobility challenges, coordinated through AIR\'s local network.',
      'Digital literacy support: help older adults navigate smartphones, apps, and online services with patience.',
      'Emotional support listening sessions — sometimes the most powerful service is simply being present.',
    ],
  ),
  _ServeSection(
    title: 'Environmental Service',
    icon: Icons.eco_outlined,
    color: Colors.green,
    points: [
      'Participate in river, beach, and park cleanups organised through AIR\'s environmental service calendar.',
      'Tree planting drives with GPS-tagged saplings so you can track the growth of what you planted.',
      'Plastic-free community campaigns: organise your neighbourhood to reduce single-use plastic together.',
      'Environmental education workshops for children — the next generation of stewards starts with awareness.',
    ],
  ),
];
