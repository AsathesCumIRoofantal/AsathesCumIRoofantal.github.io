import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'self_discipline_controller.dart';

class SelfDisciplineView extends GetView<SelfDisciplineController> {
  const SelfDisciplineView({super.key});

  static const _iron = Color(0xFF374151);
  static const _steel = Color(0xFF6B7280);
  static const _blue = Color(0xFF2563EB);
  static const _orange = Color(0xFFEA580C);
  static const _green = Color(0xFF10B981);
  static const _amber = Color(0xFFF59E0B);
  static const _red = Color(0xFFEF4444);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;
    final bg = isDark ? const Color(0xFF020305) : const Color(0xFFF9FAFB);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: onSurface,
        title: const Text('SELF DISCIPLINE', style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold, fontSize: 14)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 16),
          child: Icon(Icons.fitness_center_outlined, color: _orange, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          _buildHeroHeader(context, isDark, onSurface),
          const SizedBox(height: 20),
          _buildSectionLabel('ACTIVE STREAKS', Icons.local_fire_department_rounded, _orange, onSurface),
          const SizedBox(height: 12),
          _buildStreakPanel(context, isDark, onSurface),
          const SizedBox(height: 24),
          _buildSectionLabel('HABIT SYSTEM', Icons.stacked_line_chart_outlined, _blue, onSurface),
          const SizedBox(height: 12),
          _buildCard(context, isDark, Icons.stacked_line_chart_outlined, _blue, 'Habit Stack',
              'A habit stack is a sequence of behaviors anchored to a trigger. Define your morning, work, and evening stacks so discipline becomes automatic rather than a daily negotiation with yourself. '
              'Stack design follows the cue–routine–reward loop: the trigger is already-established behaviour, the new habit attaches to it, and the reward must be immediate for the stack to hold. '
              'AIR maintains your three core stacks — morning, deep-work, and evening — and sends gentle nudge reminders when your check-in log shows a gap of more than 36 hours.'),
          const SizedBox(height: 10),
          _buildCard(context, isDark, Icons.local_fire_department_outlined, _orange, 'Streak Tracker',
              'Streaks create momentum — breaking a 30-day run feels costly enough to keep you going. Log your active streaks for key habits and use the visual record as a commitment device. '
              'The streak tracker distinguishes between "perfect" and "good enough" streaks — missing a day breaks a perfect streak but not a good-enough streak, preventing the all-or-nothing collapse that kills most habit attempts. '
              'Streak data is graphed over time so you can see your personal best for each habit, giving you a concrete target to beat and a record of proven capability.'),
          const SizedBox(height: 10),
          _buildCard(context, isDark, Icons.gavel_outlined, _red, 'Consequence Design',
              'If breaking a commitment has no cost, it will be broken. Design meaningful consequences for your most important habits — a donation, a public declaration, a forfeit — and log them here. '
              'Effective consequences are pre-committed before the temptation to skip arises, specific enough to actually sting, and witnessed by at least one other person so the social cost is real. '
              'The consequence design tool helps you calibrate consequence size to habit importance — a high-stakes consequence attached to a low-stakes habit creates resentment, not discipline.'),
          const SizedBox(height: 10),
          _buildCard(context, isDark, Icons.block_outlined, _amber, 'Temptation Audit',
              'Discipline is easier when temptations are removed from the environment. Audit what pulls you off track — apps, environments, people — and log the friction you\'ve added to make slipping harder. '
              'Temptation removal is more reliable than willpower resistance — redesigning your environment to make the right behaviour the default requires effort once rather than willpower continuously. '
              'The audit prompts you to evaluate each temptation source by frequency and impact, helping you prioritise which friction additions will deliver the highest return on your discipline budget.'),
          const SizedBox(height: 10),
          _buildCard(context, isDark, Icons.restart_alt_outlined, _green, 'Recovery Protocol',
              'Missing once is an accident; missing twice is the start of a new habit. Define your recovery protocol — what you do the day after a slip — so a single failure doesn\'t cascade into abandonment. '
              'The protocol is designed to be executed in under 10 minutes: acknowledge the slip without self-punishment, re-state the commitment, and take one small action that re-establishes momentum. '
              'Recovery speed is tracked — users who define a protocol recover from slips 3× faster than those who rely on motivation alone to return to a habit after a break.'),
          const SizedBox(height: 10),
          _buildCard(context, isDark, Icons.battery_charging_full_outlined, _blue, 'Energy Management',
              'Discipline depletes with decision fatigue. Protect your highest-discipline hours for your hardest tasks and automate or batch low-stakes decisions to preserve your willpower budget. '
              'Energy mapping over one week reveals your personal peak, plateau, and trough windows — the schedule that matches demanding tasks to peak hours typically doubles daily output without adding time. '
              'Decision batching strategies include weekly meal planning, weekly wardrobe selection, and pre-committed default responses to recurring requests — each one preserves cognitive resources for things that actually matter.'),
          const SizedBox(height: 10),
          _buildCard(context, isDark, Icons.event_note_outlined, _orange, 'Weekly Review',
              'A weekly review closes the loop on your discipline system. Score each habit, note what worked and what didn\'t, and make one small adjustment to your system before the next week starts. '
              'The review takes 20 minutes and produces a single-sentence summary for each active habit — what the score was, what caused any slips, and the one specific change being made next week. '
              'Over 12 weeks of reviews, patterns emerge that reveal the root constraints on your discipline system — usually not laziness, but misaligned scheduling, unclear cues, or consequences that do not land.'),
          const SizedBox(height: 20),
          _buildDisciplineQuote(context, isDark, onSurface),
        ],
      ),
    );
  }

  Widget _buildHeroHeader(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [const Color(0xFF111827), const Color(0xFF060A10)],
            begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _orange.withOpacity(0.35)),
        boxShadow: [BoxShadow(color: _orange.withOpacity(0.10), blurRadius: 16)],
      ),
      child: Column(children: [
        Row(children: [
          Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(
            color: _orange.withOpacity(0.15), borderRadius: BorderRadius.circular(14)),
            child: const Icon(Icons.fitness_center_outlined, color: _orange, size: 28)),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('SYSTEMS, NOT WILLPOWER', style: TextStyle(fontSize: 9, color: _orange, fontWeight: FontWeight.bold, letterSpacing: 2)),
            const SizedBox(height: 4),
            const Text('Self-discipline in AIR is a systems problem, not a willpower problem. Design habits, track streaks, and build consequence structures that make the right behaviour the path of least resistance.',
                style: TextStyle(fontSize: 12, height: 1.4, color: Colors.white60)),
          ])),
        ]),
        const SizedBox(height: 16),
        Row(children: [
          _stat('7', 'Active Habits', _orange),
          const SizedBox(width: 16),
          _stat('23d', 'Best Streak', _amber),
          const SizedBox(width: 16),
          _stat('91%', 'This Month', _green),
          const SizedBox(width: 16),
          _stat('1', 'Slip Today', _red),
        ]),
      ]),
    );
  }

  Widget _stat(String v, String l, Color c) => Expanded(child: Column(children: [
    Text(v, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: c)),
    Text(l, textAlign: TextAlign.center, style: TextStyle(fontSize: 8, color: c.withOpacity(0.8), height: 1.2)),
  ]));

  Widget _buildSectionLabel(String title, IconData icon, Color color, Color onSurface) => Row(children: [
    Icon(icon, color: color, size: 16), const SizedBox(width: 8),
    Text(title, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 2, color: color)),
  ]);

  Widget _buildStreakPanel(BuildContext context, bool isDark, Color onSurface) {
    final habits = [
      ('Morning Stack', 23, 30, _orange, true),
      ('Deep Work', 11, 30, _blue, true),
      ('Exercise', 6, 30, _green, true),
      ('No Late Scroll', 3, 30, _amber, false),
    ];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.04) : Colors.black.withOpacity(0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _orange.withOpacity(0.14)),
      ),
      child: Column(children: habits.map((h) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Icon(h.$5 ? Icons.local_fire_department_rounded : Icons.warning_rounded,
                  color: h.$5 ? h.$4 : _red, size: 14),
              const SizedBox(width: 5),
              Text(h.$1, style: TextStyle(fontSize: 12, color: onSurface, fontWeight: FontWeight.w500)),
            ]),
            Text('${h.$2} / ${h.$3} days', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: h.$4)),
          ]),
          const SizedBox(height: 4),
          Stack(children: [
            Container(height: 5, decoration: BoxDecoration(color: Colors.white.withOpacity(0.07), borderRadius: BorderRadius.circular(3))),
            FractionallySizedBox(widthFactor: h.$2 / h.$3, child: Container(height: 5, decoration: BoxDecoration(
              color: h.$4, borderRadius: BorderRadius.circular(3),
              boxShadow: [BoxShadow(color: h.$4.withOpacity(0.30), blurRadius: 4)],
            ))),
          ]),
        ]),
      )).toList()),
    );
  }

  Widget _buildCard(BuildContext context, bool isDark, IconData icon, Color color, String title, String body) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06), borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.20)),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(
          color: color.withOpacity(0.14), borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: color, size: 18)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface)),
          const SizedBox(height: 6),
          Text(body, style: TextStyle(fontSize: 12, height: 1.5, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.72))),
        ])),
      ]),
    );
  }

  Widget _buildDisciplineQuote(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [_orange.withOpacity(0.10), _blue.withOpacity(0.07)],
            begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _orange.withOpacity(0.20)),
      ),
      child: Row(children: [
        const Icon(Icons.format_quote_rounded, color: _amber, size: 28),
        const SizedBox(width: 12),
        Expanded(child: Text(
          '"We are what we repeatedly do. Excellence, then, is not an act but a habit." — Aristotle',
          style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic, height: 1.4, color: onSurface),
        )),
      ]),
    );
  }
}
