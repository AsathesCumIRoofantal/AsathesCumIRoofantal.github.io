import 'dart:math' as math;

import 'package:air_app/modules/fingers_are_crossed/fingers_are_crossed_best_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'fingers_are_crossed_controller.dart';

// ─────────────────────────────────────────────
//  DATA MODELS
// ─────────────────────────────────────────────
enum _HopeStatus { waiting, hopeful, nervous, resolved, archived }

class _HopeBet {
  final String title;
  final String description;
  final String category;
  final _HopeStatus status;
  final int confidencePercent; // 0–100
  final String followUpDate;
  final String parallelPath;
  final String emotionalNote;
  final Color accent;
  final IconData icon;

  const _HopeBet({
    required this.title,
    required this.description,
    required this.category,
    required this.status,
    required this.confidencePercent,
    required this.followUpDate,
    required this.parallelPath,
    required this.emotionalNote,
    required this.accent,
    required this.icon,
  });
}

class _WisdomQuote {
  final String text;
  final String author;
  const _WisdomQuote(this.text, this.author);
}

// ─────────────────────────────────────────────
//  STATIC DATA  (preserves all original content)
// ─────────────────────────────────────────────
const List<_HopeBet> _sampleBets = [
  _HopeBet(
    title: 'Job Application — Senior Role',
    description:
        'Applied for the senior position at the organisation. Interview went well, waiting for the final decision from the panel.',
    category: 'Career',
    status: _HopeStatus.hopeful,
    confidencePercent: 72,
    followUpDate: 'Follow up by Jun 3',
    parallelPath: 'Also applied to two other organisations as parallel paths.',
    emotionalNote:
        'Feeling cautiously optimistic — trying not to over-invest emotionally.',
    accent: Color(0xFF7C4DFF),
    icon: Icons.work_outline_rounded,
  ),
  _HopeBet(
    title: 'Funding Proposal Submitted',
    description:
        'Submitted the grant proposal for the community project. The committee meets next month to review all applications.',
    category: 'Finance',
    status: _HopeStatus.waiting,
    confidencePercent: 55,
    followUpDate: 'Follow up by Jun 15',
    parallelPath:
        'Exploring crowdfunding as a backup if this does not come through.',
    emotionalNote:
        'Neutral — prepared for either outcome and have a plan B ready.',
    accent: Color(0xFF00BCD4),
    icon: Icons.account_balance_outlined,
  ),
  _HopeBet(
    title: 'Partnership Conversation',
    description:
        'Had a promising initial meeting with a potential partner organisation. Waiting for their internal approval.',
    category: 'Collaboration',
    status: _HopeStatus.nervous,
    confidencePercent: 40,
    followUpDate: 'Follow up by May 28',
    parallelPath:
        'Two other potential partners identified if this one does not proceed.',
    emotionalNote:
        'A little anxious — this one matters a lot. Reminding myself I have options.',
    accent: Color(0xFFFF9800),
    icon: Icons.handshake_outlined,
  ),
  _HopeBet(
    title: 'Medical Test Results',
    description:
        'Routine health check done. Waiting for the lab results to come back from the clinic.',
    category: 'Health',
    status: _HopeStatus.resolved,
    confidencePercent: 90,
    followUpDate: 'Resolved — results received',
    parallelPath: 'N/A — results came back clear.',
    emotionalNote: 'Relief. The waiting was harder than the result. Grateful.',
    accent: Color(0xFF4CAF50),
    icon: Icons.favorite_outline_rounded,
  ),
];

