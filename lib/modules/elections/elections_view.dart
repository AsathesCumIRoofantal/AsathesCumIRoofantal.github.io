import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'elections_controller.dart';

// ─────────────────────────────────────────────
//  ELECTIONS — UNIQUE CIVIC DESIGN (no shared template)
//  Palette inspired by ballot ink, parchment & democracy
// ─────────────────────────────────────────────
const _inkBlue = Color(0xFF0D47A1);
const _ballotNavy = Color(0xFF1A237E);
const _saffron = Color(0xFFFF6F00);
const _civicGreen = Color(0xFF2E7D32);
const _parchment = Color(0xFFFFF8E7);
const _stamp = Color(0xFFC62828);

class _Pillar {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color accent;
  final List<String> bullets;
  const _Pillar({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accent,
    required this.bullets,
  });
}

class _Milestone {
  final String phase;
  final String window;
  final String detail;
  final IconData icon;
  final Color color;
  const _Milestone({
    required this.phase,
    required this.window,
    required this.detail,
    required this.icon,
    required this.color,
  });
}

class _VoterRight {
  final String right;
  final String detail;
  final IconData icon;
  const _VoterRight({
    required this.right,
    required this.detail,
    required this.icon,
  });
}

class _Faq {
  final String q;
  final String a;
  const _Faq(this.q, this.a);
}

// ── Original 7 items preserved + expanded into pillars
const List<_Pillar> _pillars = [
  _Pillar(
    title: 'Candidate Profiles',
    subtitle:
        'Review structured profiles for each candidate including background, '
        'platform, and key positions. Profiles are sourced from official '
        'declarations and updated as new information is published.',
    icon: Icons.person,
    accent: _inkBlue,
    bullets: [
      'Verified educational and professional history',
      'Affidavit-based asset & criminal record disclosure',
      'Past voting record and parliamentary attendance',
      'Public statements indexed by topic and date',
    ],
  ),
  _Pillar(
    title: 'Election Timeline',
    subtitle:
        'Follow the full election calendar from nomination deadlines through '
        'to results certification. Key milestones are highlighted so voters '
        'and officials never miss a critical date.',
    icon: Icons.calendar_today,
    accent: _saffron,
    bullets: [
      'Notification & nomination filing windows',
      'Scrutiny, withdrawal and final candidate list',
      'Campaign silence period (last 48 hours)',
      'Polling day, counting day and certification',
    ],
  ),
  _Pillar(
    title: 'Voter Registration',
    subtitle:
        'Check registration status, find polling station details, and '
        'understand eligibility requirements. Step-by-step guidance helps '
        'first-time voters navigate the registration process confidently.',
    icon: Icons.app_registration,
    accent: _civicGreen,
    bullets: [
      'Eligibility checklist (age, citizenship, residency)',
      'Online Form 6 / Form 8 walkthrough',
      'Document checklist & photo guidelines',
      'Polling booth locator and EPIC download',
    ],
  ),
  _Pillar(
    title: 'Policy Comparisons',
    subtitle:
        'Compare candidate positions side by side across key policy areas '
        'relevant to your community. Objective comparisons are drawn '
        'directly from official manifestos and public statements.',
    icon: Icons.compare,
    accent: _ballotNavy,
    bullets: [
      'Side-by-side manifesto pledges',
      'Costing & feasibility annotations',
      'Evidence trail with source citations',
      'Filter by issue: jobs, health, climate, education',
    ],
  ),
  _Pillar(
    title: 'Voter Responsibilities',
    subtitle:
        'Understand your rights and obligations as a voter, including '
        'conduct at polling stations. Clear guidance on what is and is not '
        'permitted helps maintain the integrity of the process.',
    icon: Icons.verified_user,
    accent: _stamp,
    bullets: [
      'Do\'s and don\'ts inside the 100m booth radius',
      'Reporting bribery, intimidation or malpractice',
      'Assisted voting for elderly & differently-abled',
      'NOTA — when and how to use it',
    ],
  ),
  _Pillar(
    title: 'Results & Analysis',
    subtitle:
        'Access official election results as they are declared, broken down '
        'by constituency and candidate. Post-election analysis highlights '
        'turnout trends and shifts in voter sentiment.',
    icon: Icons.bar_chart,
    accent: _civicGreen,
    bullets: [
      'Live constituency-wise vote counts',
      'Turnout maps by booth and demographic',
      'Margin-of-victory and swing analysis',
      'VVPAT audit & EVM verification logs',
    ],
  ),
  _Pillar(
    title: 'Electoral Education',
    subtitle:
        'Explore articles, videos, and quizzes that explain how the '
        'electoral system works. Educational content is tailored to '
        'different literacy levels to maximise accessibility.',
    icon: Icons.school,
    accent: _saffron,
    bullets: [
      'How an election is run — explainer series',
      'Short-form video lessons (under 3 minutes)',
      'Quizzes for first-time voters',
      'Audio explainers in multiple languages',
    ],
  ),
];

