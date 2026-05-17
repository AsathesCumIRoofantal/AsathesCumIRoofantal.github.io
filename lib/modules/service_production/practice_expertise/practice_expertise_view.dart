import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'practice_expertise_controller.dart';

class PracticeExpertiseView extends GetView<PracticeExpertiseController> {
  final bool isEmbedded;
  const PracticeExpertiseView({super.key, this.isEmbedded = false});

  static const _indigo = Color(0xFF4F46E5);
  static const _violet = Color(0xFF7C3AED);
  static const _blue = Color(0xFF2563EB);
  static const _sky = Color(0xFF0EA5E9);
  static const _green = Color(0xFF10B981);
  static const _amber = Color(0xFFF59E0B);
  static const _cyan = Color(0xFF06B6D4);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;
    final bg = isDark ? const Color(0xFF030210) : const Color(0xFFF5F3FF);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: onSurface,
        title: const Text(
          'PRACTICE EXPERTISE',
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
            child: Icon(Icons.model_training_rounded, color: _indigo, size: 22),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        shrinkWrap: isEmbedded,
        physics: isEmbedded ? const NeverScrollableScrollPhysics() : null,
        children: [
          _buildHeroHeader(context, isDark, onSurface),
          const SizedBox(height: 20),
          _buildSectionLabel(
            'SKILL DEPTH TRACKER',
            Icons.stacked_bar_chart_rounded,
            _indigo,
            onSurface,
          ),
          const SizedBox(height: 12),
          _buildDepthTracker(context, isDark, onSurface),
          const SizedBox(height: 24),
          _buildSectionLabel(
            'RECENT SESSIONS',
            Icons.edit_calendar_rounded,
            _violet,
            onSurface,
          ),
          const SizedBox(height: 12),
          _buildSessionLog(context, isDark, onSurface),
          const SizedBox(height: 24),
          _buildSectionLabel(
            'EXPERTISE TOOLS',
            Icons.build_rounded,
            _blue,
            onSurface,
          ),
          const SizedBox(height: 12),
          _buildExpertCard(
            context,
            isDark,
            Icons.edit_calendar_rounded,
            _indigo,
            'Practice Session Log',
            'Record each deliberate practice session with duration, focus area, and self-assessed quality rating. '
                'The log builds a visible streak that reinforces the habit and makes gaps immediately apparent. '
                'Session quality ratings are trended over time so you can see whether your practice is improving in effectiveness — high reps of poor-quality practice builds bad habits, not expertise.',
          ),
          const SizedBox(height: 10),
          _buildExpertCard(
            context,
            isDark,
            Icons.rate_review_rounded,
            _violet,
            'Feedback Journal',
            'Capture coach, peer, and self-feedback after each practice block in a structured journal format. '
                'Recurring feedback themes are surfaced automatically so you can spot patterns across dozens of sessions. '
                'The journal uses a three-column format: what the feedback was, what it suggests about your current habit or gap, and the specific adjustment you will make in the next session — closing the loop between observation and action.',
          ),
          const SizedBox(height: 10),
          _buildExpertCard(
            context,
            isDark,
            Icons.map_rounded,
            _blue,
            'Specialisation Roadmap',
            'Define the specific expertise milestones you are working toward and the practice path to reach each one. '
                'Roadmap progress is visualised as a journey so you always know how far you have come and what remains. '
                'Each milestone has a defined exit criteria — not just "practise more" but specific observable behaviours that confirm you have reached the next level of mastery, making progress unambiguous.',
          ),
          const SizedBox(height: 10),
          _buildExpertCard(
            context,
            isDark,
            Icons.fitness_center_rounded,
            _sky,
            'Rep Counter & Goals',
            'Set weekly and monthly repetition targets for high-priority skills and track completion in real time. '
                'Missed targets trigger a gentle nudge rather than a penalty, keeping motivation constructive. '
                'Rep goals are calibrated to your available practice time — an ambitious goal that consistently goes unmet demoralises faster than a modest goal consistently hit, so the system starts conservative and scales up.',
          ),
          const SizedBox(height: 10),
          _buildExpertCard(
            context,
            isDark,
            Icons.leaderboard_rounded,
            _cyan,
            'Expert Benchmark Library',
            'Compare your practice metrics against anonymised benchmarks from top performers in the same domain. '
                'Benchmarks reveal which dimensions of practice correlate most strongly with expert-level outcomes. '
                'The library is updated quarterly with new benchmark data, ensuring the reference points reflect current best practice rather than historical standards that may no longer represent the state of the art.',
          ),
          const SizedBox(height: 10),
          _buildExpertCard(
            context,
            isDark,
            Icons.workspace_premium_rounded,
            _amber,
            'Mastery Certificates',
            'Earn verifiable mastery certificates when you hit predefined practice and assessment thresholds for a skill. '
                'Certificates are stored in your AIR profile and can be shared with teams or included in performance reviews. '
                'Certificate thresholds are set by domain experts in the AIR community, ensuring they represent genuine mastery rather than participation benchmarks — a certificate signals something real.',
          ),
          const SizedBox(height: 20),
          _buildPracticeQuote(context, isDark, onSurface),
        ],
      ),
    );
  }

  Widget _buildHeroHeader(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF0E0840), const Color(0xFF060420)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _indigo.withValues(alpha: 0.38)),
        boxShadow: [
          BoxShadow(color: _violet.withValues(alpha: 0.12), blurRadius: 16),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _indigo.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.model_training_rounded,
                  color: _violet,
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'DELIBERATE PRACTICE SYSTEM',
                      style: TextStyle(
                        fontSize: 9,
                        color: _violet,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Expertise is not accidental — it is the cumulative result of intentional reps recorded and reviewed over time. Log deliberate practice sessions and deepen specialisation through structured feedback loops.',
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
              _stat('184h', 'Total Hours', _indigo),
              const SizedBox(width: 16),
              _stat('21d', 'Streak', _violet),
              const SizedBox(width: 16),
              _stat('4', 'Skills', _sky),
              const SizedBox(width: 16),
              _stat('2', 'Certs', _amber),
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

  Widget _buildDepthTracker(
    BuildContext context,
    bool isDark,
    Color onSurface,
  ) {
    final skills = [
      ('System Design', 0.72, _indigo),
      ('Communication', 0.85, _sky),
      ('Data Analysis', 0.68, _cyan),
      ('Leadership', 0.60, _violet),
    ];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.04)
            : Colors.black.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _indigo.withValues(alpha: 0.14)),
      ),
      child: Column(
        children: skills
            .map(
              (s) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          s.$1,
                          style: TextStyle(fontSize: 12, color: onSurface),
                        ),
                        Text(
                          '${(s.$2 * 10).round()}/10',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: s.$3,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Stack(
                      children: [
                        Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.07),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: s.$2,
                          child: Container(
                            height: 6,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [s.$3.withValues(alpha: 0.7), s.$3],
                              ),
                              borderRadius: BorderRadius.circular(3),
                              boxShadow: [
                                BoxShadow(
                                  color: s.$3.withValues(alpha: 0.35),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildSessionLog(BuildContext context, bool isDark, Color onSurface) {
    final sessions = [
      ('System Design — Microservices', '90 min', '⭐⭐⭐⭐', _indigo, 'Today'),
      (
        'Communication — Feedback Delivery',
        '45 min',
        '⭐⭐⭐⭐⭐',
        _sky,
        'Yesterday',
      ),
      ('Data Analysis — SQL Deep Dive', '60 min', '⭐⭐⭐', _cyan, '3 days ago'),
    ];
    return Column(
      children: sessions
          .map(
            (s) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: s.$4.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: s.$4.withValues(alpha: 0.18)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: s.$4.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.fitness_center_rounded,
                      color: s.$4,
                      size: 14,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          s.$1,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: onSurface,
                          ),
                        ),
                        Text(
                          '${s.$2} · ${s.$3}',
                          style: TextStyle(
                            fontSize: 10,
                            color: onSurface.withValues(alpha: 0.55),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    s.$5,
                    style: TextStyle(
                      fontSize: 9,
                      color: s.$4,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildExpertCard(
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

  Widget _buildPracticeQuote(
    BuildContext context,
    bool isDark,
    Color onSurface,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _indigo.withValues(alpha: 0.10),
            _violet.withValues(alpha: 0.07),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _indigo.withValues(alpha: 0.20)),
      ),
      child: Row(
        children: [
          const Icon(Icons.format_quote_rounded, color: _amber, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '"In theory, there is no difference between practice and theory. In practice, there is." — Yogi Berra',
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
