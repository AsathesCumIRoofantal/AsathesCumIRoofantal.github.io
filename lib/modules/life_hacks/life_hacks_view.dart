import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'life_hacks_controller.dart';

class LifeHacksView extends GetView<LifeHacksController> {
  const LifeHacksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Life Hacks',
          style: TextStyle(
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
            color: onSurface,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: onSurface,
        iconTheme: IconThemeData(color: onSurface),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [theme.scaffoldBackgroundColor, theme.colorScheme.surface]
                : [theme.colorScheme.surface, theme.scaffoldBackgroundColor],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: [
              _buildHeader(context, isDark, onSurface),
              const SizedBox(height: 20),
              ..._sections.map(
                (s) => _buildSection(context, s, isDark, onSurface),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.orange.withOpacity(0.15),
            Colors.amber.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.orange.withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.tips_and_updates_outlined,
                  color: Colors.orange,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Life Hacks',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Practical shortcuts for busy learners',
                      style: TextStyle(
                        fontSize: 13,
                        color: onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'AIR curates battle-tested shortcuts and everyday efficiencies so busy learners reclaim time '
            'without sacrificing quality — small tweaks that compound into big gains over weeks.',
            style: TextStyle(
              fontSize: 14,
              color: onSurface.withOpacity(0.75),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    _Section section,
    bool isDark,
    Color onSurface,
  ) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: isDark
            ? theme.cardColor.withOpacity(0.35)
            : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.06)
              : theme.colorScheme.outline.withOpacity(0.12),
        ),
      ),
      child: Theme(
        data: theme.copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: section.color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(section.icon, color: section.color, size: 20),
          ),
          title: Text(
            section.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: onSurface,
            ),
          ),
          children: section.points
              .map((p) => _buildPoint(p, onSurface, section.color))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildPoint(String point, Color onSurface, Color accent) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              point,
              style: TextStyle(
                fontSize: 14,
                color: onSurface.withOpacity(0.75),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Section {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> points;
  const _Section({
    required this.title,
    required this.icon,
    required this.color,
    required this.points,
  });
}

final List<_Section> _sections = [
  _Section(
    title: 'Time Reclamation',
    icon: Icons.timer_outlined,
    color: Colors.orange,
    points: [
      'Apply time-blocking to protect deep-work hours — assign every hour a job the night before so mornings start with clarity.',
      'Use the two-minute rule: if a task takes less than two minutes, do it immediately rather than scheduling it.',
      'Batch similar tasks (emails, calls, admin) into dedicated slots to cut the hidden cost of context-switching.',
    ],
  ),
  _Section(
    title: 'Focus & Flow',
    icon: Icons.center_focus_strong_outlined,
    color: Colors.deepOrange,
    points: [
      'Set up a distraction-free environment — phone in another room, notifications off, a single browser tab open.',
      'Use the Pomodoro technique (25 min on, 5 min off) and track completed cycles in AIR to build a focus streak.',
      'Identify your peak cognitive hours and guard them for your hardest, highest-value work every day.',
    ],
  ),
  _Section(
    title: 'Learning Shortcuts',
    icon: Icons.bolt_outlined,
    color: Colors.amber,
    points: [
      'Use active recall instead of re-reading — close the book and write down everything you remember, then check.',
      'Apply spaced repetition: review material at increasing intervals (1 day, 3 days, 1 week) to lock it in long-term.',
      'Teach what you\'ve just learned to someone else or write a one-page summary — the gaps reveal themselves instantly.',
    ],
  ),
  _Section(
    title: 'Digital Declutter',
    icon: Icons.phonelink_erase_outlined,
    color: Colors.teal,
    points: [
      'Audit your app home screen monthly — keep only tools you use daily and move the rest to a secondary folder.',
      'Set up email filters and labels so your inbox shows only items that need a decision, not every notification.',
      'Use a single trusted task manager and capture everything there — a clear head beats a cluttered one every time.',
    ],
  ),
  _Section(
    title: 'Energy Management',
    icon: Icons.battery_charging_full_outlined,
    color: Colors.green,
    points: [
      'Treat sleep as a performance input — consistent 7-8 hours improves memory consolidation and decision quality.',
      'Schedule short movement breaks every 90 minutes to reset focus and prevent the afternoon energy crash.',
      'Front-load your most demanding tasks before lunch when willpower and glucose levels are naturally higher.',
    ],
  ),
  _Section(
    title: 'Financial Quick Wins',
    icon: Icons.savings_outlined,
    color: Colors.blue,
    points: [
      'Automate savings on payday so the money moves before you can spend it — pay yourself first, always.',
      'Do a monthly subscription audit: cancel anything you haven\'t used in 30 days and redirect that money.',
      'Use the 24-hour rule for non-essential purchases over a set threshold to eliminate impulse spending.',
    ],
  ),
  _Section(
    title: 'Relationship Efficiency',
    icon: Icons.handshake_outlined,
    color: Colors.purple,
    points: [
      'Send a brief weekly check-in message to three important contacts — it takes five minutes and keeps bonds warm.',
      'Prepare a clear agenda before any meeting and share it in advance so everyone arrives ready to decide.',
      'Say no to low-priority requests with a short, kind explanation — protecting your time respects theirs too.',
    ],
  ),
];