// ── New extended content (additions, nothing removed)
const List<_Milestone> _timeline = [
  _Milestone(
    phase: 'Notification',
    window: 'Day 0',
    detail:
        'Election Commission issues the formal notification, opening the '
        'nomination window for candidates.',
    icon: Icons.campaign_outlined,
    color: _inkBlue,
  ),
  _Milestone(
    phase: 'Nominations',
    window: 'Day 1 – 7',
    detail:
        'Candidates file nomination papers with affidavits disclosing '
        'assets, liabilities and criminal cases (if any).',
    icon: Icons.assignment_ind_outlined,
    color: _saffron,
  ),
  _Milestone(
    phase: 'Scrutiny & Withdrawal',
    window: 'Day 8 – 10',
    detail:
        'Returning Officer scrutinises nominations. Candidates may '
        'withdraw within the prescribed window.',
    icon: Icons.fact_check_outlined,
    color: _civicGreen,
  ),
  _Milestone(
    phase: 'Campaign Period',
    window: 'Day 11 – 28',
    detail:
        'Open campaigning under the Model Code of Conduct. Expenditure '
        'monitored daily by ECI observers.',
    icon: Icons.record_voice_over_outlined,
    color: _ballotNavy,
  ),
  _Milestone(
    phase: 'Silence Period',
    window: 'Last 48 hours',
    detail:
        'No public campaigning, rallies or media advertising. Time for '
        'voters to reflect calmly.',
    icon: Icons.do_not_disturb_on_outlined,
    color: _stamp,
  ),
  _Milestone(
    phase: 'Polling Day',
    window: 'Day 30',
    detail:
        'Voters cast secret ballots on EVMs with VVPAT slips. Booths open '
        'typically from 7 AM to 6 PM.',
    icon: Icons.how_to_vote_outlined,
    color: _saffron,
  ),
  _Milestone(
    phase: 'Counting & Result',
    window: 'Day 33',
    detail:
        'Centralised, transparent counting. Returning Officer declares '
        'the duly elected candidate; certificate issued.',
    icon: Icons.emoji_events_outlined,
    color: _civicGreen,
  ),
];

const List<_VoterRight> _rights = [
  _VoterRight(
    right: 'Secret Ballot',
    detail:
        'Your vote is confidential. No one — not poll officials, party '
        'workers, or family — has the right to know your choice.',
    icon: Icons.lock_outline,
  ),
  _VoterRight(
    right: 'Right to Reject (NOTA)',
    detail:
        'If no candidate meets your standard, you may press NOTA — None '
        'Of The Above — at the bottom of the EVM.',
    icon: Icons.not_interested_outlined,
  ),
  _VoterRight(
    right: 'Assistance for Differently-Abled',
    detail:
        'Wheelchair access, Braille EVMs, sign language and a companion '
        'of choice are statutory entitlements.',
    icon: Icons.accessible_outlined,
  ),
  _VoterRight(
    right: 'Paid Holiday',
    detail:
        'Employees are entitled to a paid leave on polling day in their '
        'constituency. Employers withholding it face penalties.',
    icon: Icons.event_available_outlined,
  ),
  _VoterRight(
    right: 'Challenge a Vote',
    detail:
        'If you suspect impersonation, request a challenged-vote slip. '
        'A small deposit is refunded if your challenge is upheld.',
    icon: Icons.gavel_outlined,
  ),
  _VoterRight(
    right: 'Tendered Ballot',
    detail:
        'If someone has already voted in your name, you may cast a '
        'tendered ballot — a paper vote preserved for adjudication.',
    icon: Icons.receipt_long_outlined,
  ),
];

