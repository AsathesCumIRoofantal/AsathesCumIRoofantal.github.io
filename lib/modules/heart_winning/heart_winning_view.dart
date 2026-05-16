import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'heart_winning_controller.dart';

class HeartWinningView extends GetView<HeartWinningController> {
  const HeartWinningView({super.key});

  static const _crimson = Color(0xFFDC2626);
  static const _rose = Color(0xFFF43F5E);
  static const _orange = Color(0xFFF97316);
  static const _amber = Color(0xFFF59E0B);
  static const _teal = Color(0xFF0D9488);
  static const _blue = Color(0xFF3B82F6);
  static const _violet = Color(0xFF7C3AED);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;
    final bg = isDark ? const Color(0xFF080003) : const Color(0xFFFFF5F5);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: onSurface,
        title: const Text(
          'HEART WINNING',
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
            child: Icon(Icons.volunteer_activism, color: _rose, size: 22),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          _buildHeroHeader(context, isDark, onSurface),
          const SizedBox(height: 20),
          _buildSectionLabel(
            'LEADERSHIP DIMENSIONS',
            Icons.favorite,
            _rose,
            onSurface,
          ),
          const SizedBox(height: 12),
          _buildDimGrid(context, isDark, onSurface),
          const SizedBox(height: 24),
          _buildSectionLabel(
            'HEART-CENTRED TOOLS',
            Icons.build_rounded,
            _orange,
            onSurface,
          ),
          const SizedBox(height: 12),
          _buildCard(
            context,
            isDark,
            Icons.favorite,
            _rose,
            'Empathetic Leadership',
            'Learn frameworks for leading with emotional intelligence alongside operational authority. '
                'Case studies show how empathetic decisions build long-term trust with communities and teams. '
                'Empathetic leadership does not mean avoiding hard decisions — it means making them with full awareness of their human impact, communicating them with care, and following up on the people most affected.',
          ),
          const SizedBox(height: 10),
          _buildCard(
            context,
            isDark,
            Icons.groups,
            _orange,
            'Community Engagement',
            'Plan and record outreach activities that connect leaders directly with the people they serve. '
                'Engagement logs capture feedback and commitments made during community interactions. '
                'The engagement planner includes a listening-mode protocol — structured sessions where the leader\'s role is only to receive, not to defend, explain, or respond, allowing genuinely unfiltered input to surface.',
          ),
          const SizedBox(height: 10),
          _buildCard(
            context,
            isDark,
            Icons.policy,
            _blue,
            'Policy with Purpose',
            'Review policies through a human-centred lens to identify where rules can be applied with compassion. '
                'Annotate policies with empathy notes that guide frontline staff in sensitive situations. '
                'Purpose annotations distinguish between the letter of the policy (what it requires) and the spirit (what it is trying to achieve) — enabling frontline staff to honour the intent even in edge cases the policy did not anticipate.',
          ),
          const SizedBox(height: 10),
          _buildCard(
            context,
            isDark,
            Icons.hearing,
            _teal,
            'Listening Sessions',
            'Schedule and document structured listening sessions where leaders hear concerns without agenda. '
                'Session summaries are shared back with participants to demonstrate that voices were heard. '
                'The shared-back summary is the most critical step — when people see their specific words reflected in writing, they know they were genuinely heard rather than performatively consulted.',
          ),
          const SizedBox(height: 10),
          _buildCard(
            context,
            isDark,
            Icons.star_outline,
            _amber,
            'Recognition & Gratitude',
            'Acknowledge the contributions of individuals and communities through formal and informal recognition. '
                'Gratitude expressed publicly reinforces a culture where people feel valued and seen. '
                'The recognition log distinguishes between private (individual) and public (group) recognition — both matter, and the appropriate mode depends on the recipient\'s preference, not the leader\'s comfort level.',
          ),
          const SizedBox(height: 10),
          _buildCard(
            context,
            isDark,
            Icons.handshake,
            _violet,
            'Conflict Resolution',
            'Apply principled negotiation techniques to resolve disputes in a way that preserves relationships. '
                'Resolution templates guide leaders through structured dialogue toward mutually acceptable outcomes. '
                'Heart-centred conflict resolution focuses on interests (what people genuinely need) rather than positions (what they are demanding), consistently producing agreements that both parties actually honour.',
          ),
          const SizedBox(height: 10),
          _buildCard(
            context,
            isDark,
            Icons.auto_stories,
            _teal,
            'Impact Stories',
            'Capture and share stories of positive change that resulted from heart-centred leadership decisions. '
                'Stories inspire others and build an evidence base for the value of empathetic governance. '
                'Impact stories follow a narrative arc — the challenge faced, the human-centred choice made, the outcome achieved — making them shareable, memorable, and useful as teaching tools for developing other leaders.',
          ),
          const SizedBox(height: 20),
          _buildHeartQuote(context, isDark, onSurface),
        ],
      ),
    );
  }

  Widget _buildHeroHeader(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF38000A), const Color(0xFF1C0005)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _rose.withValues(alpha: 0.38)),
        boxShadow: [
          BoxShadow(color: _crimson.withValues(alpha: 0.14), blurRadius: 16),
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
                  Icons.volunteer_activism,
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
                      'EMPATHETIC PUBLIC LEADERSHIP',
                      style: TextStyle(
                        fontSize: 9,
                        color: _rose,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Winning hearts means delivering results while treating every person with dignity and respect. Sound policy and genuine empathy are not opposites — the best leaders master both.',
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
              _stat('94%', 'Trust Score', _rose),
              const SizedBox(width: 16),
              _stat('12', 'Sessions', _orange),
              const SizedBox(width: 16),
              _stat('7', 'Stories', _teal),
              const SizedBox(width: 16),
              _stat('3', 'Resolutions', _violet),
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

  Widget _buildDimGrid(BuildContext context, bool isDark, Color onSurface) {
    final dims = [
      (Icons.favorite, 'Empathy', _rose),
      (Icons.hearing, 'Listening', _teal),
      (Icons.star_outline, 'Recognition', _amber),
      (Icons.policy, 'Compassion', _blue),
    ];
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 2.5,
      children: dims
          .map(
            (d) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: d.$3.withValues(alpha: 0.07),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: d.$3.withValues(alpha: 0.20)),
              ),
              child: Row(
                children: [
                  Icon(d.$1, color: d.$3, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    d.$2,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: onSurface,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
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

  Widget _buildHeartQuote(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _rose.withValues(alpha: 0.10),
            _teal.withValues(alpha: 0.07),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _rose.withValues(alpha: 0.20)),
      ),
      child: Row(
        children: [
          const Icon(Icons.format_quote_rounded, color: _amber, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '"People don\'t care how much you know until they know how much you care." — Theodore Roosevelt',
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
