// ============================================================
// web_modules/web_about_page.dart
// Route: /web-about  →  WebAboutPage
// ============================================================

import 'package:flutter/material.dart';

import '_web_layout.dart';

class WebAboutPage extends StatelessWidget {
  const WebAboutPage({super.key});

  static const String routeName = '/web-about';

  static const _orgValues = [
    _Val(Icons.verified_rounded, 'Integrity', 'Every system and decision within AIR holds to a standard that does not bend under pressure.', WColors.emerald),
    _Val(Icons.groups_2_rounded, 'Inclusion', 'All-Space has no walls — every identity, background, and skill level is welcome and valued.', WColors.teal),
    _Val(Icons.auto_fix_high_rounded, 'Innovation', 'AIR is never finished. Constant iteration, honest feedback, and bold ideas keep All-Space evolving.', WColors.violet),
    _Val(Icons.balance_rounded, 'Accountability', 'Members and the organisation itself are held to measurable, transparent standards of conduct.', WColors.indigo),
    _Val(Icons.favorite_rounded, 'Compassion', 'People come first. Every rule, module, and interaction is designed with human well-being in mind.', WColors.rose),
    _Val(Icons.lightbulb_rounded, 'Curiosity', 'Questions are celebrated. Learning never stops inside AIR — at any age, at any level.', WColors.amber),
  ];

  static const _appFeatures = [
    _AppFeat(Icons.phone_android_rounded, 'Mobile-first Design', 'Built for Flutter — smooth on every screen size from phone to desktop.'),
    _AppFeat(Icons.dark_mode_rounded, 'Dark & Light Themes', 'Cosmic Dark and Ethereal Light — switch to match your mood and environment.'),
    _AppFeat(Icons.explore_rounded, 'Unified Navigation', 'Every module reachable in two taps from the smart drawer with search.'),
    _AppFeat(Icons.security_rounded, 'Privacy Built-in', 'Private/Confidential spaces with granular control over what you share.'),
    _AppFeat(Icons.translate_rounded, 'Multilingual Ready', 'English and Hindi content with localisation hooks for future languages.'),
    _AppFeat(Icons.offline_bolt_rounded, 'Resilient Access', 'Core content available even when connectivity is limited.'),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? WColors.surfaceDark : WColors.surface,
      appBar: WNavBar(title: 'ABOUT AIR', color: WColors.indigo),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero
            WHeroBanner(
              title: 'About AIR — All-Space',
              subtitle:
                  'Alifiyas Integrated Reality is more than a platform — '
                  'it is an organisation, a philosophy, and a community built '
                  'on the belief that every individual deserves an organised, '
                  'dignified space in this world.',
              colorA: const Color(0xFF1E1B4B),
              colorB: const Color(0xFF4F46E5),
              icon: Icons.info_rounded,
            ),

            const SizedBox(height: 48),

            // Organisation
            WMaxWidth(
              child: Column(
                children: [
                  const WSectionHeader(
                    eyebrow: 'The Organisation',
                    title: 'What is AIR?',
                    subtitle:
                        'AIR stands for Alifiyas Integrated Reality — '
                        'an organisation dedicated to creating a unified living '
                        'platform (All-Space) that brings together knowledge, '
                        'identity, community, and commerce under one roof.',
                    accent: WColors.indigo,
                  ),
                  const SizedBox(height: 32),
                  // Values grid
                  const WSectionHeader(
                    eyebrow: 'Our DNA',
                    title: 'Core Values',
                    accent: WColors.indigo,
                  ),
                  const SizedBox(height: 20),
                  WGrid(
                    children: _orgValues
                        .map((v) => WFeatureCard(
                              icon: v.icon,
                              title: v.title,
                              body: v.body,
                              color: v.color,
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 48),

            // App overview
            Container(
              color: isDark
                  ? const Color(0xFF1E1B4B).withValues(alpha: 0.5)
                  : const Color(0xFFEEF2FF),
              padding: const EdgeInsets.symmetric(
                  vertical: 40, horizontal: 20),
              child: WMaxWidth(
                child: Column(
                  children: [
                    const WSectionHeader(
                      eyebrow: 'The Application',
                      title: 'About This App',
                      subtitle:
                          'Categories in All-Space is the AIR mobile and web '
                          'companion — the definitive way to navigate every '
                          'module, identity, and community within AIR.',
                      accent: WColors.indigo,
                    ),
                    const SizedBox(height: 28),
                    WGrid(
                      children: _appFeatures
                          .map((f) => _FeatureLine(f: f, isDark: isDark))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 48),

            // Contact / footer
            WMaxWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const WSectionHeader(
                    eyebrow: 'Get in Touch',
                    title: 'Connect with AIR',
                    accent: WColors.indigo,
                  ),
                  const SizedBox(height: 20),
                  WGrid(
                    forceColumns: WBreak.isMobile(context) ? 1 : 3,
                    children: [
                      _ContactCard(
                          icon: Icons.email_rounded,
                          label: 'Email',
                          value: 'hello@air-allspace.org',
                          color: WColors.indigo,
                          isDark: isDark),
                      _ContactCard(
                          icon: Icons.public_rounded,
                          label: 'Website',
                          value: 'www.air-allspace.org',
                          color: WColors.teal,
                          isDark: isDark),
                      _ContactCard(
                          icon: Icons.chat_rounded,
                          label: 'Community',
                          value: 'forum.air-allspace.org',
                          color: WColors.violet,
                          isDark: isDark),
                    ],
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

// ── Data ──────────────────────────────────────────────────────
class _Val {
  final IconData icon;
  final String title, body;
  final Color color;
  const _Val(this.icon, this.title, this.body, this.color);
}

class _AppFeat {
  final IconData icon;
  final String title, body;
  const _AppFeat(this.icon, this.title, this.body);
}

class _FeatureLine extends StatelessWidget {
  final _AppFeat f;
  final bool isDark;
  const _FeatureLine({required this.f, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? WColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
            color: WColors.indigo.withValues(alpha: 0.12)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: WColors.indigo.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(f.icon, color: WColors.indigo, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(f.title,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: isDark
                            ? Colors.white
                            : const Color(0xFF0F172A))),
                const SizedBox(height: 4),
                Text(f.body,
                    style: TextStyle(
                        fontSize: 12.5,
                        height: 1.5,
                        color: isDark
                            ? Colors.white54
                            : Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  final IconData icon;
  final String label, value;
  final Color color;
  final bool isDark;
  const _ContactCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? WColors.cardDark : WColors.cardLight,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(label,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : const Color(0xFF0F172A))),
          const SizedBox(height: 4),
          Text(value,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 12,
                  color: color,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
