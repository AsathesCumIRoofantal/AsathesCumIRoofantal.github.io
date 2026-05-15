import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'revise_improve_controller.dart';

class ReviseImproveView extends GetView<ReviseImproveController> {
  const ReviseImproveView({super.key});

  static const _lime = Color(0xFF84CC16);
  static const _green = Color(0xFF10B981);
  static const _teal = Color(0xFF0D9488);
  static const _cyan = Color(0xFF06B6D4);
  static const _amber = Color(0xFFF59E0B);
  static const _violet = Color(0xFF7C3AED);
  static const _rose = Color(0xFFE11D48);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;
    final bg = isDark ? const Color(0xFF020A04) : const Color(0xFFF7FEF0);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: onSurface,
        title: const Text('REVISE & IMPROVE', style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold, fontSize: 13)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 16),
          child: Icon(Icons.auto_fix_high_rounded, color: _lime, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          _buildHeroHeader(context, isDark, onSurface),
          const SizedBox(height: 20),
          _buildSectionLabel('IMPROVEMENT BACKLOG', Icons.format_list_numbered_rounded, _lime, onSurface),
          const SizedBox(height: 12),
          _buildBacklogItems(context, isDark, onSurface),
          const SizedBox(height: 24),
          _buildSectionLabel('QUALITY TRENDS', Icons.trending_up_rounded, _green, onSurface),
          const SizedBox(height: 12),
          _buildTrendBars(context, isDark, onSurface),
          const SizedBox(height: 24),
          _buildSectionLabel('IMPROVEMENT TOOLS', Icons.build_rounded, _teal, onSurface),
          const SizedBox(height: 12),
          _buildImprovCard(context, isDark, Icons.loop_rounded, _lime, 'Cycle Retrospective',
              'After each processing cycle, run a structured retrospective to surface what worked, what did not, and what to change. '
              'Retrospective findings are converted into improvement tickets that feed directly into the next sprint. '
              'The retrospective template covers four quadrants: what we should start doing, what we should stop doing, what we should continue, and what we should do more of — ensuring both positive and negative signals are captured.'),
          const SizedBox(height: 10),
          _buildImprovCard(context, isDark, Icons.search_rounded, _cyan, 'Root Cause Analysis',
              'Dig into recurring errors or quality failures using structured five-why and fishbone analysis tools. '
              'Documented root causes prevent the same fix from being applied repeatedly without addressing the underlying issue. '
              'Root cause sessions are facilitated with a neutral facilitator role to prevent the analysis from being derailed by blame-seeking, keeping focus on system factors rather than individual performance.'),
          const SizedBox(height: 10),
          _buildImprovCard(context, isDark, Icons.science_rounded, _teal, 'Change Experiment Log',
              'Record every process tweak as a controlled experiment with a hypothesis, expected outcome, and measured result. '
              'The experiment log builds an institutional memory of what has been tried and what actually moved the needle. '
              'Experiments are time-boxed — each runs for exactly one cycle before being evaluated, preventing the common failure of implementing a change before accumulating enough data to assess its actual effect.'),
          const SizedBox(height: 10),
          _buildImprovCard(context, isDark, Icons.trending_up_rounded, _green, 'Quality Trend Charts',
              'Track error rates, rework volumes, and quality scores across successive cycles on a single timeline. '
              'Trend lines make it easy to confirm whether a recent change is having the intended positive effect. '
              'Trend charts include confidence intervals so you can distinguish between genuine improvement signals and statistical noise — preventing premature celebration of changes that have not yet produced enough data to confirm their impact.'),
          const SizedBox(height: 10),
          _buildImprovCard(context, isDark, Icons.inbox_rounded, _violet, 'Feedback Inbox',
              'Collect structured feedback from operators, clients, and automated monitors in one consolidated inbox. '
              'Each piece of feedback is triaged, tagged, and linked to the relevant process area for targeted action. '
              'The inbox includes a sentiment trend so you can see at a glance whether the overall feedback tone is improving, stable, or deteriorating — giving you early warning before individual feedback items accumulate into a pattern.'),
          const SizedBox(height: 10),
          _buildImprovCard(context, isDark, Icons.format_list_numbered_rounded, _amber, 'Improvement Backlog',
              'Maintain a prioritised list of all logged improvement ideas, ranked by impact and implementation effort. '
              'Each backlog item tracks its origin, owner, and current status so nothing gets lost between cycles. '
              'Backlog grooming happens at the start of every cycle — the top three items are selected for implementation, preventing the backlog from growing indefinitely without producing actual changes in process quality.'),
          const SizedBox(height: 20),
          _buildImprovementQuote(context, isDark, onSurface),
        ],
      ),
    );
  }

  Widget _buildHeroHeader(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [const Color(0xFF061A06), const Color(0xFF030C03)],
            begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _lime.withOpacity(0.35)),
        boxShadow: [BoxShadow(color: _green.withOpacity(0.10), blurRadius: 16)],
      ),
      child: Column(children: [
        Row(children: [
          Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(
            color: _lime.withOpacity(0.15), borderRadius: BorderRadius.circular(14)),
            child: const Icon(Icons.auto_fix_high_rounded, color: _lime, size: 28)),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('CONTINUOUS IMPROVEMENT', style: TextStyle(fontSize: 9, color: _lime, fontWeight: FontWeight.bold, letterSpacing: 2)),
            const SizedBox(height: 4),
            const Text('Inspect completed outputs, gather structured feedback, and tighten the next processing cycle with targeted refinements. Continuous improvement is a disciplined habit, not a one-off project.',
                style: TextStyle(fontSize: 12, height: 1.4, color: Colors.white60)),
          ])),
        ]),
        const SizedBox(height: 16),
        Row(children: [
          _stat('12', 'Backlog', _lime),
          const SizedBox(width: 16),
          _stat('4', 'Experiments', _cyan),
          const SizedBox(width: 16),
          _stat('+8%', 'Quality Δ', _green),
          const SizedBox(width: 16),
          _stat('3', 'Root Causes', _amber),
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

  Widget _buildBacklogItems(BuildContext context, bool isDark, Color onSurface) {
    final items = [
      ('Reduce validation error rate', 'HIGH', _rose),
      ('Automate weekly report generation', 'MED', _amber),
      ('Streamline escalation triggers', 'MED', _amber),
      ('Add feedback sentiment analysis', 'LOW', _cyan),
    ];
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.04) : Colors.black.withOpacity(0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _lime.withOpacity(0.14)),
      ),
      child: Column(children: items.asMap().entries.map((e) {
        final item = e.value;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            border: e.key < items.length - 1 ? Border(bottom: BorderSide(color: Colors.white.withOpacity(0.05))) : null,
          ),
          child: Row(children: [
            Text('${e.key + 1}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: _lime)),
            const SizedBox(width: 10),
            Expanded(child: Text(item.$1, style: TextStyle(fontSize: 12, color: onSurface))),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(color: item.$3.withOpacity(0.12), borderRadius: BorderRadius.circular(6)),
              child: Text(item.$2, style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: item.$3, letterSpacing: 1)),
            ),
          ]),
        );
      }).toList()),
    );
  }

  Widget _buildTrendBars(BuildContext context, bool isDark, Color onSurface) {
    final metrics = [
      ('Error Rate', 0.04, _rose, 'Down 3pp'),
      ('Quality Score', 0.91, _green, 'Up 8pp'),
      ('Rework Volume', 0.12, _amber, 'Down 5pp'),
    ];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.04) : Colors.black.withOpacity(0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _green.withOpacity(0.14)),
      ),
      child: Column(children: metrics.map((m) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(m.$1, style: TextStyle(fontSize: 12, color: onSurface)),
            Row(children: [
              Text(m.$4, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: m.$3)),
            ]),
          ]),
          const SizedBox(height: 4),
          Stack(children: [
            Container(height: 5, decoration: BoxDecoration(color: Colors.white.withOpacity(0.07), borderRadius: BorderRadius.circular(3))),
            FractionallySizedBox(widthFactor: m.$2, child: Container(height: 5, decoration: BoxDecoration(
              color: m.$3, borderRadius: BorderRadius.circular(3)))),
          ]),
        ]),
      )).toList()),
    );
  }

  Widget _buildImprovCard(BuildContext context, bool isDark, IconData icon, Color color, String title, String body) {
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

  Widget _buildImprovementQuote(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [_lime.withOpacity(0.10), _teal.withOpacity(0.07)],
            begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _lime.withOpacity(0.20)),
      ),
      child: Row(children: [
        const Icon(Icons.format_quote_rounded, color: _lime, size: 28),
        const SizedBox(width: 12),
        Expanded(child: Text(
          '"Continuous improvement is better than delayed perfection." — Mark Twain',
          style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic, height: 1.4, color: onSurface),
        )),
      ]),
    );
  }
}
