// ============================================================
// web_modules/web_wisdom_page.dart
// Route: /web-wisdom  →  WebWisdomPage
// ============================================================

import 'package:flutter/material.dart';

import '_web_layout.dart';

class WebWisdomPage extends StatelessWidget {
  const WebWisdomPage({super.key});

  static const String routeName = '/web-wisdom';

  static const _pillars = [
    _Pillar(
      icon: Icons.visibility_off_rounded,
      title: 'Illusions',
      body:
          'Imagination aspects suggested by an expert but not yet verified as '
          'objective reality. They challenge perception and build '
          'discernment.',
      color: Color(0xFFE11D48),
    ),
    _Pillar(
      icon: Icons.auto_awesome_rounded,
      title: 'Imagination',
      body:
          'The ability to construct scenarios, entities, or unions within your '
          'cognitive network without physical stimuli — the seed of every '
          'breakthrough.',
      color: Color(0xFF7C3AED),
    ),
    _Pillar(
      icon: Icons.verified_rounded,
      title: 'Reality',
      body:
          'All validated and verified matrices of All-Space. Entities mapped '
          'here have measurable, constant attributes confirmed by the AIR '
          'Organisation.',
      color: Color(0xFF059669),
    ),
    _Pillar(
      icon: Icons.view_in_ar_rounded,
      title: 'Virtual',
      body:
          'Properties that simulate reality without physical presence — '
          'structural abstractions that expand the frontier of experience.',
      color: Color(0xFF0284C7),
    ),
    _Pillar(
      icon: Icons.bolt_rounded,
      title: 'Insights',
      body:
          'Distilled moments of clarity extracted from observation, study, '
          'and lived experience inside All-Space.',
      color: Color(0xFFF59E0B),
    ),
    _Pillar(
      icon: Icons.self_improvement_rounded,
      title: 'Mindfulness',
      body:
          'Sustained, non-judgmental awareness of present-moment data — the '
          'practice that keeps every decision in All-Space grounded.',
      color: Color(0xFF0D9488),
    ),
  ];

  static const _quotes = [
    _Quote(
      text: 'The beginning of wisdom is the discovery of our own ignorance.',
      author: 'AIR Maxim',
    ),
    _Quote(
      text:
          'Knowledge speaks, but wisdom listens — and then acts with precision.',
      author: 'Mazeasta Principle',
    ),
    _Quote(
      text:
          'Every illusion you dissolve brings you one step closer to your '
          'verified reality.',
      author: 'AIR Organisation',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? WColors.surfaceDark : WColors.surface,
      appBar: WNavBar(title: 'WISDOM', color: const Color(0xFF7C3AED)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero
            WHeroBanner(
              title: 'Wisdom in All-Space',
              subtitle:
                  'Not a definition — an invitation. Walk through the four '
                  'dimensions of knowing, then carry one truth home with you.',
              colorA: const Color(0xFF4C1D95),
              colorB: const Color(0xFF7C3AED),
              icon: Icons.menu_book_rounded,
            ),

            const SizedBox(height: 48),

            // Pillars grid
            WMaxWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const WSectionHeader(
                    eyebrow: 'Core Dimensions',
                    title: 'Six Pillars of Wisdom',
                    subtitle:
                        'Each pillar is a lens through which All-Space data '
                        'is interpreted, filtered, and acted upon.',
                    accent: Color(0xFF7C3AED),
                  ),
                  const SizedBox(height: 28),
                  WGrid(
                    children: _pillars
                        .map(
                          (p) => WFeatureCard(
                            icon: p.icon,
                            title: p.title,
                            body: p.body,
                            color: p.color,
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 48),

            // Quotes section
            Container(
              color: isDark ? const Color(0xFF1E1B4B) : const Color(0xFFEDE9FE),
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: WMaxWidth(
                child: Column(
                  children: [
                    const WSectionHeader(
                      eyebrow: 'Mazeasta Maxims',
                      title: 'Words that Govern',
                      accent: Color(0xFF7C3AED),
                    ),
                    const SizedBox(height: 28),
                    ..._quotes.map((q) => _QuoteTile(q: q, isDark: isDark)),
                  ],
                ),
              ),
            ),

            // Expert note
            const SizedBox(height: 40),
            WMaxWidth(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFF59E0B).withValues(alpha: 0.4),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.warning_amber_rounded,
                      color: Color(0xFFD97706),
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Expert Supervision Required',
                            style: TextStyle(
                              color: Color(0xFF92400E),
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Wisdom modules are best explored under the '
                            'guidance of your recommended expert. '
                            'Engage thoughtfully.',
                            style: TextStyle(
                              color: Color(0xFF92400E),
                              fontSize: 13,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
class _Pillar {
  final IconData icon;
  final String title;
  final String body;
  final Color color;
  const _Pillar({
    required this.icon,
    required this.title,
    required this.body,
    required this.color,
  });
}

class _Quote {
  final String text;
  final String author;
  const _Quote({required this.text, required this.author});
}

class _QuoteTile extends StatelessWidget {
  final _Quote q;
  final bool isDark;
  const _QuoteTile({required this.q, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? WColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFF7C3AED).withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.format_quote_rounded,
            color: Color(0xFF7C3AED),
            size: 28,
          ),
          const SizedBox(height: 8),
          Text(
            q.text,
            style: TextStyle(
              fontSize: 15,
              height: 1.6,
              fontStyle: FontStyle.italic,
              color: isDark ? Colors.white70 : const Color(0xFF1E1B4B),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '— ${q.author}',
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF7C3AED),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
