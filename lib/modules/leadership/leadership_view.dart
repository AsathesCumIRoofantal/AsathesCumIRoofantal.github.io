import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'leadership_controller.dart';

class LeadershipView extends GetView<LeadershipController> {
  const LeadershipView({super.key});

  static const _navy = Color(0xFF1E3A5F);
  static const _blue = Color(0xFF2563EB);
  static const _sky = Color(0xFF0EA5E9);
  static const _cyan = Color(0xFF06B6D4);
  static const _green = Color(0xFF10B981);
  static const _amber = Color(0xFFF59E0B);
  static const _violet = Color(0xFF7C3AED);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;
    final bg = isDark ? const Color(0xFF020610) : const Color(0xFFEFF6FF);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: onSurface,
        title: const Text(
          'LEADERSHIP',
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
            child: Icon(Icons.military_tech_outlined, color: _blue, size: 22),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          _buildHeroHeader(context, isDark, onSurface),
          const SizedBox(height: 20),
          _buildSectionLabel(
            'LEADERSHIP POSTURE',
            Icons.track_changes_outlined,
            _blue,
            onSurface,
          ),
          const SizedBox(height: 12),
          _buildPostureGrid(context, isDark, onSurface),
          const SizedBox(height: 24),
          _buildSectionLabel(
            'LEADERSHIP TOOLS',
            Icons.build_rounded,
            _sky,
            onSurface,
          ),
          const SizedBox(height: 12),
          _buildLeaderCard(
            context,
            isDark,
            Icons.track_changes_outlined,
            _blue,
            'Vision Setting',
            'A leader without a written vision is just reacting. Define your 90-day and 1-year north stars so every decision has a reference point. AIR tracks your vision statements and flags when actions drift from them. '
                'Effective vision statements are specific enough to make tradeoffs obvious and inspiring enough to motivate action during difficult periods — the right level of ambiguity is a craft, not an accident. '
                'Vision reviews are built into the quarterly cycle so your north stars evolve as you learn rather than becoming outdated anchors holding the team in the wrong direction.',
          ),
          const SizedBox(height: 10),
          _buildLeaderCard(
            context,
            isDark,
            Icons.account_tree_outlined,
            _cyan,
            'Delegation Map',
            'Delegation is not abdication — it requires matching task complexity to the right person\'s skill level. Log who owns what, at what authority level, and when you expect a status update back. '
                'The map distinguishes three delegation modes: instruct (tell them exactly what to do), coach (guide them to find the answer), and empower (hand full ownership and step back). '
                'Delegation decisions are logged with the rationale so you can review whether your matching assumptions were accurate and calibrate future assignments accordingly.',
          ),
          const SizedBox(height: 10),
          _buildLeaderCard(
            context,
            isDark,
            Icons.fact_check_outlined,
            _green,
            'Decision Log',
            'Great leaders document why they decided, not just what they decided. Capture key decisions with context, alternatives considered, and the expected outcome so you can review and learn. '
                'The decision log creates an intellectual audit trail — it prevents repeating past mistakes, enables faster onboarding of new team members, and builds institutional memory that survives personnel changes. '
                'Logging decisions in the moment takes 5 minutes but saves hours of reconstruction later when the context has faded and stakeholders are questioning the reasoning.',
          ),
          const SizedBox(height: 10),
          _buildLeaderCard(
            context,
            isDark,
            Icons.checklist_outlined,
            _amber,
            'Follow-Through Tracker',
            'Commitments made in meetings evaporate without a system. AIR lets you log promises you made to your team and surfaces them before the next check-in so nothing slips. '
                'The tracker distinguishes between commitments made publicly (in team settings) and privately (in 1:1s), applying different visibility rules to protect sensitive conversations. '
                'Follow-through rates are one of the most reliable predictors of team trust — the tracker gives you data to understand your own patterns before they become an issue others notice first.',
          ),
          const SizedBox(height: 10),
          _buildLeaderCard(
            context,
            isDark,
            Icons.rate_review_outlined,
            _violet,
            'Feedback Cadence',
            'Regular, specific feedback is the fastest way to grow the people around you. Set a rhythm — weekly, bi-weekly — and use AIR to draft honest, constructive notes before each session. '
                'Feedback cadence is not about having regular meetings — it is about maintaining a continuous signal between leader and team member that makes the relationship a genuine development relationship. '
                'Feedback notes are drafted with a structured format: observation, impact, request — so each piece of feedback is specific, consequential, and actionable rather than vague or general.',
          ),
          const SizedBox(height: 10),
          _buildLeaderCard(
            context,
            isDark,
            Icons.menu_book_outlined,
            _sky,
            'Leadership Principles',
            'Your personal leadership principles are the rules you refuse to break under pressure. Write them down, review them quarterly, and let them guide how you handle conflict and ambiguity. '
                'Documented principles prevent the slow erosion that happens when expedient exceptions gradually become the new normal — a written principle is far harder to rationalise away than a mental one. '
                'Principles are tested most under conditions that make breaking them feel reasonable — having written them in calm moments gives you a compass when the pressure to compromise is highest.',
          ),
          const SizedBox(height: 10),
          _buildLeaderCard(
            context,
            isDark,
            Icons.bolt_outlined,
            _amber,
            'Energy & Presence',
            'How you show up sets the tone for everyone around you. Track your energy levels, note what drains versus fuels you, and design your schedule to protect your highest-impact hours. '
                'Leader energy is contagious — teams unconsciously calibrate their own energy and sense of safety to the leader\'s visible emotional state, making your inner state a team-level factor. '
                'Energy management is a leadership skill, not a personal preference — scheduling recovery and protecting your highest-energy windows is a strategic act that multiplies your impact.',
          ),
          const SizedBox(height: 20),
          _buildLeadershipQuote(context, isDark, onSurface),
        ],
      ),
    );
  }

  Widget _buildHeroHeader(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF071428), const Color(0xFF03080F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _blue.withValues(alpha: 0.38)),
        boxShadow: [
          BoxShadow(color: _blue.withValues(alpha: 0.14), blurRadius: 20),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _blue.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.military_tech_outlined,
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
                      'LEADERSHIP COMMAND CENTRE',
                      style: TextStyle(
                        fontSize: 9,
                        color: _sky,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Leadership in AIR is about setting clear direction and following through with accountability — from vision-casting to delegation and execution.',
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
              _stat('7', 'Open Loops', _sky),
              const SizedBox(width: 16),
              _stat('12', 'Delegated', _cyan),
              const SizedBox(width: 16),
              _stat('91%', 'Follow-thru', _green),
              const SizedBox(width: 16),
              _stat('4', 'Reviews Due', _amber),
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

  Widget _buildPostureGrid(BuildContext context, bool isDark, Color onSurface) {
    final postures = [
      (Icons.visibility_rounded, 'Visionary', 'Sets the north star', _blue),
      (
        Icons.account_tree_rounded,
        'Delegator',
        'Matches tasks to talent',
        _cyan,
      ),
      (Icons.psychology_rounded, 'Coach', 'Develops the people', _violet),
      (Icons.shield_rounded, 'Protector', 'Guards the team\'s path', _green),
    ];
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 2.2,
      children: postures
          .map(
            (p) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: p.$4.withValues(alpha: 0.07),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: p.$4.withValues(alpha: 0.22)),
              ),
              child: Row(
                children: [
                  Icon(p.$1, color: p.$4, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          p.$2,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: onSurface,
                          ),
                        ),
                        Text(
                          p.$3,
                          style: TextStyle(
                            fontSize: 9,
                            color: onSurface.withValues(alpha: 0.55),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildLeaderCard(
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

  Widget _buildLeadershipQuote(
    BuildContext context,
    bool isDark,
    Color onSurface,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _blue.withValues(alpha: 0.10),
            _violet.withValues(alpha: 0.07),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _blue.withValues(alpha: 0.20)),
      ),
      child: Row(
        children: [
          const Icon(Icons.format_quote_rounded, color: _amber, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '"The function of leadership is to produce more leaders, not more followers." — Ralph Nader',
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
