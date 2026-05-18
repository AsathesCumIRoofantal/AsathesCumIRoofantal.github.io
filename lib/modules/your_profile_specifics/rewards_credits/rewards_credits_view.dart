import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'rewards_credits_controller.dart';

class RewardsCreditsView extends GetView<RewardsCreditsController> {
  final bool isEmbedded;
  const RewardsCreditsView({super.key, this.isEmbedded = false});

  static const _gold = Color(0xFFD4AF37);
  static const _amber = Color(0xFFFFC107);
  static const _bronze = Color(0xFFCD7F32);
  static const _silver = Color(0xFFC0C0C0);
  static const _diamond = Color(0xFF64D8FF);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      color: isDark ? const Color(0xFF0D0A00) : const Color(0xFFFFF8E1),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        shrinkWrap: isEmbedded,
        physics: isEmbedded ? const NeverScrollableScrollPhysics() : null,
        children: [
          _buildBalanceCard(context, isDark),
          const SizedBox(height: 20),
          _buildTierProgress(context, isDark),
          const SizedBox(height: 24),
          _buildSectionHeader(
            'ACHIEVEMENT BADGES',
            Icons.military_tech_rounded,
            _gold,
          ),
          const SizedBox(height: 12),
          _buildBadgeGrid(context, isDark),
          const SizedBox(height: 24),
          _buildSectionHeader(
            'RECOGNITION TRIGGERS',
            Icons.bolt_rounded,
            _amber,
          ),
          const SizedBox(height: 12),
          ..._triggers.map((t) => _buildTriggerCard(context, isDark, t)),
          const SizedBox(height: 24),
          _buildSectionHeader(
            'REDEMPTION CATALOGUE',
            Icons.redeem_rounded,
            _diamond,
          ),
          const SizedBox(height: 12),
          _buildRedemptionGrid(context, isDark),
          const SizedBox(height: 24),
          _buildSectionHeader(
            'POSTURE & SETTINGS',
            Icons.tune_rounded,
            _silver,
          ),
          const SizedBox(height: 12),
          ..._postureItems.map((p) => _buildPostureRow(context, isDark, p)),
          const SizedBox(height: 20),
          _buildInfoBanner(context, isDark),
        ],
      ),
    );
  }

  Widget _buildBalanceCard(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF3D2B00), const Color(0xFF1A1200)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _gold.withValues(alpha: 0.40)),
        boxShadow: [
          BoxShadow(
            color: _gold.withValues(alpha: 0.12),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'CURRENT BALANCE',
                style: TextStyle(fontSize: 10, letterSpacing: 2, color: _gold),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _gold.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _gold.withValues(alpha: 0.35)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.diamond_rounded, size: 12, color: _diamond),
                    SizedBox(width: 4),
                    Text(
                      'GOLD TIER',
                      style: TextStyle(
                        fontSize: 9,
                        color: _gold,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                '2,840',
                style: TextStyle(
                  fontSize: 44,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1,
                ),
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: const Text(
                  'AIR-V',
                  style: TextStyle(
                    fontSize: 16,
                    color: _gold,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Alifiyas Value Credits',
            style: TextStyle(fontSize: 12, color: Colors.white54),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildMiniStat(
                'Earned',
                '3,200',
                Icons.add_circle_outline,
                Colors.greenAccent,
              ),
              const SizedBox(width: 16),
              _buildMiniStat(
                'Redeemed',
                '360',
                Icons.remove_circle_outline,
                Colors.redAccent,
              ),
              const SizedBox(width: 16),
              _buildMiniStat('Rank', '#12', Icons.leaderboard_rounded, _gold),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStat(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 9,
                color: Colors.white38,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTierProgress(BuildContext context, bool isDark) {
    final tiers = [
      (_bronze, 'BRONZE', true),
      (_silver, 'SILVER', true),
      (_gold, 'GOLD', true),
      (_diamond, 'DIAMOND', false),
    ];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.04)
            : Colors.black.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _gold.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'TIER JOURNEY',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              color: _gold,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: tiers.asMap().entries.map((e) {
              final t = e.value;
              return Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: t.$1.withValues(alpha: t.$3 ? 0.2 : 0.06),
                              border: Border.all(
                                color: t.$1,
                                width: t.$3 ? 2 : 1,
                              ),
                            ),
                            child: Icon(
                              Icons.workspace_premium_rounded,
                              size: 14,
                              color: t.$1.withValues(alpha: t.$3 ? 1 : 0.35),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            t.$2,
                            style: TextStyle(
                              fontSize: 8,
                              letterSpacing: 1,
                              color: t.$1.withValues(alpha: t.$3 ? 1 : 0.35),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (e.key < tiers.length - 1)
                      Expanded(
                        child: Container(
                          height: 2,
                          color: tiers[e.key + 1].$3
                              ? tiers[e.key].$1.withValues(alpha: 0.5)
                              : Colors.white.withValues(alpha: 0.08),
                        ),
                      ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: 0.71,
            backgroundColor: Colors.white.withValues(alpha: 0.08),
            valueColor: AlwaysStoppedAnimation(_diamond),
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 6),
          const Text(
            '71% to Diamond — 1,160 AIR-V needed',
            style: TextStyle(fontSize: 10, color: _diamond),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color color) {
    return Row(
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
  }

  Widget _buildBadgeGrid(BuildContext context, bool isDark) {
    final badges = [
      (
        'First Post',
        Icons.post_add_rounded,
        _bronze,
        'Published your first experience record',
        true,
      ),
      (
        'Wisdom Seeker',
        Icons.auto_stories_rounded,
        _silver,
        'Completed 5 wisdom readings',
        true,
      ),
      (
        'Contributor',
        Icons.volunteer_activism_rounded,
        _gold,
        'Made 10 verified contributions',
        true,
      ),
      (
        'Identity Mapped',
        Icons.fingerprint,
        _diamond,
        'Completed the full identity questionnaire',
        true,
      ),
      (
        'Knowledge Node',
        Icons.hub_rounded,
        _teal,
        'Added 20 knowledge center entries',
        false,
      ),
      (
        'AIR Builder',
        Icons.construction_rounded,
        _purple,
        'Contributed to 3 AIR development cycles',
        false,
      ),
    ];
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.5,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: badges
          .map(
            (b) => Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: b.$3.withValues(alpha: b.$5 ? 0.10 : 0.03),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: b.$3.withValues(alpha: b.$5 ? 0.35 : 0.10),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        b.$2,
                        color: b.$3.withValues(alpha: b.$5 ? 1 : 0.3),
                        size: 20,
                      ),
                      const Spacer(),
                      Icon(
                        b.$5
                            ? Icons.check_circle_rounded
                            : Icons.lock_outline_rounded,
                        size: 12,
                        color: b.$3.withValues(alpha: b.$5 ? 0.8 : 0.25),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    b.$1,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: b.$5 ? 1 : 0.4),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Expanded(
                    child: Text(
                      b.$4,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 9,
                        height: 1.3,
                        color: Theme.of(context).colorScheme.onSurface
                            .withValues(alpha: b.$5 ? 0.6 : 0.25),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  static const _teal = Color(0xFF009688);
  static const _purple = Color(0xFF7B1FA2);

  Widget _buildTriggerCard(BuildContext context, bool isDark, _Trigger t) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: t.color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: t.color.withValues(alpha: 0.18)),
      ),
      child: Row(
        children: [
          Icon(t.icon, color: t.color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.action,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  t.description,
                  style: TextStyle(
                    fontSize: 11,
                    height: 1.3,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: t.color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              t.credits,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: t.color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRedemptionGrid(BuildContext context, bool isDark) {
    final options = [
      (
        Icons.upgrade_rounded,
        'Pro Access',
        '500 AIR-V',
        const Color(0xFF7B1FA2),
      ),
      (
        Icons.priority_high_rounded,
        'Priority Review',
        '200 AIR-V',
        const Color(0xFFE64A19),
      ),
      (Icons.record_voice_over_rounded, 'Expert Session', '1000 AIR-V', _gold),
      (
        Icons.workspace_premium_rounded,
        'AIR Commendation',
        '300 AIR-V',
        const Color(0xFF388E3C),
      ),
    ];
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.6,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: options
          .map(
            (o) => Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: o.$4.withValues(alpha: 0.07),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: o.$4.withValues(alpha: 0.20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(o.$1, color: o.$4, size: 22),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        o.$2,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        o.$3,
                        style: TextStyle(
                          fontSize: 10,
                          color: o.$4,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildPostureRow(BuildContext context, bool isDark, _PostureItem p) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.04)
            : Colors.black.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.08),
        ),
      ),
      child: Row(
        children: [
          Icon(p.icon, size: 18, color: _silver),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  p.title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Text(
                  p.description,
                  style: TextStyle(
                    fontSize: 11,
                    height: 1.3,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.55),
                  ),
                ),
              ],
            ),
          ),
          Switch(value: p.defaultOn, onChanged: (_) {}, activeColor: _gold),
        ],
      ),
    );
  }

  Widget _buildInfoBanner(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _gold.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _gold.withValues(alpha: 0.18)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline_rounded, color: _gold, size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Rewards and credits in AIR are a transparent record of the behaviours the platform values — '
              'not gamification. Every credit is earned through genuine contribution and can never be revoked.',
              style: TextStyle(
                fontSize: 11,
                height: 1.4,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.72),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Trigger {
  final String action;
  final String description;
  final String credits;
  final IconData icon;
  final Color color;
  const _Trigger(
    this.action,
    this.description,
    this.credits,
    this.icon,
    this.color,
  );
}

final _triggers = [
  _Trigger(
    'Share an Experience',
    'Publish a verified lived experience for others to learn from.',
    '+50 AIR-V',
    Icons.share_rounded,
    Color(0xFF009688),
  ),
  _Trigger(
    'Complete Identity Map',
    'Finish the full philosophical identity questionnaire.',
    '+200 AIR-V',
    Icons.fingerprint,
    Color(0xFF7B1FA2),
  ),
  _Trigger(
    'Add Knowledge Entry',
    'Propose and have a knowledge item approved by AIR Admin.',
    '+30 AIR-V',
    Icons.library_add_rounded,
    Color(0xFF1565C0),
  ),
  _Trigger(
    'Query Answered',
    'Receive an expert-verified answer to your public query.',
    '+15 AIR-V',
    Icons.question_answer_rounded,
    Color(0xFF388E3C),
  ),
  _Trigger(
    'Peer Recognition',
    'Receive a formal commendation from a verified AIR peer.',
    '+80 AIR-V',
    Icons.waving_hand_rounded,
    Color(0xFFD4AF37),
  ),
];

class _PostureItem {
  final String title;
  final String description;
  final IconData icon;
  final bool defaultOn;
  const _PostureItem(this.title, this.description, this.icon, this.defaultOn);
}

final _postureItems = [
  _PostureItem(
    'Public Balance Visibility',
    'Display your AIR-V balance on your public profile.',
    Icons.visibility_rounded,
    true,
  ),
  _PostureItem(
    'Credit Notifications',
    'Get notified every time new credits are issued to you.',
    Icons.notifications_rounded,
    true,
  ),
  _PostureItem(
    'Peer Recognition Features',
    'Allow community members to commend your contributions.',
    Icons.people_alt_rounded,
    false,
  ),
  _PostureItem(
    'Leaderboard Participation',
    'Include your name in the community credit leaderboard.',
    Icons.leaderboard_rounded,
    false,
  ),
];
