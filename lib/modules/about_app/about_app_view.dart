import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'about_app_binding.dart';

class AboutAppView extends GetView<AboutAppController> {
  const AboutAppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final tertiary = theme.colorScheme.tertiary;
    final onSurface = theme.colorScheme.onSurface;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About AIR-APP',
          style: TextStyle(
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
            color: onSurface,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: onSurface,
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        tertiary.withOpacity(0.18),
                        theme.colorScheme.primary.withOpacity(0.08),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: tertiary.withOpacity(0.25)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: tertiary.withOpacity(0.12),
                          border: Border.all(
                              color: tertiary.withOpacity(0.3), width: 2),
                        ),
                        child: Icon(Icons.air, color: tertiary, size: 56),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'AIR',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 12,
                          color: onSurface,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'All-Space Intelligence & Reasoning',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          letterSpacing: 1.5,
                          color: onSurface.withOpacity(0.6),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: tertiary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border:
                              Border.all(color: tertiary.withOpacity(0.3)),
                        ),
                        child: Text(
                          'Version 1.0.0  ·  Build 365',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: tertiary,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Info sections
                ..._appSections.map(
                  (s) => _buildSection(context, s, isDark, onSurface),
                ),

                const SizedBox(height: 24),

                // Tech stack chips
                _buildLabel('BUILT WITH', theme.colorScheme.primary),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _techChip('Flutter', Icons.flutter_dash, Colors.blue,
                        context),
                    _techChip('Dart', Icons.code, Colors.cyan, context),
                    _techChip('GetX', Icons.bolt, Colors.purple, context),
                    _techChip(
                        'Material 3', Icons.palette, Colors.teal, context),
                    _techChip('Firebase', Icons.local_fire_department,
                        Colors.orange, context),
                  ],
                ),
                const SizedBox(height: 32),

                // Footer
                const Divider(),
                const SizedBox(height: 16),
                Center(
                  child: Column(
                    children: [
                      Text(
                        '© 2026 AIR Organization',
                        style: TextStyle(
                          fontSize: 12,
                          color: onSurface.withOpacity(0.5),
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '"Mapping all-space. Ensuring absolute transparency."',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          fontStyle: FontStyle.italic,
                          color: onSurface.withOpacity(0.4),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'All-Space Rights Reserved.',
                        style: TextStyle(
                          fontSize: 10,
                          color: onSurface.withOpacity(0.35),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    _AppSection section,
    bool isDark,
    Color onSurface,
  ) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: isDark
            ? theme.cardColor.withOpacity(0.35)
            : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.06)
              : theme.colorScheme.outline.withOpacity(0.12),
        ),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                )
              ],
      ),
      child: Theme(
        data: theme.copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: section.color.withOpacity(0.12),
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
          iconColor: onSurface.withOpacity(0.5),
          collapsedIconColor: onSurface.withOpacity(0.4),
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
                color: onSurface.withOpacity(0.75),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
        color: color.withOpacity(0.8),
      ),
    );
  }

  Widget _techChip(
      String label, IconData icon, Color color, BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _AppSection {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> points;
  const _AppSection({
    required this.title,
    required this.icon,
    required this.color,
    required this.points,
  });
}

final List<_AppSection> _appSections = [
  _AppSection(
    title: 'The Vision',
    icon: Icons.visibility_outlined,
    color: Colors.purpleAccent,
    points: [
      'To map every entity and union in all-space, ensuring absolute transparency and accountability across all nodes of existence.',
      'AIR aspires to be the definitive, real-time atlas of all existence — from atoms to galaxies, from individuals to civilisations.',
      'Every user who engages with AIR contributes to a living knowledge ecosystem that grows more accurate and complete over time.',
    ],
  ),
  _AppSection(
    title: 'Technical Core',
    icon: Icons.developer_board_outlined,
    color: Colors.tealAccent,
    points: [
      'Built on the Alifiyas-Mazeasta dual framework — Alifiyas governs the Explore domain, Mazeasta governs the Rule domain.',
      'The app serves as the primary interface for the all-space atlas, connecting entities, unions, and identities in one coherent system.',
      'Powered by Flutter and GetX for a reactive, cross-platform experience with Material 3 design language throughout.',
      'Data architecture uses a JSON-driven content engine that allows the knowledge base to grow without app updates.',
    ],
  ),
  _AppSection(
    title: 'Core Features',
    icon: Icons.star_outline_rounded,
    color: Colors.amberAccent,
    points: [
      'Entities & Unions — Catalogue every node and relationship in your all-space map from the home tabs.',
      'Identity System — Locate yourself within the all-space atlas through a guided philosophical questionnaire.',
      'Learn & Fun — Explore knowledge categories in a visually rich, approachable grid format.',
      'Wisdom Mode — Advanced philosophical reflection under expert supervision in the Mazeasta domain.',
      'Ask Any Thing — Submit queries, track answers, and contribute to the collective AIR knowledge network.',
      'Drawer Navigation — 11 thematic sections covering every aspect of life, work, and all-space operation.',
    ],
  ),
  _AppSection(
    title: 'Privacy & Security',
    icon: Icons.shield_outlined,
    color: Colors.greenAccent,
    points: [
      'Your identity data is stored securely and never shared with third parties without explicit consent.',
      'Private/Confidential section uses device-level authentication to protect sensitive artefacts.',
      'All network communications are encrypted in transit using industry-standard TLS protocols.',
      'You control your public profile — only what you explicitly mark as public is visible to others.',
    ],
  ),
  _AppSection(
    title: 'Accessibility',
    icon: Icons.accessibility_new_outlined,
    color: Colors.cyanAccent,
    points: [
      'Dynamic text sizing respects your device\'s accessibility font scale settings throughout the app.',
      'High-contrast mode available in Settings for users with visual impairments.',
      'Screen reader support (TalkBack / VoiceOver) is implemented across all primary navigation flows.',
      'Tap targets meet minimum 48×48dp size requirements so the app is usable for all motor abilities.',
    ],
  ),
  _AppSection(
    title: 'Changelog & Updates',
    icon: Icons.update_outlined,
    color: Colors.orangeAccent,
    points: [
      'v1.0.0 — Initial release: Entities, Unions, Identity, Learn & Fun, Wisdom, Ask Any Thing, and full drawer navigation.',
      'All updates are delivered over-the-air without requiring a full app store download for content changes.',
      'Release notes are published in the "New in AIR" drawer section after every significant update.',
      'Bug reports can be submitted directly from the Feedback module — your report goes straight to the dev team.',
    ],
  ),
  _AppSection(
    title: 'Support & Contact',
    icon: Icons.support_agent_outlined,
    color: Colors.pinkAccent,
    points: [
      'In-app support is available through the Feedback module — describe your issue and attach a screenshot.',
      'Community support is available through the Query & Discussion module for peer-to-peer help.',
      'The AIR Organisation can be contacted through the About AIR Organization section for formal enquiries.',
      'Response time for support queries is typically within 48 hours during active development phases.',
    ],
  ),
];