const List<_WisdomQuote> _hopeQuotes = [
  _WisdomQuote(
    'Hope is not the conviction that something will turn out well, but the certainty that something makes sense regardless of how it turns out.',
    'Václav Havel',
  ),
  _WisdomQuote('While I breathe, I hope.', 'Latin Proverb — Dum spiro, spero'),
  _WisdomQuote(
    'The very least you can do in your life is figure out what you hope for. And the most you can do is live inside that hope.',
    'Barbara Kingsolver',
  ),
  _WisdomQuote(
    'Hope is being able to see that there is light despite all of the darkness.',
    'Desmond Tutu',
  ),
  _WisdomQuote(
    'Do not spoil what you have by desiring what you have not; remember that what you now have was once among the things you only hoped for.',
    'Epicurus',
  ),
  _WisdomQuote(
    'Optimism is the faith that leads to achievement. Nothing can be done without hope and confidence.',
    'Helen Keller',
  ),
];

const List<Map<String, dynamic>> _featureSections = [
  {
    'title': 'Pending Outcomes Tracker',
    'icon': Icons.pending_actions_outlined,
    'color': Color(0xFF7C4DFF),
    'desc':
        'Log every decision, proposal, or application you\'re waiting on with a clear status. Attach context notes so you remember exactly what\'s at stake when the answer arrives.',
    'points': [
      'Categorise each pending item by type: Career, Finance, Health, Relationship, Creative, or Custom.',
      'Attach a brief context note — what you submitted, who the decision-maker is, and what the stakes are.',
      'Set a status: Waiting, Hopeful, Nervous, Resolved, or Archived — update it as things evolve.',
      'Link related items: a job application and a backup application can be grouped so you see the full picture.',
      'Dashboard view shows all open bets at a glance with their confidence scores and follow-up dates.',
    ],
  },
  {
    'title': 'Follow-Up Nudges',
    'icon': Icons.notifications_active_outlined,
    'color': Color(0xFF00BCD4),
    'desc':
        'Set smart reminders to follow up if you haven\'t heard back by a chosen date. A well-timed nudge keeps momentum without seeming pushy.',
    'points': [
      'Set a follow-up date for each pending item — AIR reminds you the day before so you have time to prepare.',
      'Nudge templates: polite follow-up message drafts you can customise and send directly from the app.',
      'Escalation logic: if no response after the first nudge, a second reminder fires at a longer interval.',
      'Silence tracker: log when you sent a follow-up and what the response was, so you have a clear record.',
      'Do-not-disturb windows: block follow-up nudges during weekends or holidays so timing stays professional.',
    ],
  },
  {
    'title': 'Probability & Confidence Log',
    'icon': Icons.bar_chart_rounded,
    'color': Color(0xFFE91E63),
    'desc':
        'Rate your confidence level for each pending outcome so you can plan contingencies. Revisiting your estimates over time sharpens your intuition.',
    'points': [
      'Slide a confidence meter from 0% (very unlikely) to 100% (near certain) for each pending item.',
      'Log your reasoning: why do you feel this confident? Writing it down prevents post-hoc rationalisation.',
      'Calibration report: compare your predicted confidence to actual outcomes over time — are you over- or under-confident?',
      'Scenario planning: for each item, note the best case, likely case, and worst case so you are never blindsided.',
      'Confidence trend: see how your feeling about an item changes week by week as new information arrives.',
    ],
  },
  {
    'title': 'Parallel Paths',
    'icon': Icons.alt_route_outlined,
    'color': Color(0xFF4CAF50),
    'desc':
        'While one door is closed, keep others open — document your backup plans and alternatives. Healthy waiting means pursuing parallel options.',
    'points': [
      'For every pending item, document at least one parallel path — a backup option you are actively pursuing.',
      'Parallel path status: track each backup independently so you always know where your alternatives stand.',
      'Dependency map: visualise which outcomes depend on each other so you can sequence decisions wisely.',
      'Opportunity cost log: note what you are not pursuing while waiting — helps you decide when to stop waiting.',
      'Pivot trigger: define in advance the condition that would make you abandon the wait and commit to the backup.',
    ],
  },
  {
    'title': 'Outcome Archive',
    'icon': Icons.archive_outlined,
    'color': Color(0xFFFF9800),
    'desc':
        'When results arrive, record what happened and what you learned from the wait. A growing archive becomes a personal calibration tool.',
    'points': [
      'Mark any pending item as Resolved and log the actual outcome — yes, no, partial, or unexpected.',
      'Reflection prompt: what did the waiting teach you? What would you do differently next time?',
      'Calibration check: compare your original confidence score to the actual result — update your mental model.',
      'Gratitude note: for positive outcomes, record what you are grateful for while the feeling is fresh.',
      'Pattern recognition: over time, the archive reveals which categories you tend to over- or under-estimate.',
    ],
  },
  {
    'title': 'Emotional Check-In',
    'icon': Icons.self_improvement_rounded,
    'color': Color(0xFF9C27B0),
    'desc':
        'Waiting can be draining — log how you\'re feeling about each pending item to stay self-aware. Spotting anxiety spikes early lets you redirect energy.',
    'points': [
      'Daily mood log tied to your pending items: rate your anxiety level (1–5) and note what is driving it.',
      'Grounding prompts: when anxiety spikes, AIR offers a short breathing exercise or a reframe question.',
      'Energy redirect: identify one thing you can control today and focus there instead of the uncontrollable wait.',
      'Emotional trend chart: see how your mood around a specific item changes as the wait extends.',
      'Self-compassion reminder: waiting is hard — the app gently reminds you that uncertainty is a shared human experience.',
    ],
  },
  {
    'title': 'Shared Hopes Board',
    'icon': Icons.group_outlined,
    'color': Color(0xFF00BCD4),
    'desc':
        'Invite teammates to add their own pending outcomes to a shared board for visibility. When the team knows what everyone is waiting on, support happens naturally.',
    'points': [
      'Create a shared board for a team, family, or close circle — each member adds their own pending items.',
      'Visibility without pressure: others can see what you are waiting on and offer support without being asked.',
      'Collective celebration: when any member\'s outcome resolves positively, the board notifies the group.',
      'Accountability without surveillance: the board is about mutual support, not monitoring or judgment.',
      'Anonymous mode: add items to the shared board without revealing details — just the category and status.',
    ],
  },
];

