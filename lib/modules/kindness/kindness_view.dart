import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'kindness_controller.dart';

class KindnessView extends GetView<KindnessController> {
  final bool isEmbedded;
  const KindnessView({super.key, this.isEmbedded = false});

  static const _coral = Color(0xFFF97316);
  static const _rose = Color(0xFFF43F5E);
  static const _pink = Color(0xFFEC4899);
  static const _violet = Color(0xFF8B5CF6);
  static const _teal = Color(0xFF14B8A6);
  static const _amber = Color(0xFFF59E0B);
  static const _sky = Color(0xFF38BDF8);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;
    final bg = isDark ? const Color(0xFF080308) : const Color(0xFFFFF1F2);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: onSurface,
        title: const Text(
          'KINDNESS',
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
            child: Icon(
              Icons.volunteer_activism_outlined,
              color: _rose,
              size: 22,
            ),
          ),
        ],
      ),
      body: ListView(
        physics: isEmbedded ? const NeverScrollableScrollPhysics() : null,
        shrinkWrap: isEmbedded,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          _buildHeroHeader(context, isDark, onSurface),
          const SizedBox(height: 20),
          _buildSectionLabel(
            'TODAY\'S KINDNESS LOG',
            Icons.wb_sunny_outlined,
            _coral,
            onSurface,
          ),
          const SizedBox(height: 12),
          _buildKindnessLog(context, isDark, onSurface),
          const SizedBox(height: 24),
          _buildSectionLabel(
            'KINDNESS PRACTICES',
            Icons.spa_rounded,
            _pink,
            onSurface,
          ),
          const SizedBox(height: 12),
          _buildKindCard(
            context,
            isDark,
            Icons.wb_sunny_outlined,
            _coral,
            'Daily Kindness Habit',
            'One intentional act of kindness per day compounds into a reputation and a character. Log small acts — holding a door, a genuine compliment, a helpful message — to build the habit through visibility. '
                'Micro-kindnesses are as powerful as grand gestures because they are daily and consistent — the person who remembers your name, who asks a follow-up question, who notices when you\'re off, is doing micro-kindness at scale. '
                'The daily log includes a prompt at a time of your choosing to pause and reflect on whether you\'ve created a moment of genuine warmth for someone that day — a 30-second practice that rebuilds attention to others.',
          ),
          const SizedBox(height: 10),
          _buildKindCard(
            context,
            isDark,
            Icons.sentiment_satisfied_alt_outlined,
            _amber,
            'Politeness Defaults',
            'Politeness is the baseline — please, thank you, eye contact, full attention. Define your non-negotiable politeness defaults so they operate automatically even when you\'re tired or stressed. '
                'Defaults matter precisely because they operate when your conscious attention is elsewhere — building them means your worst moments still meet a minimum standard that preserves relationships and dignity. '
                'The defaults audit includes specific wording to avoid — dismissive phrases that have become habitual, tones that slip in under pressure — and replacement phrases practised until the new pattern becomes automatic.',
          ),
          const SizedBox(height: 10),
          _buildKindCard(
            context,
            isDark,
            Icons.self_improvement_outlined,
            _violet,
            'Kindness Under Pressure',
            'Anyone can be kind when things are easy. The real test is how you treat people when you\'re frustrated, rushed, or disappointed. Log moments where you chose kindness under pressure. '
                'Under-pressure kindness is a muscle — it strengthens with deliberate practice and weakens with neglect. Each logged instance of choosing patience over irritation is a strengthening rep. '
                'The pressure kindness log includes a brief note on what made the situation difficult, helping you identify your personal triggers and prepare in advance for the contexts where your kindness most reliably fails.',
          ),
          const SizedBox(height: 10),
          _buildKindCard(
            context,
            isDark,
            Icons.visibility_outlined,
            _sky,
            'Noticing Others',
            'Kindness starts with noticing — who looks tired, who needs help, who hasn\'t spoken in a while. Train your attention to scan for others\' needs before they have to ask. '
                'Noticing is a trainable skill, not a personality trait. The practice is simple: before entering any group setting, spend 30 seconds scanning the room for who looks like they might need something. '
                'The noticing log records what you observed and what you did — over time, the log reveals patterns in whose needs you naturally spot and whose you tend to miss, showing you where to direct your attentiveness deliberately.',
          ),
          const SizedBox(height: 10),
          _buildKindCard(
            context,
            isDark,
            Icons.chat_outlined,
            _teal,
            'Words That Land Well',
            'Some words open people up; others shut them down. Keep a personal list of phrases that have landed well in difficult conversations and revisit them before high-stakes interactions. '
                'The language library is built from real experience — phrases you used that produced connection, understanding, or relief — making it a highly personalised tool calibrated to your own voice and relationships. '
                'Pre-conversation review takes 2 minutes and significantly improves the quality of high-stakes conversations by grounding you in language that has already proven effective in similar contexts.',
          ),
          const SizedBox(height: 10),
          _buildKindCard(
            context,
            isDark,
            Icons.spa_outlined,
            _rose,
            'Kindness to Yourself',
            'You cannot sustain kindness toward others if you\'re running on self-criticism. Log moments of self-compassion — rest taken without guilt, mistakes forgiven, progress acknowledged. '
                'Self-kindness is not self-indulgence — it is the maintenance practice that keeps your capacity for genuine kindness toward others from depleting. Chronically self-critical people gradually become harsher toward others too. '
                'The self-compassion log prompts you to write three sentences after any significant mistake: what happened, what you learned, and one kind thing you would say to a friend in your situation — then say it to yourself.',
          ),
          const SizedBox(height: 20),
          _buildKindnessQuote(context, isDark, onSurface),
        ],
      ),
    );
  }

  Widget _buildHeroHeader(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF3D000C), const Color(0xFF1A0006)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _rose.withValues(alpha: 0.38)),
        boxShadow: [
          BoxShadow(color: _rose.withValues(alpha: 0.12), blurRadius: 16),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _rose.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.volunteer_activism_outlined,
                  color: _rose,
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'OPERATIONAL KINDNESS',
                      style: TextStyle(
                        fontSize: 9,
                        color: _rose,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Kindness in AIR is treated as an operational habit, not a personality trait. Build consistent, deliberate acts of consideration into daily interactions — not as performance, but as practice.',
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
              _stat('7d', 'Streak', _coral),
              const SizedBox(width: 16),
              _stat('34', 'Acts Logged', _pink),
              const SizedBox(width: 16),
              _stat('3', 'Today', _amber),
              const SizedBox(width: 16),
              _stat('91%', 'Score', _teal),
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

  Widget _buildKindnessLog(BuildContext context, bool isDark, Color onSurface) {
    final acts = [
      (
        'Genuine compliment to a colleague',
        Icons.sentiment_very_satisfied_rounded,
        _pink,
      ),
      ('Helped a new member navigate AIR', Icons.help_outline_rounded, _sky),
      ('Sent a check-in message to a friend', Icons.message_rounded, _teal),
    ];
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _rose.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _rose.withValues(alpha: 0.18)),
      ),
      child: Column(
        children: acts.asMap().entries.map((e) {
          final a = e.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: a.$3.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(a.$2, color: a.$3, size: 14),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    a.$1,
                    style: TextStyle(fontSize: 12, color: onSurface),
                  ),
                ),
                const Icon(
                  Icons.check_circle_rounded,
                  color: Color(0xFF10B981),
                  size: 16,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildKindCard(
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

  Widget _buildKindnessQuote(
    BuildContext context,
    bool isDark,
    Color onSurface,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _rose.withValues(alpha: 0.10),
            _coral.withValues(alpha: 0.07),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _rose.withValues(alpha: 0.20)),
      ),
      child: Row(
        children: [
          const Icon(Icons.format_quote_rounded, color: _pink, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '"No act of kindness, no matter how small, is ever wasted." — Aesop',
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
