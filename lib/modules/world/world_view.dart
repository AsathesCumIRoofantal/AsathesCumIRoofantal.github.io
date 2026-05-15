import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'world_controller.dart';

class WorldView extends GetView<WorldController> {
  const WorldView({Key? key}) : super(key: key);

  static const _earth = Color(0xFF1D4ED8);
  static const _sky = Color(0xFF0EA5E9);
  static const _teal = Color(0xFF0D9488);
  static const _green = Color(0xFF10B981);
  static const _amber = Color(0xFFF59E0B);
  static const _red = Color(0xFFEF4444);
  static const _violet = Color(0xFF7C3AED);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;
    final bg = isDark ? const Color(0xFF01040E) : const Color(0xFFF0F4FF);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: onSurface,
        title: const Text('WORLD', style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold, fontSize: 14)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 16),
          child: Icon(Icons.public, color: _earth, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          _buildHeroHeader(context, isDark, onSurface),
          const SizedBox(height: 20),
          _buildSectionLabel('GLOBAL STATUS PANEL', Icons.travel_explore, _earth, onSurface),
          const SizedBox(height: 12),
          _buildGlobalPanel(context, isDark, onSurface),
          const SizedBox(height: 24),
          _buildSectionLabel('WORLD INTELLIGENCE TOOLS', Icons.explore_outlined, _sky, onSurface),
          const SizedBox(height: 12),
          _buildWorldCard(context, isDark, Icons.map_outlined, _earth, 'Regional Profiles',
              'Build structured profiles for every region relevant to your work — political climate, economic conditions, and key actors. '
              'Regional profiles give you the context needed to interpret news and assess risk without starting from scratch each time. '
              'Each profile includes a 5-point stability score updated monthly, a key-actor register, and a brief timeline of the last six significant events — enough context to brief any stakeholder in under 3 minutes.'),
          const SizedBox(height: 10),
          _buildWorldCard(context, isDark, Icons.crisis_alert, _red, 'Active Crises',
              'Track ongoing conflicts, humanitarian emergencies, and political crises with their current status and trajectory. '
              'Knowing which crises are escalating versus stabilising shapes everything from supply-chain decisions to travel safety. '
              'Crisis entries include a trajectory tag — escalating, stable, or de-escalating — updated weekly, enabling quick scanning without requiring a full briefing read for every monitored situation.'),
          const SizedBox(height: 10),
          _buildWorldCard(context, isDark, Icons.swap_horiz, _amber, 'Geopolitical Shifts',
              'Monitor changes in alliances, trade agreements, sanctions regimes, and power dynamics between major actors. '
              'Geopolitical shifts often move slowly until they move fast — early tracking prevents being caught off guard. '
              'Shift entries are linked to impact assessments for your specific context — so a change in sanctions affecting a region you operate in automatically surfaces a flag in your risk register.'),
          const SizedBox(height: 10),
          _buildWorldCard(context, isDark, Icons.explore_outlined, _green, 'Emerging Opportunities',
              'Identify regions or sectors where conditions are improving and new partnerships or investments may be viable. '
              'Opportunity mapping ensures you are not so focused on risk that you miss the moments when doors open. '
              'Opportunities are scored on three dimensions: timing (window open now vs. developing), fit (alignment with your current capabilities), and risk-adjusted upside — giving you a single comparable score across diverse opportunities.'),
          const SizedBox(height: 10),
          _buildWorldCard(context, isDark, Icons.travel_explore, _violet, 'Global Risk Register',
              'Maintain a register of macro risks — climate events, pandemic threats, financial contagion — and their potential impact on your work. '
              'A global risk register forces you to think beyond the immediate horizon and build appropriate buffers. '
              'Each risk entry includes a probability estimate, an impact severity rating, a trigger indicator (the signal that would confirm the risk is materialising), and a pre-planned response — making preparation actionable rather than theoretical.'),
          const SizedBox(height: 10),
          _buildWorldCard(context, isDark, Icons.account_balance_outlined, _teal, 'International Actors',
              'Profile the governments, multilateral bodies, NGOs, and corporations that shape the global environment you operate in. '
              'Understanding key actors — their interests, constraints, and relationships — is essential for effective global navigation. '
              'Actor profiles include interest maps (what they want), constraint maps (what limits them), and relationship maps (who they align with and who they oppose) — enabling you to anticipate their behaviour rather than just react to it.'),
          const SizedBox(height: 10),
          _buildWorldCard(context, isDark, Icons.timeline, _sky, 'World Events Timeline',
              'Maintain a chronological log of significant global events and their downstream effects on your context. '
              'A timeline makes it easy to see cause-and-effect chains and to brief others on how the world got to where it is. '
              'The timeline is tagged by domain — economic, military, political, environmental, technological — enabling filtered views for specific briefing needs without requiring manual curation each time.'),
          const SizedBox(height: 20),
          _buildWorldQuote(context, isDark, onSurface),
        ],
      ),
    );
  }

  Widget _buildHeroHeader(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [const Color(0xFF02061C), const Color(0xFF010310)],
            begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _earth.withOpacity(0.38)),
        boxShadow: [BoxShadow(color: _earth.withOpacity(0.14), blurRadius: 18)],
      ),
      child: Column(children: [
        Row(children: [
          Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(
            color: _earth.withOpacity(0.15), borderRadius: BorderRadius.circular(14)),
            child: const Icon(Icons.public, color: _sky, size: 28)),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('GLOBAL INTELLIGENCE', style: TextStyle(fontSize: 10, color: _sky, fontWeight: FontWeight.bold, letterSpacing: 2)),
            const SizedBox(height: 4),
            const Text('Maintain a clear-eyed view of global context — regions, active crises, and emerging opportunities at planetary scale — so you are never blindsided by macro shifts.',
                style: TextStyle(fontSize: 12, height: 1.4, color: Colors.white60)),
          ])),
        ]),
        const SizedBox(height: 16),
        Row(children: [
          _stat('12', 'Regions', _sky),
          const SizedBox(width: 16),
          _stat('4', 'Crises', _red),
          const SizedBox(width: 16),
          _stat('7', 'Opportunities', _green),
          const SizedBox(width: 16),
          _stat('HIGH', 'Alert Level', _amber),
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

  Widget _buildGlobalPanel(BuildContext context, bool isDark, Color onSurface) {
    final regions = [
      ('South Asia', 'Elevated', _amber),
      ('Middle East', 'High Tension', _red),
      ('Europe', 'Stable', _green),
      ('East Asia', 'Monitoring', _sky),
    ];
    return Column(children: regions.map((r) => Container(
      margin: const EdgeInsets.only(bottom: 7),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: r.$3.withOpacity(0.06), borderRadius: BorderRadius.circular(11),
        border: Border.all(color: r.$3.withOpacity(0.18)),
      ),
      child: Row(children: [
        const Icon(Icons.place_rounded, size: 14, color: Colors.white38),
        const SizedBox(width: 8),
        Expanded(child: Text(r.$1, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: onSurface))),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(color: r.$3.withOpacity(0.14), borderRadius: BorderRadius.circular(6)),
          child: Text(r.$2, style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: r.$3, letterSpacing: 0.5)),
        ),
      ]),
    )).toList());
  }

  Widget _buildWorldCard(BuildContext context, bool isDark, IconData icon, Color color, String title, String body) {
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

  Widget _buildWorldQuote(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [_earth.withOpacity(0.10), _teal.withOpacity(0.07)],
            begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _earth.withOpacity(0.20)),
      ),
      child: Row(children: [
        const Icon(Icons.format_quote_rounded, color: _sky, size: 28),
        const SizedBox(width: 12),
        Expanded(child: Text(
          '"Think globally, act locally." — David Brower',
          style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic, height: 1.4, color: onSurface),
        )),
      ]),
    );
  }
}