// ─────────────────────────────────────────────
//  MAIN VIEW
// ─────────────────────────────────────────────
class FingersAreCrossedView extends GetView<FingersAreCrossedController> {
  final bool isEmbedded;
  const FingersAreCrossedView({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            _buildSliverAppBar(context, isDark),
          ],
          body: const TabBarView(
            children: [
              _HopeDashboardTab(isEmbedded: false),
              _WaitingWisdomTab(isEmbedded: false),
              _FeatureGuideTab(isEmbedded: false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, bool isDark) {
    return SliverAppBar(
      expandedHeight: 210,
      floating: false,
      pinned: true,
      backgroundColor: isDark
          ? const Color(0xFF0D0B1A)
          : const Color(0xFF1A237E),
      iconTheme: const IconThemeData(color: Colors.white),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        titlePadding: const EdgeInsets.only(left: 16, bottom: 56),
        title: const Text(
          'Fingers Are Crossed',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 17,
            letterSpacing: 1.2,
          ),
        ),
        background: _HeroBackground(isDark: isDark),
      ),
      bottom: TabBar(
        indicatorColor: Colors.amber,
        indicatorWeight: 3,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white54,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 11,
          letterSpacing: 0.5,
        ),
        tabs: const [
          Tab(
            icon: Icon(Icons.pending_actions_outlined, size: 18),
            text: 'My Bets',
          ),
          Tab(icon: Icon(Icons.format_quote_rounded, size: 18), text: 'Wisdom'),
          Tab(icon: Icon(Icons.menu_book_outlined, size: 18), text: 'Guide'),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  HERO BACKGROUND  (animated crossing fingers)
// ─────────────────────────────────────────────
class _HeroBackground extends StatefulWidget {
  final bool isDark;
  const _HeroBackground({required this.isDark});

  @override
  State<_HeroBackground> createState() => _HeroBackgroundState();
}

class _HeroBackgroundState extends State<_HeroBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulse = Tween<double>(
      begin: 0.85,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: widget.isDark
              ? [const Color(0xFF1A0533), const Color(0xFF0D1B4A)]
              : [const Color(0xFF1A237E), const Color(0xFF4A148C)],
        ),
      ),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            top: -40,
            right: -40,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.04),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: -30,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.amber.withValues(alpha: 0.06),
              ),
            ),
          ),
          // Floating stars
          ..._buildStars(),
          // Main content
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 52, 20, 64),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Animated hope icon
                AnimatedBuilder(
                  animation: _pulse,
                  builder: (_, __) => Transform.scale(
                    scale: _pulse.value,
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.amber.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: Colors.amber.withValues(alpha: 0.35),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amber.withValues(alpha: 0.2),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Text('🤞', style: TextStyle(fontSize: 32)),
                    ),
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Hopeful Waiting',
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Track pending outcomes and hopeful bets without losing agency or momentum.',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.75),
                          fontSize: 12,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Mini stats row
                      Row(
                        children: [
                          _MiniStat(
                            label: 'Open',
                            value: '3',
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 16),
                          _MiniStat(
                            label: 'Resolved',
                            value: '1',
                            color: Colors.greenAccent,
                          ),
                          const SizedBox(width: 16),
                          _MiniStat(
                            label: 'Avg Hope',
                            value: '72%',
                            color: Colors.cyanAccent,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildStars() {
    final rng = math.Random(42);
    return List.generate(12, (i) {
      final x = rng.nextDouble();
      final y = rng.nextDouble();
      final size = rng.nextDouble() * 3 + 1;
      return Positioned(
        left: x * 400,
        top: y * 200,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: rng.nextDouble() * 0.4 + 0.1),
          ),
        ),
      );
    });
  }
}

