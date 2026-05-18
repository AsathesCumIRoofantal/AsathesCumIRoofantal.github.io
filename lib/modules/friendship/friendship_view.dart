import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'friendship_controller.dart';

class FriendshipView extends GetView<FriendshipController> {
  final bool isEmbedded;
  const FriendshipView({super.key, this.isEmbedded = false});

  static const _peach = Color(0xFFFB923C);
  static const _warm = Color(0xFFEA580C);
  static const _pink = Color(0xFFEC4899);
  static const _rose = Color(0xFFE11D48);
  static const _teal = Color(0xFF0D9488);
  static const _blue = Color(0xFF3B82F6);
  static const _amber = Color(0xFFF59E0B);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;
    final bg = isDark ? const Color(0xFF080403) : const Color(0xFFFFF7ED);

    return ListView(
      physics: isEmbedded ? const NeverScrollableScrollPhysics() : null,
      shrinkWrap: isEmbedded,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      children: [
        _buildHeroHeader(context, isDark, onSurface),
        const SizedBox(height: 20),
        _buildSectionLabel(
          'FRIEND ROSTER',
          Icons.contacts_outlined,
          _pink,
          onSurface,
        ),
        const SizedBox(height: 12),
        _buildFriendCircles(context, isDark, onSurface),
        const SizedBox(height: 24),
        _buildSectionLabel(
          'FRIENDSHIP TOOLKIT',
          Icons.build_rounded,
          _warm,
          onSurface,
        ),
        const SizedBox(height: 12),
        _buildFriendCard(
          context,
          isDark,
          Icons.phone_outlined,
          _peach,
          'Reach-Out Log',
          'Log every meaningful reach-out — a call, a message, a coffee. Seeing the last contact date for each friend makes it obvious who you\'ve been neglecting before the relationship fades. '
              'The log highlights friends you haven\'t contacted in more than 30 days with a gentle nudge — not to create obligation, but to make the invisible visible before it becomes a regret. '
              'Reach-out entries include a mood note so you can see which friends leave you energised and which drain you — useful data for managing your social energy over time.',
        ),
        const SizedBox(height: 10),
        _buildFriendCard(
          context,
          isDark,
          Icons.compare_arrows_outlined,
          _blue,
          'Reciprocity Check',
          'Healthy friendships flow both ways. Track who initiates contact and notice patterns — if you\'re always the one reaching out, it\'s worth a conversation or a quiet recalibration. '
              'Reciprocity data is presented as a ratio over a rolling 90-day window — it accounts for natural fluctuations (life seasons, workload) without penalising temporarily one-sided periods. '
              'The check is not about keeping score; it is about having honest information before a friendship quietly erodes to the point where both parties feel too distant to reconnect.',
        ),
        const SizedBox(height: 10),
        _buildFriendCard(
          context,
          isDark,
          Icons.record_voice_over_outlined,
          _rose,
          'Depth Conversations',
          'Surface-level chat keeps friendships alive but doesn\'t deepen them. Log the last time you had a real conversation — about fears, goals, struggles — and schedule the next one. '
              'Depth is built through vulnerability, which requires both safety and preparation — knowing you want to go deeper before the conversation starts makes it more likely to actually happen. '
              'The depth log includes a bank of conversation starters calibrated to different friendship stages, from acquaintance to close friend, making the first move toward depth easier.',
        ),
        const SizedBox(height: 10),
        _buildFriendCard(
          context,
          isDark,
          Icons.explore_outlined,
          _teal,
          'Shared Experiences',
          'Shared experiences are the fastest way to strengthen a friendship. Plan activities together — a trip, a project, a challenge — and log them as anchors in your shared history. '
              'Shared experiences work because they create memories that belong uniquely to the two of you, building a relational vocabulary and a reference point only you share. '
              'The experience planner includes low-effort, high-connection options for busy periods — a 30-minute walk, a co-working session, a shared podcast — so depth does not require elaborate planning.',
        ),
        const SizedBox(height: 10),
        _buildFriendCard(
          context,
          isDark,
          Icons.handshake_outlined,
          _amber,
          'Support Given & Received',
          'Note when a friend showed up for you and when you showed up for them. Gratitude for support received keeps you from taking friendships for granted during easy times. '
              'Support records create a private ledger of the moments that actually defined the friendship — the 2am call, the job reference, the show-up when it mattered. '
              'Reviewing support history before reconnecting with a friend after a gap naturally rekindles warmth and gives you authentic material for the reopening conversation.',
        ),
        const SizedBox(height: 10),
        _buildFriendCard(
          context,
          isDark,
          Icons.contacts_outlined,
          _pink,
          'Friend Roster',
          'Know who your actual friends are versus acquaintances. Categorise your relationships by depth — close, casual, professional — so you can allocate your social energy intentionally. '
              'Research consistently shows that most people can maintain approximately 5 close friendships, 15 good friends, and 50 regular contacts simultaneously — the roster helps you operate within your natural capacity. '
              'The roster includes a "last meaningful interaction" date for every person so you can quickly see which relationships are alive, dormant, or quietly fading before intervention becomes difficult.',
        ),
        const SizedBox(height: 20),
        _buildFriendQuote(context, isDark, onSurface),
      ],
    );
  }

  Widget _buildHeroHeader(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF3D1200), const Color(0xFF1A0800)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _peach.withValues(alpha: 0.35)),
        boxShadow: [
          BoxShadow(color: _pink.withValues(alpha: 0.10), blurRadius: 16),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _pink.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.group_outlined, color: _pink, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'RELATIONSHIP MAINTENANCE',
                      style: TextStyle(
                        fontSize: 9,
                        color: _pink,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Friendships decay without maintenance — not from malice, but from neglect. Track reach-outs, check reciprocity, and ensure your closest relationships get the attention they deserve.',
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
              _stat('14', 'Friends', _pink),
              const SizedBox(width: 16),
              _stat('3', 'Overdue', _rose),
              const SizedBox(width: 16),
              _stat('7d', 'Last Reach', _peach),
              const SizedBox(width: 16),
              _stat('82%', 'Reciprocity', _teal),
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

  Widget _buildFriendCircles(
    BuildContext context,
    bool isDark,
    Color onSurface,
  ) {
    final circles = [
      ('Close Friends', '5', 'Weekly contact', _rose),
      ('Good Friends', '9', 'Monthly contact', _pink),
      ('Casual Contacts', '28', 'Occasional', _peach),
    ];
    return Row(
      children: circles
          .map(
            (c) => Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: c.$4.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: c.$4.withValues(alpha: 0.22)),
                ),
                child: Column(
                  children: [
                    Text(
                      c.$2,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: c.$4,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      c.$1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: onSurface,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      c.$3,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 9,
                        color: c.$4.withValues(alpha: 0.80),
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildFriendCard(
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

  Widget _buildFriendQuote(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _pink.withValues(alpha: 0.10),
            _peach.withValues(alpha: 0.07),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _pink.withValues(alpha: 0.20)),
      ),
      child: Row(
        children: [
          const Icon(Icons.format_quote_rounded, color: _peach, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '"A friend is someone who knows all about you and still loves you." — Elbert Hubbard',
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
