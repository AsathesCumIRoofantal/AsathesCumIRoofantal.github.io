import 'package:flutter/material.dart';

/// DESIGN: Mission Statement — bold editorial manifesto with impact statement cards
class AirsMissionBestView extends StatelessWidget {
  const AirsMissionBestView({super.key});

  static const _blue = Color(0xFF1D4ED8);
  static const _sky = Color(0xFF0EA5E9);
  static const _violet = Color(0xFF7C3AED);
  static const _teal = Color(0xFF0D9488);
  static const _amber = Color(0xFFF59E0B);
  static const _green = Color(0xFF10B981);
  static const _bg = Color(0xFF010510);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: _bg,
            foregroundColor: Colors.white,
            title: const Text('AIR MISSION', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 3, fontSize: 13, color: Colors.white)),
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF020830), Color(0xFF010518)], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                child: Stack(children: [
                  Positioned(right: -40, bottom: -40, child: Icon(Icons.rocket_launch_rounded, size: 250, color: _blue.withOpacity(0.05))),
                  Padding(padding: const EdgeInsets.fromLTRB(24, 80, 24, 24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.end, children: [
                    Text('OUR MISSION', style: TextStyle(color: _sky, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 3)),
                    const SizedBox(height: 8),
                    const Text('To compress all available human intelligence into a system that makes any person more capable of making the best possible decision in any moment.', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w900, height: 1.3)),
                  ])),
                ]),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
            sliver: SliverList(delegate: SliverChildListDelegate([
              // WHY section
              _Manifesto(num: 'WHY', color: _blue, title: 'The Problem We Are Solving',
                  body: 'The average person makes thousands of decisions each year with imperfect information, no systematic framework, and minimal feedback on outcomes. The cumulative cost of suboptimal decisions — across health, finance, relationships, and career — is immense. AIR exists to close this gap.'),
              _Manifesto(num: 'HOW', color: _sky, title: 'Our Approach',
                  body: 'We aggregate, organise, and present the most useful intelligence from every relevant domain — then make it accessible in the moment of decision, not just in the moment of study. Intelligence that only exists at reading time is half-useful. Intelligence at decision time changes outcomes.'),
              _Manifesto(num: 'WHAT', color: _teal, title: 'What We Build',
                  body: 'A living intelligence platform that grows with you — tracking your decisions, learning from your context, surfacing relevant knowledge when it matters most, and building a personalised intelligence layer that becomes more valuable with every interaction.'),
              _Manifesto(num: 'WHO', color: _violet, title: 'Who We Serve',
                  body: 'Any person who believes that the quality of their decisions determines the quality of their life — and who is willing to invest in building the systems that make better decisions more likely. We serve the 1% not of wealth, but of intentionality.'),
              const SizedBox(height: 20),
              // IMPACT PILLARS
              _SecHead('IMPACT PILLARS', _amber),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(child: _PillarBox(color: _blue, icon: Icons.school_rounded, title: 'Better\nDecisions', metric: '10x')),
                const SizedBox(width: 8),
                Expanded(child: _PillarBox(color: _teal, icon: Icons.people_rounded, title: 'More\nCapable', metric: '5x')),
                const SizedBox(width: 8),
                Expanded(child: _PillarBox(color: _green, icon: Icons.trending_up_rounded, title: 'Accelerated\nGrowth', metric: '3x')),
              ]),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(18), decoration: BoxDecoration(gradient: LinearGradient(colors: [_blue.withOpacity(0.10), _violet.withOpacity(0.07)]), borderRadius: BorderRadius.circular(18), border: Border.all(color: _blue.withOpacity(0.25))),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('OUR NORTH STAR', style: TextStyle(color: _amber, fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 2)),
                  const SizedBox(height: 10),
                  const Text('"A world where every person has access to the intelligence needed to make the decisions that serve their deepest values and most important goals — regardless of where they were born, what they could afford, or who they knew."', style: TextStyle(color: Colors.white, fontSize: 14, height: 1.55, fontStyle: FontStyle.italic, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                  Text('— The AIR Vision Statement', style: TextStyle(color: _sky, fontSize: 11, fontWeight: FontWeight.w700)),
                ]),
              ),
            ])),
          ),
        ],
      ),
    );
  }
}

class _Manifesto extends StatelessWidget {
  final String num, title, body; final Color color;
  const _Manifesto({required this.num, required this.color, required this.title, required this.body});
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: color.withOpacity(0.07), borderRadius: BorderRadius.circular(14), border: Border.all(color: color.withOpacity(0.2))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(num, style: TextStyle(color: color.withOpacity(0.5), fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 4)),
      const SizedBox(height: 4),
      Text(title, style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w900)),
      const SizedBox(height: 8),
      Text(body, style: const TextStyle(color: Colors.white60, fontSize: 12, height: 1.55)),
    ]),
  );
}

class _PillarBox extends StatelessWidget {
  final Color color; final IconData icon; final String title, metric;
  const _PillarBox({required this.color, required this.icon, required this.title, required this.metric});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(14), border: Border.all(color: color.withOpacity(0.2))),
    child: Column(children: [
      Icon(icon, color: color, size: 22),
      const SizedBox(height: 6),
      Text(metric, style: TextStyle(color: color, fontSize: 22, fontWeight: FontWeight.w900)),
      Text(title, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white54, fontSize: 9, height: 1.2)),
    ]),
  );
}

class _SecHead extends StatelessWidget {
  final String text; final Color color;
  const _SecHead(this.text, this.color);
  @override
  Widget build(BuildContext context) => Row(children: [Container(width: 3, height: 14, color: color), const SizedBox(width: 8), Text(text, style: TextStyle(color: color.withOpacity(0.85), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2))]);
}