class _MiniStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _MiniStat({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.5),
            fontSize: 9,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  TAB 1 — HOPE DASHBOARD (My Bets)
// ─────────────────────────────────────────────
class _HopeDashboardTab extends StatelessWidget {
  final bool isEmbedded;
  const _HopeDashboardTab({required this.isEmbedded});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;

    return ListView(
      physics: isEmbedded ? const NeverScrollableScrollPhysics() : null,
      shrinkWrap: isEmbedded,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      children: [
        // Overall hope meter
        _OverallHopeMeter(isDark: isDark, onSurface: onSurface),
        const SizedBox(height: 20),
        // Status filter chips
        _StatusFilterRow(isDark: isDark),
        const SizedBox(height: 16),
        // Bet cards
        ..._sampleBets.map(
          (bet) => _BetCard(bet: bet, isDark: isDark, onSurface: onSurface),
        ),
        const SizedBox(height: 8),
        // Add new bet prompt
        _AddBetPrompt(isDark: isDark, onSurface: onSurface),
      ],
    );
  }
}

class _OverallHopeMeter extends StatelessWidget {
  final bool isDark;
  final Color onSurface;
  const _OverallHopeMeter({required this.isDark, required this.onSurface});

  @override
  Widget build(BuildContext context) {
    // Average confidence of open bets
    final openBets = _sampleBets
        .where(
          (b) =>
              b.status != _HopeStatus.resolved &&
              b.status != _HopeStatus.archived,
        )
        .toList();
    final avg = openBets.isEmpty
        ? 0
        : openBets.map((b) => b.confidencePercent).reduce((a, b) => a + b) ~/
              openBets.length;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [const Color(0xFF1A0533), const Color(0xFF0D1B4A)]
              : [const Color(0xFF1A237E), const Color(0xFF283593)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.auto_awesome_rounded,
                color: Colors.amber,
                size: 18,
              ),
              const SizedBox(width: 8),
              const Text(
                'Overall Hope Index',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  letterSpacing: 0.5,
                ),
              ),
              const Spacer(),
              Text(
                '$avg%',
                style: const TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: avg / 100,
              minHeight: 10,
              backgroundColor: Colors.white.withValues(alpha: 0.12),
              valueColor: AlwaysStoppedAnimation<Color>(
                avg >= 70
                    ? Colors.greenAccent
                    : avg >= 40
                    ? Colors.amber
                    : Colors.redAccent,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${openBets.length} open bets',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 11,
                ),
              ),
              Text(
                avg >= 70
                    ? '🌟 Looking bright!'
                    : avg >= 40
                    ? '🤞 Hang in there'
                    : '💪 Stay strong',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusFilterRow extends StatelessWidget {
  final bool isDark;
  const _StatusFilterRow({required this.isDark});

  @override
  Widget build(BuildContext context) {
    const statuses = [
      ('All', Colors.white, Icons.all_inclusive_rounded),
      ('Waiting', Color(0xFF00BCD4), Icons.hourglass_top_rounded),
      ('Hopeful', Color(0xFF7C4DFF), Icons.star_outline_rounded),
      ('Nervous', Color(0xFFFF9800), Icons.warning_amber_rounded),
      ('Resolved', Color(0xFF4CAF50), Icons.check_circle_outline_rounded),
    ];
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: statuses.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final (label, color, icon) = statuses[i];
          final isFirst = i == 0;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isFirst
                  ? Colors.amber.withValues(alpha: 0.15)
                  : (color).withValues(alpha: isDark ? 0.12 : 0.08),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isFirst
                    ? Colors.amber.withValues(alpha: 0.5)
                    : (color).withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, size: 13, color: isFirst ? Colors.amber : color),
                const SizedBox(width: 5),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: isFirst ? FontWeight.bold : FontWeight.normal,
                    color: isFirst ? Colors.amber : color,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _BetCard extends StatefulWidget {
  final _HopeBet bet;
  final bool isDark;
  final Color onSurface;
  const _BetCard({
    required this.bet,
    required this.isDark,
    required this.onSurface,
  });

  @override
  State<_BetCard> createState() => _BetCardState();
}

class _BetCardState extends State<_BetCard> {
  bool _expanded = false;

  Color get _statusColor {
    switch (widget.bet.status) {
      case _HopeStatus.hopeful:
        return const Color(0xFF7C4DFF);
      case _HopeStatus.waiting:
        return const Color(0xFF00BCD4);
      case _HopeStatus.nervous:
        return const Color(0xFFFF9800);
      case _HopeStatus.resolved:
        return const Color(0xFF4CAF50);
      case _HopeStatus.archived:
        return Colors.grey;
    }
  }

  String get _statusLabel {
    switch (widget.bet.status) {
      case _HopeStatus.hopeful:
        return '🌟 Hopeful';
      case _HopeStatus.waiting:
        return '⏳ Waiting';
      case _HopeStatus.nervous:
        return '😬 Nervous';
      case _HopeStatus.resolved:
        return '✅ Resolved';
      case _HopeStatus.archived:
        return '📦 Archived';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bet = widget.bet;
    final isDark = widget.isDark;
    final onSurface = widget.onSurface;

    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: isDark
              ? const Color(0xFF1E193B).withValues(alpha: 0.75)
              : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: bet.accent.withValues(alpha: isDark ? 0.3 : 0.2),
          ),
          boxShadow: isDark
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          color: bet.accent.withValues(alpha: 0.13),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(bet.icon, color: bet.accent, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              bet.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: onSurface,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 7,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: bet.accent.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    bet.category,
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: bet.accent,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  _statusLabel,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: _statusColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        _expanded
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        color: onSurface.withValues(alpha: 0.35),
                        size: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Confidence bar
                  Row(
                    children: [
                      Text(
                        'Hope: ${bet.confidencePercent}%',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: bet.accent,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            value: bet.confidencePercent / 100,
                            minHeight: 7,
                            backgroundColor: bet.accent.withValues(alpha: 0.12),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              bet.accent,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    bet.description,
                    style: TextStyle(
                      fontSize: 12.5,
                      color: onSurface.withValues(alpha: 0.65),
                      height: 1.4,
                    ),
                    maxLines: _expanded ? 10 : 2,
                    overflow: _expanded
                        ? TextOverflow.visible
                        : TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // Expanded details
            if (_expanded) ...[
              Divider(height: 1, color: bet.accent.withValues(alpha: 0.15)),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _DetailRow(
                      icon: Icons.calendar_today_outlined,
                      color: bet.accent,
                      label: 'Follow-Up',
                      value: bet.followUpDate,
                    ),
                    const SizedBox(height: 10),
                    _DetailRow(
                      icon: Icons.alt_route_outlined,
                      color: bet.accent,
                      label: 'Parallel Path',
                      value: bet.parallelPath,
                    ),
                    const SizedBox(height: 10),
                    _DetailRow(
                      icon: Icons.self_improvement_rounded,
                      color: bet.accent,
                      label: 'Emotional Note',
                      value: bet.emotionalNote,
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              Clipboard.setData(
                                ClipboardData(
                                  text: '${bet.title}: ${bet.description}',
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text('Copied to clipboard'),
                                  duration: const Duration(seconds: 1),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.copy_outlined,
                              size: 14,
                              color: bet.accent,
                            ),
                            label: Text(
                              'Copy',
                              style: TextStyle(fontSize: 12, color: bet.accent),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: bet.accent.withValues(alpha: 0.4),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.edit_outlined,
                              size: 14,
                              color: Colors.white,
                            ),
                            label: const Text(
                              'Update',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: bet.accent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String value;
  const _DetailRow({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 15, color: color),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label.toUpperCase(),
              style: TextStyle(
                fontSize: 9,
                letterSpacing: 1.2,
                color: onSurface.withValues(alpha: 0.45),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            SizedBox(
              width: MediaQuery.of(context).size.width - 120,
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 12.5,
                  color: onSurface.withValues(alpha: 0.75),
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _AddBetPrompt extends StatelessWidget {
  final bool isDark;
  final Color onSurface;
  const _AddBetPrompt({required this.isDark, required this.onSurface});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.04)
            : Colors.grey.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.amber.withValues(alpha: 0.25),
          style: BorderStyle.solid,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.amber.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.add_rounded, color: Colors.amber, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add a New Bet',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: onSurface,
                  ),
                ),
                Text(
                  'Log something you\'re waiting on and stay grounded while the answer is in the air.',
                  style: TextStyle(
                    fontSize: 11.5,
                    color: onSurface.withValues(alpha: 0.55),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right_rounded,
            color: onSurface.withValues(alpha: 0.3),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  TAB 2 — WAITING WISDOM (Quotes)
// ─────────────────────────────────────────────
class _WaitingWisdomTab extends StatefulWidget {
  final bool isEmbedded;
  const _WaitingWisdomTab({required this.isEmbedded});

  @override
  State<_WaitingWisdomTab> createState() => _WaitingWisdomTabState();
}

class _WaitingWisdomTabState extends State<_WaitingWisdomTab> {
  int _currentQuote = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;
    final quote = _hopeQuotes[_currentQuote];

    return ListView(
      physics: widget.isEmbedded ? const NeverScrollableScrollPhysics() : null,
      shrinkWrap: widget.isEmbedded,
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
      children: [
        // Featured quote card
        Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? [const Color(0xFF1A0533), const Color(0xFF0D1B4A)]
                  : [const Color(0xFF1A237E), const Color(0xFF4A148C)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              const Icon(
                Icons.format_quote_rounded,
                color: Colors.amber,
                size: 40,
              ),
              const SizedBox(height: 16),
              Text(
                '"${quote.text}"',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  height: 1.65,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.amber.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.amber.withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  '— ${quote.author}',
                  style: const TextStyle(
                    color: Colors.amber,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Dots
                  ...List.generate(
                    _hopeQuotes.length,
                    (i) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: i == _currentQuote ? 18 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: i == _currentQuote
                            ? Colors.amber
                            : Colors.white.withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton.icon(
                    onPressed: () => setState(
                      () => _currentQuote =
                          (_currentQuote - 1 + _hopeQuotes.length) %
                          _hopeQuotes.length,
                    ),
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      size: 14,
                      color: Colors.white70,
                    ),
                    label: const Text(
                      'Prev',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: Colors.white.withValues(alpha: 0.2),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () => setState(
                      () => _currentQuote =
                          (_currentQuote + 1) % _hopeQuotes.length,
                    ),
                    icon: const Icon(
                      Icons.arrow_forward_rounded,
                      size: 14,
                      color: Colors.black,
                    ),
                    label: const Text(
                      'Next',
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton.icon(
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(
                          text: '"${quote.text}" — ${quote.author}',
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Quote copied!'),
                          duration: const Duration(seconds: 1),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.copy_outlined,
                      size: 14,
                      color: Colors.white70,
                    ),
                    label: const Text(
                      'Copy',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: Colors.white.withValues(alpha: 0.2),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        // All quotes list
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: Colors.amber.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.format_list_bulleted_rounded,
                color: Colors.amber,
                size: 16,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'All Wisdom',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: onSurface,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ..._hopeQuotes.asMap().entries.map(
          (e) => GestureDetector(
            onTap: () => setState(() => _currentQuote = e.key),
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: e.key == _currentQuote
                    ? Colors.amber.withValues(alpha: isDark ? 0.12 : 0.08)
                    : (isDark
                          ? const Color(0xFF1E193B).withValues(alpha: 0.5)
                          : Colors.white),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: e.key == _currentQuote
                      ? Colors.amber.withValues(alpha: 0.4)
                      : onSurface.withValues(alpha: 0.08),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.format_quote_rounded,
                    color: e.key == _currentQuote
                        ? Colors.amber
                        : onSurface.withValues(alpha: 0.3),
                    size: 18,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e.value.text,
                          style: TextStyle(
                            fontSize: 12.5,
                            color: onSurface.withValues(alpha: 0.8),
                            height: 1.45,
                            fontStyle: FontStyle.italic,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '— ${e.value.author}',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.amber.withValues(alpha: 0.8),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Grounding practice card
        _GroundingCard(isDark: isDark, onSurface: onSurface),
      ],
    );
  }
}

class _GroundingCard extends StatelessWidget {
  final bool isDark;
  final Color onSurface;
  const _GroundingCard({required this.isDark, required this.onSurface});

  @override
  Widget build(BuildContext context) {
    const steps = [
      ('Name 5 things you can see right now.', Icons.visibility_outlined),
      ('Name 4 things you can physically feel.', Icons.touch_app_outlined),
      ('Name 3 things you can hear.', Icons.hearing_outlined),
      ('Name 2 things you can smell.', Icons.air_outlined),
      ('Name 1 thing you can taste.', Icons.restaurant_outlined),
    ];
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF9C27B0).withValues(alpha: isDark ? 0.12 : 0.07),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF9C27B0).withValues(alpha: 0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.self_improvement_rounded,
                color: Color(0xFF9C27B0),
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                '5-4-3-2-1 Grounding Exercise',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'When the wait feels overwhelming, try this quick grounding technique to return to the present moment.',
            style: TextStyle(
              fontSize: 11.5,
              color: onSurface.withValues(alpha: 0.6),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 14),
          ...steps.map(
            (s) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF9C27B0).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(s.$2, color: const Color(0xFF9C27B0), size: 14),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      s.$1,
                      style: TextStyle(
                        fontSize: 12.5,
                        color: onSurface.withValues(alpha: 0.75),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  TAB 3 — FEATURE GUIDE  (all original content)
// ─────────────────────────────────────────────
class _FeatureGuideTab extends StatelessWidget {
  final bool isEmbedded;
  const _FeatureGuideTab({required this.isEmbedded});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;

    return ListView(
      physics: isEmbedded ? const NeverScrollableScrollPhysics() : null,
      shrinkWrap: isEmbedded,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      children: [
        FingersAreCrossedBestView(isEmbedded: true),
        // Info banner
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.amber.withValues(alpha: isDark ? 0.1 : 0.07),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.info_outline_rounded,
                color: Colors.amber,
                size: 18,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Track pending outcomes and hopeful bets without losing agency or momentum. '
                  'Log what you\'re waiting on, set follow-up nudges, and stay grounded while the answer is still in the air.',
                  style: TextStyle(
                    fontSize: 12.5,
                    height: 1.5,
                    color: onSurface.withValues(alpha: 0.8),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Feature sections — all original content preserved
        ..._featureSections.map(
          (s) => _FeatureSectionCard(
            section: s,
            isDark: isDark,
            onSurface: onSurface,
          ),
        ),
        const SizedBox(height: 20),
        // Tips for healthy waiting
        _HealthyWaitingTips(isDark: isDark, onSurface: onSurface),
      ],
    );
  }
}

class _FeatureSectionCard extends StatelessWidget {
  final Map<String, dynamic> section;
  final bool isDark;
  final Color onSurface;
  const _FeatureSectionCard({
    required this.section,
    required this.isDark,
    required this.onSurface,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = section['color'] as Color;
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF1E193B).withValues(alpha: 0.7)
            : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: isDark ? 0.3 : 0.18)),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
      ),
      child: Theme(
        data: theme.copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          leading: Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.13),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(section['icon'] as IconData, color: color, size: 20),
          ),
          title: Text(
            section['title'] as String,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: onSurface,
            ),
          ),
          subtitle: Text(
            section['desc'] as String,
            style: TextStyle(
              fontSize: 11,
              color: onSurface.withValues(alpha: 0.55),
              height: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          iconColor: onSurface.withValues(alpha: 0.4),
          collapsedIconColor: onSurface.withValues(alpha: 0.35),
          children: (section['points'] as List<String>)
              .map(
                (p) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 6),
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          p,
                          style: TextStyle(
                            fontSize: 13,
                            color: onSurface.withValues(alpha: 0.75),
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class _HealthyWaitingTips extends StatelessWidget {
  final bool isDark;
  final Color onSurface;
  const _HealthyWaitingTips({required this.isDark, required this.onSurface});

  static const _tips = [
    (
      'Control what you can',
      'Focus your energy on actions within your reach. The outcome is not yours to control — your preparation and response are.',
      Icons.tune_rounded,
      Color(0xFF7C4DFF),
    ),
    (
      'Set a decision deadline',
      'Decide in advance: "If I haven\'t heard by [date], I will move forward with Plan B." This prevents indefinite waiting.',
      Icons.event_outlined,
      Color(0xFF00BCD4),
    ),
    (
      'Limit rumination windows',
      'Allow yourself 10 minutes a day to think about the pending outcome — then redirect. Rumination beyond that rarely helps.',
      Icons.timer_outlined,
      Color(0xFFFF9800),
    ),
    (
      'Celebrate the courage to try',
      'You put yourself out there. That alone is worth acknowledging, regardless of the outcome.',
      Icons.celebration_outlined,
      Color(0xFF4CAF50),
    ),
    (
      'Keep moving forward',
      'The best antidote to anxious waiting is purposeful action in other areas of your life. Keep building.',
      Icons.directions_run_rounded,
      Color(0xFFE91E63),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: Colors.amber.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.tips_and_updates_outlined,
                color: Colors.amber,
                size: 16,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Healthy Waiting Tips',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: onSurface,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ..._tips.map(
          (t) => Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isDark
                  ? const Color(0xFF1E193B).withValues(alpha: 0.5)
                  : Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: t.$4.withValues(alpha: 0.2)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: t.$4.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(t.$3, color: t.$4, size: 16),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.$1,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: onSurface,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        t.$2,
                        style: TextStyle(
                          fontSize: 12.5,
                          color: onSurface.withValues(alpha: 0.65),
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
