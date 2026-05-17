import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'together_unison_controller.dart';

class TogetherUnisonView extends GetView<TogetherUnisonController> {
  final bool isEmbedded;
  const TogetherUnisonView({super.key, this.isEmbedded = false});

  static const _rose = Color(0xFFE11D48);
  static const _pink = Color(0xFFDB2777);
  static const _coral = Color(0xFFEA580C);
  static const _amber = Color(0xFFF59E0B);
  static const _violet = Color(0xFF7C3AED);
  static const _teal = Color(0xFF0D9488);
  static const _blue = Color(0xFF3B82F6);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;
    final bg = isDark ? const Color(0xFF0D0306) : const Color(0xFFFFF1F3);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: onSurface,
        title: const Text(
          'TOGETHER IN UNISON',
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
            child: Icon(Icons.groups_rounded, color: _rose, size: 22),
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
            'UNISON HEALTH PULSE',
            Icons.favorite_rounded,
            _rose,
            onSurface,
          ),
          const SizedBox(height: 12),
          _buildPulsePanel(context, isDark, onSurface),
          const SizedBox(height: 24),
          _buildSectionLabel(
            'GROUP CAPABILITIES',
            Icons.settings_rounded,
            _pink,
            onSurface,
          ),
          const SizedBox(height: 12),
          _buildGroupCard(
            context,
            isDark,
            Icons.account_tree_rounded,
            _violet,
            'Role Clarity Map',
            'Define each team member\'s primary role, decision authority, and the interfaces where their work touches others. '
                'Role ambiguity is the single most common source of team friction — a clear map eliminates most conflicts before they start. '
                'Role maps are reviewed every 90 days to account for natural evolution in responsibilities and to re-align overlapping authority zones.',
          ),
          const SizedBox(height: 10),
          _buildGroupCard(
            context,
            isDark,
            Icons.calendar_month_rounded,
            _blue,
            'Shared Rhythm Calendar',
            'Establish the recurring cadences — standups, reviews, retrospectives, and social touchpoints — that give the group a predictable heartbeat. '
                'Rhythm reduces coordination overhead and creates the psychological safety that comes from knowing when and how the group will connect. '
                'Rhythm adherence scores are tracked so the group can see objectively whether their cadence is being honoured or is gradually eroding.',
          ),
          const SizedBox(height: 10),
          _buildGroupCard(
            context,
            isDark,
            Icons.handshake_rounded,
            _rose,
            'Conflict Repair Protocol',
            'When tension surfaces, use the structured repair protocol to move from positions to interests and find solutions that honour everyone\'s core needs. '
                'Groups that repair well are stronger after conflict than before it — the protocol turns friction into a trust-building event. '
                'Protocol sessions are logged (with consent) so patterns of recurring conflict can be identified and addressed at the systemic level rather than case-by-case.',
          ),
          const SizedBox(height: 10),
          _buildGroupCard(
            context,
            isDark,
            Icons.leaderboard_rounded,
            _teal,
            'Contribution Visibility Board',
            'Make each member\'s contributions visible to the whole group so recognition is accurate, timely, and not dependent on self-promotion. '
                'Invisible contributions breed resentment; a visibility board ensures that quiet contributors are seen and valued. '
                'Visibility data feeds directly into the Rewards & Credits system so that consistent contributors receive tangible recognition, not just applause.',
          ),
          const SizedBox(height: 10),
          _buildGroupCard(
            context,
            isDark,
            Icons.how_to_vote_rounded,
            _coral,
            'Group Decision Framework',
            'Choose the right decision mode — consent, consensus, or authority — for each type of choice the group faces, and document the rationale. '
                'Mismatched decision modes are a hidden source of group dysfunction; the framework aligns expectations before the decision is made. '
                'Decision modes are pre-agreed for recurring decision types so the group does not spend time debating process when it should be debating substance.',
          ),
          const SizedBox(height: 10),
          _buildGroupCard(
            context,
            isDark,
            Icons.favorite_rounded,
            _pink,
            'Unison Health Pulse',
            'Run a brief anonymous pulse survey after each major group event to measure psychological safety, clarity, and energy levels. '
                'The pulse gives leaders early warning of harmony erosion so they can intervene before small cracks become structural fractures. '
                'Pulse results are shared with the whole group in aggregate form — honesty is only possible when individuals feel safe to respond candidly.',
          ),
          const SizedBox(height: 24),
          _buildSectionLabel(
            'WHAT UNISON IS NOT',
            Icons.info_outline_rounded,
            _amber,
            onSurface,
          ),
          const SizedBox(height: 12),
          _buildUniformityCard(context, isDark, onSurface),
          const SizedBox(height: 20),
          _buildQuoteBanner(context, isDark, onSurface),
        ],
      ),
    );
  }

  Widget _buildHeroHeader(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF4D0015), const Color(0xFF26000B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _rose.withValues(alpha: 0.40)),
        boxShadow: [
          BoxShadow(
            color: _rose.withValues(alpha: 0.15),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
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
                child: const Icon(Icons.groups_rounded, color: _rose, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'GROUP HARMONY MODULE',
                      style: TextStyle(
                        fontSize: 10,
                        color: _rose,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Create harmony in groups by clarifying roles, establishing shared rhythms, and building the repair skills that keep teams intact through inevitable friction.',
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
              _buildStat('4', 'Active Groups', _rose),
              const SizedBox(width: 16),
              _buildStat('87%', 'Health Score', _pink),
              const SizedBox(width: 16),
              _buildStat('2', 'Open Conflicts', _amber),
              const SizedBox(width: 16),
              _buildStat('94%', 'Rhythm Rate', _teal),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String v, String l, Color c) => Expanded(
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
            letterSpacing: 0.3,
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

  Widget _buildPulsePanel(BuildContext context, bool isDark, Color onSurface) {
    final dimensions = [
      ('Psychological Safety', 0.82, _rose),
      ('Role Clarity', 0.76, _pink),
      ('Communication Quality', 0.89, _teal),
      ('Energy & Morale', 0.71, _amber),
    ];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.04)
            : Colors.black.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _rose.withValues(alpha: 0.15)),
      ),
      child: Column(
        children: dimensions
            .map(
              (d) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          d.$1,
                          style: TextStyle(fontSize: 12, color: onSurface),
                        ),
                        Text(
                          '${(d.$2 * 100).round()}%',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: d.$3,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Stack(
                      children: [
                        Container(
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.07),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: d.$2,
                          child: Container(
                            height: 5,
                            decoration: BoxDecoration(
                              color: d.$3,
                              borderRadius: BorderRadius.circular(3),
                              boxShadow: [
                                BoxShadow(
                                  color: d.$3.withValues(alpha: 0.35),
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

  Widget _buildGroupCard(
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

  Widget _buildUniformityCard(
    BuildContext context,
    bool isDark,
    Color onSurface,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _amber.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _amber.withValues(alpha: 0.20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Unison is the disciplined coordination of different strengths toward a common beat — not the suppression of difference to create conformity.',
            style: TextStyle(
              fontSize: 13,
              fontStyle: FontStyle.italic,
              height: 1.5,
              color: onSurface,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.close_rounded, color: _rose, size: 14),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Not uniformity — not everyone thinking and acting identically.',
                  style: TextStyle(
                    fontSize: 11,
                    color: onSurface.withValues(alpha: 0.70),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.check_rounded, color: _teal, size: 14),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Coordinated diversity — different strengths, single direction.',
                  style: TextStyle(
                    fontSize: 11,
                    color: onSurface.withValues(alpha: 0.70),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuoteBanner(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _rose.withValues(alpha: 0.10),
            _violet.withValues(alpha: 0.07),
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
              '"Alone we can do so little; together we can do so much."',
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
