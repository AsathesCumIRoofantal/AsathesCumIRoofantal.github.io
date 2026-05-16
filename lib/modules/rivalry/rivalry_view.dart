import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'rivalry_controller.dart';

class RivalryView extends GetView<RivalryController> {
  const RivalryView({super.key});

  static const _fire = Color(0xFFDC2626);
  static const _orange = Color(0xFFEA580C);
  static const _amber = Color(0xFFF59E0B);
  static const _lime = Color(0xFF84CC16);
  static const _green = Color(0xFF10B981);
  static const _blue = Color(0xFF2563EB);
  static const _violet = Color(0xFF7C3AED);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;
    final bg = isDark ? const Color(0xFF0C0200) : const Color(0xFFFFF7F0);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: onSurface,
        title: const Text(
          'RIVALRY',
          style: TextStyle(
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(Icons.sports_score_outlined, color: _fire, size: 22),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          _buildHeroHeader(context, isDark, onSurface),
          const SizedBox(height: 20),
          _buildSectionLabel(
            'RIVALRY HEALTH CHECK',
            Icons.favorite_border,
            _orange,
            onSurface,
          ),
          const SizedBox(height: 12),
          _buildHealthCheck(context, isDark, onSurface),
          const SizedBox(height: 24),
          _buildSectionLabel(
            'RIVALRY TOOLKIT',
            Icons.build_rounded,
            _amber,
            onSurface,
          ),
          const SizedBox(height: 12),
          _buildCard(
            context,
            isDark,
            Icons.person_search_outlined,
            _fire,
            'Identify Your Rivals',
            'A rival is someone whose performance sets your benchmark. Name the people or teams you measure yourself against — not to diminish them, but to use their excellence as a calibration point for your own. '
                'Clear rivals are more motivating than vague ambition because they are concrete, observable, and immediately comparable to your current performance. '
                'The rival register includes a "why I respect this rival" field — articulating their genuine strengths builds the honest assessment capability that makes rivalry productive rather than merely emotional.',
          ),
          const SizedBox(height: 10),
          _buildCard(
            context,
            isDark,
            Icons.trending_up_outlined,
            _amber,
            'What They Do Better',
            'Honest rivalry requires honest assessment. Log the specific areas where your rival outperforms you — their speed, their craft, their consistency — and treat each gap as a training target. '
                'The gap log is the bridge between rivalry and improvement — without it, rivalry produces only motivation; with it, motivation is directed at specific, closeable deficits. '
                'Gap assessments are reviewed quarterly so you can see whether the gap is closing, stable, or widening — turning rivalry from an emotional experience into a trackable training programme.',
          ),
          const SizedBox(height: 10),
          _buildCard(
            context,
            isDark,
            Icons.warning_amber_outlined,
            _fire,
            'Rivalry vs. Resentment',
            'Rivalry becomes toxic when it tips into resentment — wanting them to fail rather than wanting yourself to improve. Monitor your internal narrative and redirect it toward your own progress. '
                'The rivalry-resentment distinction is a mindset, not a situation: the same event (being beaten) can trigger either a training response or a resentment response depending on how you interpret it. '
                'Monthly rivalry check-ins include a "narrative audit" prompt: when you think about this rival, are your thoughts primarily about your own improvement or about their failure? The answer tells you which mode you are in.',
          ),
          const SizedBox(height: 10),
          _buildCard(
            context,
            isDark,
            Icons.school_outlined,
            _blue,
            'Learning from Losses',
            'Every time a rival beats you is a data point. Log the outcome, analyse what they did differently, and extract one concrete lesson you can apply before the next encounter. '
                'The lesson extraction process prevents loss from being merely demoralising — it converts a defeat into a training briefing, maintaining forward momentum. '
                'Loss analyses are reviewed before the next significant competition or comparison to confirm the extracted lesson has been applied and is producing observable change in performance.',
          ),
          const SizedBox(height: 10),
          _buildCard(
            context,
            isDark,
            Icons.handshake_outlined,
            _green,
            'Mutual Respect',
            'The best rivalries are built on mutual respect — each party acknowledging the other\'s quality. Acknowledge your rival\'s wins publicly and privately; it keeps the competition clean and motivating. '
                'Public acknowledgement of a rival\'s win signals security and integrity — qualities that enhance your own reputation while maintaining the quality of the competitive relationship. '
                'The mutual respect log tracks specific acknowledgements made, confirming that your rivalry is operating at the level of conduct you intend rather than drifting toward unsportsmanlike patterns.',
          ),
          const SizedBox(height: 10),
          _buildCard(
            context,
            isDark,
            Icons.timer_off_outlined,
            _lime,
            'Rivalry Expiry',
            'Some rivalries outlive their usefulness — the gap closes, the context changes, or the relationship evolves. Know when to retire a rivalry and convert it into collaboration or simple admiration. '
                'Rivalry that continues past its natural useful life produces diminishing motivational returns and increasing relationship cost — noticing the signs early enables a graceful transition. '
                'Expiry signals include: performance parity (gap closed), context divergence (you are now in different arenas), or emotional tone shift (the relationship has become genuinely friendly rather than competitive).',
          ),
          const SizedBox(height: 20),
          _buildRivalryQuote(context, isDark, onSurface),
        ],
      ),
    );
  }

  Widget _buildHeroHeader(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF2A0800), const Color(0xFF150400)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _fire.withValues(alpha: 0.38)),
        boxShadow: [
          BoxShadow(color: _orange.withValues(alpha: 0.14), blurRadius: 18),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _fire.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.sports_score_outlined,
                  color: _orange,
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'HEALTHY COMPETITION',
                      style: TextStyle(
                        fontSize: 10,
                        color: _orange,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Healthy rivalry sharpens you — it raises your standard, exposes your gaps, and pushes you past comfortable plateaus. Channel competitive tension into growth rather than letting it corrode relationships.',
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
              _stat('3', 'Rivals', _fire),
              const SizedBox(width: 16),
              _stat('8', 'Gap Items', _amber),
              const SizedBox(width: 16),
              _stat('4', 'Lessons', _lime),
              const SizedBox(width: 16),
              _stat('1', 'Retiring', _green),
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

  Widget _buildHealthCheck(BuildContext context, bool isDark, Color onSurface) {
    final checks = [
      ('Motivated by my own improvement', true, _green),
      ('Acknowledge rival\'s genuine quality', true, _green),
      ('Extract lessons from every loss', true, _green),
      ('Sometimes want rival to fail instead', false, _fire),
    ];
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.04)
            : Colors.black.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _amber.withValues(alpha: 0.14)),
      ),
      child: Column(
        children: checks
            .map(
              (c) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Icon(
                      c.$2 ? Icons.check_circle_rounded : Icons.warning_rounded,
                      color: c.$3,
                      size: 16,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        c.$1,
                        style: TextStyle(fontSize: 12, color: onSurface),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildCard(
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

  Widget _buildRivalryQuote(
    BuildContext context,
    bool isDark,
    Color onSurface,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _fire.withValues(alpha: 0.10),
            _amber.withValues(alpha: 0.07),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _fire.withValues(alpha: 0.20)),
      ),
      child: Row(
        children: [
          const Icon(Icons.format_quote_rounded, color: _amber, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '"Iron sharpens iron." — Proverbs 27:17',
              style: TextStyle(
                fontSize: 13,
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