const List<_Faq> _faqs = [
  _Faq(
    'Do I need my voter ID card to vote?',
    'Your name on the electoral roll is what matters. If you do not have '
        'an EPIC, twelve alternative photo IDs (Aadhaar, passport, '
        'driving licence, PAN, etc.) are accepted.',
  ),
  _Faq(
    'Can I vote from a city different from my registration?',
    'Currently, you must vote at the booth where you are enrolled. '
        'Remote and postal voting pilots are being expanded for migrants '
        'and essential service workers.',
  ),
  _Faq(
    'What happens if my name is missing from the roll?',
    'You may file Form 6 online or at the BLO\'s office well before the '
        'cut-off. On polling day, raise it with the Presiding Officer — '
        'they will guide you to the appropriate remedy.',
  ),
  _Faq(
    'How is my vote kept anonymous on an EVM?',
    'The control unit only records the total per candidate, never the '
        'sequence. The VVPAT slip is dropped into a sealed box without '
        'any voter identifier.',
  ),
  _Faq(
    'What is a Model Code of Conduct violation?',
    'Hate speech, bribery, communal appeals, defacing public property '
        'and misuse of official machinery are all reportable. Use the '
        'cVIGIL app — complaints are time-stamped and geo-tagged.',
  ),
];

class ElectionsView extends GetView<ElectionsController> {
  const ElectionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0B0F1A) : _parchment,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context, isDark),
          SliverToBoxAdapter(child: _StatStrip(isDark: isDark)),
          SliverToBoxAdapter(
            child: _SectionHeading(
              label: 'CIVIC PILLARS',
              title: 'Seven foundations of an informed vote',
              color: _inkBlue,
              isDark: isDark,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            sliver: SliverList.builder(
              itemCount: _pillars.length,
              itemBuilder: (_, i) => _PillarCard(
                index: i,
                pillar: _pillars[i],
                isDark: isDark,
                onSurface: scheme.onSurface,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: _SectionHeading(
              label: 'JOURNEY',
              title: 'How an election unfolds, step by step',
              color: _saffron,
              isDark: isDark,
            ),
          ),
          SliverToBoxAdapter(child: _Timeline(isDark: isDark)),
          SliverToBoxAdapter(
            child: _SectionHeading(
              label: 'YOUR RIGHTS',
              title: 'Guarantees every voter must know',
              color: _civicGreen,
              isDark: isDark,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
            sliver: SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 260,
                mainAxisExtent: 168,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _rights.length,
              itemBuilder: (_, i) =>
                  _RightChip(item: _rights[i], isDark: isDark),
            ),
          ),
          SliverToBoxAdapter(
            child: _SectionHeading(
              label: 'POLLING DAY',
              title: 'A 6-step checklist before you leave home',
              color: _ballotNavy,
              isDark: isDark,
            ),
          ),
          SliverToBoxAdapter(child: _Checklist(isDark: isDark)),
          SliverToBoxAdapter(
            child: _SectionHeading(
              label: 'QUESTIONS, ANSWERED',
              title: 'Frequently asked by first-time voters',
              color: _stamp,
              isDark: isDark,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
            sliver: SliverList.builder(
              itemCount: _faqs.length,
              itemBuilder: (_, i) => _FaqTile(faq: _faqs[i], isDark: isDark),
            ),
          ),
          SliverToBoxAdapter(child: _Pledge(isDark: isDark)),
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, bool isDark) {
    return SliverAppBar(
      expandedHeight: 230,
      pinned: true,
      backgroundColor: isDark ? const Color(0xFF111827) : _ballotNavy,
      iconTheme: const IconThemeData(color: Colors.white),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 16, bottom: 14),
        title: const Text(
          'Elections',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 1.1,
          ),
        ),
        background: _BallotHeroBackground(isDark: isDark),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  HERO BACKGROUND — ballot box + ink stamp motif
// ─────────────────────────────────────────────
class _BallotHeroBackground extends StatelessWidget {
  final bool isDark;
  const _BallotHeroBackground({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? const [Color(0xFF0B1224), Color(0xFF1B1F3B)]
                  : const [_ballotNavy, _inkBlue],
            ),
          ),
        ),
        // Ink stamp circle
        Positioned(
          right: -40,
          top: -30,
          child: Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: _saffron.withValues(alpha: 0.35),
                width: 6,
              ),
            ),
          ),
        ),
        Positioned(
          right: 30,
          top: 36,
          child: Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: _saffron.withValues(alpha: 0.55),
                width: 3,
              ),
            ),
            child: const Center(
              child: Text(
                'VOTE',
                style: TextStyle(
                  color: _saffron,
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  letterSpacing: 4,
                ),
              ),
            ),
          ),
        ),
        // Subtitle copy
        Positioned(
          left: 16,
          right: 120,
          bottom: 56,
          child: Text(
            'Build election literacy by exploring candidate platforms, key '
            'timelines, and voter responsibilities. An informed electorate is '
            'the foundation of a healthy democratic process.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 11.5,
              height: 1.45,
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  STAT STRIP
// ─────────────────────────────────────────────
class _StatStrip extends StatelessWidget {
  final bool isDark;
  const _StatStrip({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final stats = [
      ('968M+', 'eligible voters', _saffron),
      ('1M+', 'polling stations', _civicGreen),
      ('2,800+', 'registered parties', _inkBlue),
      ('100%', 'EVM + VVPAT', _stamp),
    ];
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.04) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : _ballotNavy.withValues(alpha: 0.12),
        ),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: _ballotNavy.withValues(alpha: 0.06),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
      ),
      child: Row(
        children: [
          for (var i = 0; i < stats.length; i++) ...[
            Expanded(
              child: Column(
                children: [
                  Text(
                    stats[i].$1,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      color: stats[i].$3,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    stats[i].$2,
                    style: TextStyle(
                      fontSize: 9.5,
                      letterSpacing: 0.6,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            if (i != stats.length - 1)
              Container(
                width: 1,
                height: 32,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.08),
              ),
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  SECTION HEADING
// ─────────────────────────────────────────────
class _SectionHeading extends StatelessWidget {
  final String label;
  final String title;
  final Color color;
  final bool isDark;
  const _SectionHeading({
    required this.label,
    required this.title,
    required this.color,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 4,
            height: 36,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  PILLAR CARD — original 7 items, redesigned
// ─────────────────────────────────────────────
class _PillarCard extends StatefulWidget {
  final int index;
  final _Pillar pillar;
  final bool isDark;
  final Color onSurface;
  const _PillarCard({
    required this.index,
    required this.pillar,
    required this.isDark,
    required this.onSurface,
  });

  @override
  State<_PillarCard> createState() => _PillarCardState();
}

class _PillarCardState extends State<_PillarCard> {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.pillar;
    final isDark = widget.isDark;
    return GestureDetector(
      onTap: () => setState(() => _open = !_open),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF161B2C) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: p.accent.withValues(alpha: _open ? 0.5 : 0.18),
            width: _open ? 1.4 : 1,
          ),
          boxShadow: isDark
              ? null
              : [
                  BoxShadow(
                    color: p.accent.withValues(alpha: 0.08),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Number badge
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [p.accent, p.accent.withValues(alpha: 0.7)],
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Text(
                        (widget.index + 1).toString().padLeft(2, '0'),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(p.icon, size: 16, color: p.accent),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                p.title,
                                style: TextStyle(
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w800,
                                  color: widget.onSurface,
                                ),
                              ),
                            ),
                            AnimatedRotation(
                              turns: _open ? 0.5 : 0,
                              duration: const Duration(milliseconds: 220),
                              child: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: p.accent,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          p.subtitle,
                          style: TextStyle(
                            fontSize: 12.5,
                            height: 1.5,
                            color: widget.onSurface.withValues(alpha: 0.72),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (_open) ...[
              Container(
                height: 1,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                color: p.accent.withValues(alpha: 0.15),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'WHAT YOU\'LL FIND',
                      style: TextStyle(
                        fontSize: 9,
                        letterSpacing: 1.6,
                        fontWeight: FontWeight.w800,
                        color: p.accent,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...p.bullets.map(
                      (b) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 6, right: 10),
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: p.accent,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                b,
                                style: TextStyle(
                                  fontSize: 12.5,
                                  height: 1.45,
                                  color: widget.onSurface.withValues(
                                    alpha: 0.82,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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

// ─────────────────────────────────────────────
//  TIMELINE — vertical, alternating
// ─────────────────────────────────────────────
class _Timeline extends StatelessWidget {
  final bool isDark;
  const _Timeline({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: Column(
        children: [
          for (var i = 0; i < _timeline.length; i++)
            _TimelineRow(
              item: _timeline[i],
              isFirst: i == 0,
              isLast: i == _timeline.length - 1,
              isDark: isDark,
            ),
        ],
      ),
    );
  }
}

class _TimelineRow extends StatelessWidget {
  final _Milestone item;
  final bool isFirst;
  final bool isLast;
  final bool isDark;
  const _TimelineRow({
    required this.item,
    required this.isFirst,
    required this.isLast,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rail + dot
          SizedBox(
            width: 36,
            child: Column(
              children: [
                Container(
                  width: 2,
                  height: 6,
                  color: isFirst
                      ? Colors.transparent
                      : item.color.withValues(alpha: 0.35),
                ),
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: item.color,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: item.color.withValues(alpha: 0.35),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Icon(item.icon, size: 14, color: Colors.white),
                ),
                Expanded(
                  child: Container(
                    width: 2,
                    color: isLast
                        ? Colors.transparent
                        : item.color.withValues(alpha: 0.35),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.04)
                    : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: item.color.withValues(alpha: 0.25)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.phase,
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w800,
                            color: onSurface,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: item.color.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          item.window,
                          style: TextStyle(
                            color: item.color,
                            fontWeight: FontWeight.w800,
                            fontSize: 10.5,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.detail,
                    style: TextStyle(
                      fontSize: 12.5,
                      height: 1.5,
                      color: onSurface.withValues(alpha: 0.72),
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
//  RIGHT CHIP
// ─────────────────────────────────────────────
class _RightChip extends StatelessWidget {
  final _VoterRight item;
  final bool isDark;
  const _RightChip({required this.item, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF161B2C) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _civicGreen.withValues(alpha: 0.22)),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: _civicGreen.withValues(alpha: 0.07),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _civicGreen.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(item.icon, size: 16, color: _civicGreen),
          ),
          const SizedBox(height: 10),
          Text(
            item.right,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 13,
              color: onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: Text(
              item.detail,
              style: TextStyle(
                fontSize: 11.5,
                height: 1.4,
                color: onSurface.withValues(alpha: 0.7),
              ),
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  CHECKLIST
// ─────────────────────────────────────────────
class _Checklist extends StatelessWidget {
  final bool isDark;
  const _Checklist({required this.isDark});

  @override
  Widget build(BuildContext context) {
    const items = [
      'Confirm your name on the electoral roll (online or BLO)',
      'Carry your EPIC or any of the 12 approved photo IDs',
      'Check your booth address & timing on the ECI portal',
      'Avoid wearing any party symbols, colours, or insignia',
      'Switch off mobile phones inside the polling booth',
      'Verify the VVPAT slip matches your chosen candidate',
    ];
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? const [Color(0xFF1B2240), Color(0xFF111827)]
              : [
                  _ballotNavy.withValues(alpha: 0.04),
                  _inkBlue.withValues(alpha: 0.08),
                ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _ballotNavy.withValues(alpha: 0.22)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < items.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: _ballotNavy,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      items[i],
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.45,
                        color: onSurface.withValues(alpha: 0.85),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  FAQ
// ─────────────────────────────────────────────
class _FaqTile extends StatefulWidget {
  final _Faq faq;
  final bool isDark;
  const _FaqTile({required this.faq, required this.isDark});
  @override
  State<_FaqTile> createState() => _FaqTileState();
}

class _FaqTileState extends State<_FaqTile> {
  bool _open = false;
  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return GestureDetector(
      onTap: () => setState(() => _open = !_open),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: widget.isDark ? const Color(0xFF161B2C) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _stamp.withValues(alpha: _open ? 0.45 : 0.18),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: _stamp.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Q',
                    style: TextStyle(
                      color: _stamp,
                      fontWeight: FontWeight.w900,
                      fontSize: 11,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.faq.q,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: onSurface,
                    ),
                  ),
                ),
                AnimatedRotation(
                  turns: _open ? 0.5 : 0,
                  duration: const Duration(milliseconds: 180),
                  child: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: _stamp,
                  ),
                ),
              ],
            ),
            if (_open) ...[
              const SizedBox(height: 10),
              Text(
                widget.faq.a,
                style: TextStyle(
                  fontSize: 12.5,
                  height: 1.55,
                  color: onSurface.withValues(alpha: 0.78),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  PLEDGE BANNER
// ─────────────────────────────────────────────
class _Pledge extends StatelessWidget {
  final bool isDark;
  const _Pledge({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_saffron, _stamp],
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.front_hand_outlined, color: Colors.white, size: 22),
              SizedBox(width: 10),
              Text(
                'THE VOTER\'S PLEDGE',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            '"We, the citizens of this nation, pledge to uphold the democratic '
            'traditions of our country and the dignity of free, fair and '
            'peaceful elections — and to vote in every election fearlessly '
            'and without being influenced by considerations of religion, '
            'race, caste, community, language or inducement."',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.5,
              height: 1.55,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
