import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'peace_prosperity_controller.dart';

class PeaceProsperityView extends GetView<PeaceProsperityController> {
  const PeaceProsperityView({super.key});

  static const _sage = Color(0xFF16A34A);
  static const _sky = Color(0xFF0EA5E9);
  static const _teal = Color(0xFF0D9488);
  static const _green = Color(0xFF10B981);
  static const _amber = Color(0xFFF59E0B);
  static const _violet = Color(0xFF7C3AED);
  static const _red = Color(0xFFEF4444);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;
    final bg = isDark ? const Color(0xFF020A05) : const Color(0xFFF0FDF4);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: onSurface,
        title: const Text('PEACE & PROSPERITY', style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold, fontSize: 13)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 16),
          child: Icon(Icons.spa_outlined, color: _sage, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          _buildHeroHeader(context, isDark, onSurface),
          const SizedBox(height: 20),
          _buildSectionLabel('PROSPERITY SCORECARD', Icons.leaderboard_outlined, _sage, onSurface),
          const SizedBox(height: 12),
          _buildScorecard(context, isDark, onSurface),
          const SizedBox(height: 24),
          _buildSectionLabel('WELLBEING INDICATORS', Icons.show_chart_rounded, _teal, onSurface),
          const SizedBox(height: 12),
          _buildCard(context, isDark, Icons.shield_outlined, _sky, 'Safety Index',
              'Track indicators of physical and psychological safety across the communities you serve or belong to. '
              'Safety is the foundation of prosperity; without it, every other indicator is fragile. '
              'Safety index components include: personal safety (crime rates, incidents), institutional safety (rule of law, fair enforcement), and psychological safety (freedom to speak, assemble, and dissent) — each tracked separately because they can diverge significantly.'),
          const SizedBox(height: 10),
          _buildCard(context, isDark, Icons.attach_money, _sage, 'Economic Wellbeing',
              'Measure income distribution, employment rates, and access to basic needs rather than aggregate wealth alone. '
              'Prosperity that reaches the bottom of the distribution is more durable than prosperity concentrated at the top. '
              'The economic wellbeing dashboard uses a Gini coefficient alongside per-capita income to give a more complete picture — a society can have high average income and severe inequality simultaneously, and conflating the two obscures the real state of wellbeing.'),
          const SizedBox(height: 10),
          _buildCard(context, isDark, Icons.diversity_2, _teal, 'Social Cohesion',
              'Assess trust levels, civic participation, and the strength of community bonds through qualitative and quantitative signals. '
              'High social cohesion predicts resilience during crises and reduces the cost of governance. '
              'Cohesion surveys run every six months with a consistent sample population so year-on-year trends are comparable — the trend matters as much as the absolute score, since declining cohesion is an early warning regardless of current level.'),
          const SizedBox(height: 10),
          _buildCard(context, isDark, Icons.warning_outlined, _red, 'Conflict Early Warning',
              'Monitor tension indicators — grievance levels, resource scarcity, and political polarisation — before they escalate. '
              'Early warning gives communities and leaders time to address root causes rather than manage consequences. '
              'The warning system uses a traffic-light model: green (stable), amber (concerning trend), red (active risk) — with automatic escalation protocols triggered at amber so response begins before the situation reaches red.'),
          const SizedBox(height: 10),
          _buildCard(context, isDark, Icons.open_in_new, _violet, 'Opportunity Access',
              'Track whether education, healthcare, legal recourse, and economic opportunity are equitably distributed. '
              'Unequal access to opportunity is one of the most reliable predictors of future instability. '
              'Opportunity access is measured at the intersection of geography, income quintile, and demographic group — disaggregation reveals the specific populations being left behind that aggregate statistics conceal.'),
          const SizedBox(height: 10),
          _buildCard(context, isDark, Icons.handshake_outlined, _green, 'Reconciliation Tracker',
              'Log active reconciliation processes, their participants, milestones reached, and outstanding grievances. '
              'Structured reconciliation tracking prevents peace processes from stalling quietly without anyone noticing. '
              'Each reconciliation process has a designated facilitator, a stated timeline, agreed milestones, and an escalation path if talks stall — giving every process the structural support that informal goodwill cannot reliably provide alone.'),
          const SizedBox(height: 10),
          _buildCard(context, isDark, Icons.leaderboard_outlined, _amber, 'Prosperity Scorecard',
              'Aggregate all indicators into a single scorecard that shows overall community health at a glance. '
              'The scorecard is designed to be shared publicly, building accountability and community ownership of outcomes. '
              'Scorecards are published on a quarterly cadence with both the current scores and the trend direction for each component — empowering community members to hold institutions accountable with evidence rather than impressions.'),
          const SizedBox(height: 20),
          _buildPeaceQuote(context, isDark, onSurface),
        ],
      ),
    );
  }

  Widget _buildHeroHeader(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [const Color(0xFF031A0A), const Color(0xFF020D05)],
            begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _sage.withOpacity(0.38)),
        boxShadow: [BoxShadow(color: _sage.withOpacity(0.12), blurRadius: 18)],
      ),
      child: Column(children: [
        Row(children: [
          Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(
            color: _sage.withOpacity(0.15), borderRadius: BorderRadius.circular(14)),
            child: const Icon(Icons.spa_outlined, color: _green, size: 28)),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('COMMUNITY WELLBEING', style: TextStyle(fontSize: 9, color: _green, fontWeight: FontWeight.bold, letterSpacing: 2)),
            const SizedBox(height: 4),
            const Text('Monitor community-level wellbeing through peace and prosperity indicators that go beyond GDP — surfacing the human signals that define a truly thriving community.',
                style: TextStyle(fontSize: 12, height: 1.4, color: Colors.white60)),
          ])),
        ]),
        const SizedBox(height: 16),
        Row(children: [
          _stat('7.4', 'Safety Index', _sky),
          const SizedBox(width: 16),
          _stat('68%', 'Cohesion', _teal),
          const SizedBox(width: 16),
          _stat('AMBER', 'Conflict Risk', _amber),
          const SizedBox(width: 16),
          _stat('71%', 'Opp. Access', _violet),
        ]),
      ]),
    );
  }

  Widget _stat(String v, String l, Color c) => Expanded(child: Column(children: [
    Text(v, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: c)),
    Text(l, textAlign: TextAlign.center, style: TextStyle(fontSize: 8, color: c.withOpacity(0.8), height: 1.2)),
  ]));

  Widget _buildSectionLabel(String title, IconData icon, Color color, Color onSurface) => Row(children: [
    Icon(icon, color: color, size: 16), const SizedBox(width: 8),
    Text(title, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 2, color: color)),
  ]);

  Widget _buildScorecard(BuildContext context, bool isDark, Color onSurface) {
    final indicators = [
      ('Safety', 0.74, _sky),
      ('Economic Wellbeing', 0.68, _sage),
      ('Social Cohesion', 0.68, _teal),
      ('Opportunity Access', 0.71, _violet),
    ];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.04) : Colors.black.withOpacity(0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _sage.withOpacity(0.14)),
      ),
      child: Column(children: indicators.map((i) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(i.$1, style: TextStyle(fontSize: 12, color: onSurface)),
            Text('${(i.$2 * 100).round()}%', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: i.$3)),
          ]),
          const SizedBox(height: 4),
          Stack(children: [
            Container(height: 5, decoration: BoxDecoration(color: Colors.white.withOpacity(0.07), borderRadius: BorderRadius.circular(3))),
            FractionallySizedBox(widthFactor: i.$2, child: Container(height: 5, decoration: BoxDecoration(
              color: i.$3, borderRadius: BorderRadius.circular(3)))),
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

  Widget _buildPeaceQuote(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [_sage.withOpacity(0.10), _sky.withOpacity(0.07)],
            begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _sage.withOpacity(0.20)),
      ),
      child: Row(children: [
        const Icon(Icons.format_quote_rounded, color: _amber, size: 28),
        const SizedBox(width: 12),
        Expanded(child: Text(
          '"Peace is not merely the absence of war but the presence of justice." — Martin Luther King Jr.',
          style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, height: 1.4, color: onSurface),
        )),
      ]),
    );
  }
}
