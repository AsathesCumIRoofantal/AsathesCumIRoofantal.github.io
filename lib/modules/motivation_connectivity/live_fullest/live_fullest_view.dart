import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'live_fullest_controller.dart';

class LiveFullestView extends GetView<LiveFullestController> {
  const LiveFullestView({super.key});

  static const _sky = Color(0xFF0EA5E9);
  static const _teal = Color(0xFF0D9488);
  static const _purple = Color(0xFF9333EA);
  static const _pink = Color(0xFFEC4899);
  static const _amber = Color(0xFFF59E0B);
  static const _lime = Color(0xFF84CC16);
  static const _rose = Color(0xFFE11D48);
  static const _orange = Color(0xFFEA580C);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;
    final bg = isDark ? const Color(0xFF020812) : const Color(0xFFF0FAFF);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: onSurface,
        title: const Text(
          'LIVE TO THE FULLEST',
          style: TextStyle(
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(Icons.self_improvement_rounded, color: _sky, size: 22),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          _buildHeroHeader(context, isDark, onSurface),
          const SizedBox(height: 20),
          _buildSectionLabel(
            '8 LIFE DOMAINS',
            Icons.radar_rounded,
            _sky,
            onSurface,
          ),
          const SizedBox(height: 12),
          _buildDomainGrid(context, isDark, onSurface),
          const SizedBox(height: 24),
          _buildSectionLabel(
            'FULLEST LIVING TOOLS',
            Icons.bolt_rounded,
            _purple,
            onSurface,
          ),
          const SizedBox(height: 12),
          _buildToolCard(
            context,
            isDark,
            Icons.radar_rounded,
            _sky,
            'Life Domain Audit',
            'Score your current satisfaction across eight life domains — health, relationships, work, finances, growth, play, purpose, and environment. '
                'The audit reveals which domains are thriving and which are quietly draining the energy you need everywhere else. '
                'Audit results are visualised as a life-balance wheel — a single glance shows you where you are full and where you are running on empty.',
          ),
          const SizedBox(height: 10),
          _buildToolCard(
            context,
            isDark,
            Icons.bolt_rounded,
            _amber,
            'Energy Architecture',
            'Map your daily energy peaks and troughs, then redesign your schedule so your most demanding work lands in your highest-energy windows. '
                'Energy management is the foundation of full living — without it, even the best intentions collapse under fatigue. '
                'Energy mapping is done over 7 days to capture enough data to distinguish genuine patterns from random daily variation before you restructure your schedule.',
          ),
          const SizedBox(height: 10),
          _buildToolCard(
            context,
            isDark,
            Icons.explore_rounded,
            _teal,
            'Ethical Compass Check',
            'Periodically review your choices against your stated values to catch the slow drift that happens when convenience quietly overrides conviction. '
                'The compass check is not about guilt — it is about recalibrating so your actions and your identity stay aligned. '
                'A quarterly compass check takes less than 10 minutes and generates a private alignment score that becomes a meaningful longitudinal record of your values-consistency over years.',
          ),
          const SizedBox(height: 10),
          _buildToolCard(
            context,
            isDark,
            Icons.sentiment_very_satisfied_rounded,
            _pink,
            'Joy Inventory',
            'List the activities, people, and environments that reliably produce genuine joy — not just pleasure or distraction, but deep aliveness. '
                'The inventory ensures joy is scheduled, not left to chance, and that it grows as a deliberate part of your life design. '
                'Joy sources are categorised by cost, time, and accessibility so you can always find a joy source that fits your current constraints rather than waiting for perfect conditions.',
          ),
          const SizedBox(height: 10),
          _buildToolCard(
            context,
            isDark,
            Icons.landscape_rounded,
            _purple,
            'Whole-Life Vision Board',
            'Build a structured vision that integrates career ambition, relational depth, physical vitality, and spiritual meaning into one coherent picture. '
                'A whole-life vision prevents the trap of succeeding in one domain while quietly neglecting the others that make success feel worthwhile. '
                'The vision board is reviewed every six months and evolved — it is a living document, not a static aspiration frozen at a single point in time.',
          ),
          const SizedBox(height: 10),
          _buildToolCard(
            context,
            isDark,
            Icons.hourglass_top_rounded,
            _rose,
            'Regret Minimisation Frame',
            'Use the regret-minimisation framework to evaluate big decisions by asking which choice your future self will be most grateful for. '
                'The frame shifts decision-making from short-term comfort to long-term fulfilment, the hallmark of a life lived fully. '
                'The framework prompts you to write from the perspective of yourself at 80 looking back — a cognitive shift that reliably surfaces what genuinely matters versus what merely feels urgent.',
          ),
          const SizedBox(height: 10),
          _buildToolCard(
            context,
            isDark,
            Icons.wb_sunny_rounded,
            _orange,
            'Daily Aliveness Ritual',
            'Design a morning or evening ritual that begins or ends each day with one small act of intentionality — a reflection, a gratitude note, a commitment for the day ahead. '
                'Small daily rituals compound into a fundamentally different quality of life over months and years. '
                'Ritual streaks are tracked in AIR, and the cumulative record becomes a powerful visual reminder of the identity you are building one day at a time.',
          ),
          const SizedBox(height: 20),
          _buildLifeQuote(context, isDark, onSurface),
        ],
      ),
    );
  }

  Widget _buildHeroHeader(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF001A33), const Color(0xFF000D1A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _sky.withValues(alpha: 0.35)),
        boxShadow: [
          BoxShadow(color: _sky.withValues(alpha: 0.12), blurRadius: 18),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _sky.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.self_improvement_rounded,
                  color: _sky,
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'WHOLE LIFE DESIGN',
                      style: TextStyle(
                        fontSize: 10,
                        color: _sky,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Design a whole life where energy, ethics, and joy occupy the same frame — not competing priorities but a single integrated vision.',
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.4,
                        color: Colors.white60,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _stat('8', 'Domains', _sky),
              const SizedBox(width: 16),
              _stat('73%', 'Balance', _teal),
              const SizedBox(width: 16),
              _stat('12d', 'Ritual Streak', _pink),
              const SizedBox(width: 16),
              _stat('High', 'Energy', _lime),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stat(String v, String l, Color c) => Expanded(
    child: Column(
      children: [
        Text(
          v,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: c),
        ),
        Text(
          l,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 8,
            color: c.withValues(alpha: 0.8),
            height: 1.2,
          ),
        ),
      ],
    ),
  );

  Widget _buildSectionLabel(
    String title,
    IconData icon,
    Color color,
    Color onSurface,
  ) => Row(
    children: [
      Icon(icon, color: color, size: 16),
      const SizedBox(width: 8),
      Text(
        title,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
          color: color,
        ),
      ),
    ],
  );

  Widget _buildDomainGrid(BuildContext context, bool isDark, Color onSurface) {
    final domains = [
      (Icons.favorite_rounded, 'Health', '82%', _rose),
      (Icons.people_rounded, 'Relationships', '76%', _pink),
      (Icons.work_rounded, 'Work', '90%', _sky),
      (Icons.account_balance_wallet_rounded, 'Finances', '65%', _amber),
      (Icons.trending_up_rounded, 'Growth', '88%', _lime),
      (Icons.sports_esports_rounded, 'Play', '55%', _purple),
      (Icons.stars_rounded, 'Purpose', '92%', _orange),
      (Icons.nature_rounded, 'Environment', '71%', _teal),
    ];
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 0.85,
      children: domains
          .map(
            (d) => Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: d.$4.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: d.$4.withValues(alpha: 0.22)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(d.$1, color: d.$4, size: 18),
                  const SizedBox(height: 4),
                  Text(
                    d.$2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: onSurface,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    d.$3,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: d.$4,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildToolCard(
    BuildContext context,
    bool isDark,
    IconData icon,
    Color color,
    String title,
    String body,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.20)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  body,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.5,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.72),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLifeQuote(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _sky.withValues(alpha: 0.10),
            _purple.withValues(alpha: 0.07),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _sky.withValues(alpha: 0.20)),
      ),
      child: Row(
        children: [
          const Icon(Icons.format_quote_rounded, color: _sky, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '"The purpose of life is to live it, to taste experience to the utmost, to reach out eagerly and without fear for newer and richer experience." — Eleanor Roosevelt',
              style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                height: 1.4,
                color: onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
