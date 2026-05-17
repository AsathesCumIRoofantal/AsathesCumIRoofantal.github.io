import 'package:flutter/material.dart';

/// DESIGN: Profile Card Deck — person-focused relationship cards with connection rings
class RelationshipsBestView extends StatelessWidget {
  const RelationshipsBestView({super.key});

  static const _rose = Color(0xFFF43F5E);
  static const _pink = Color(0xFFEC4899);
  static const _violet = Color(0xFF7C3AED);
  static const _teal = Color(0xFF0D9488);
  static const _amber = Color(0xFFF59E0B);
  static const _blue = Color(0xFF2563EB);
  static const _sky = Color(0xFF0EA5E9);
  static const _bg = Color(0xFF080010);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: const Text('RELATIONSHIPS', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 13, color: Colors.white)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 14), child: Icon(Icons.favorite_rounded, color: _rose, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        children: [
          // HERO
          Container(
            padding: const EdgeInsets.all(18), decoration: BoxDecoration(
              gradient: LinearGradient(colors: [const Color(0xFF1A0020), const Color(0xFF0A0010)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(20), border: Border.all(color: _rose.withOpacity(0.28)),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('RELATIONSHIP INTELLIGENCE', style: TextStyle(color: _rose, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 2)),
              const SizedBox(height: 8),
              const Text('Your most valuable asset is not your skills, knowledge, or money. It is the quality of your relationships.', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700, height: 1.3)),
              const SizedBox(height: 12),
              Row(children: [
                _QuickStat('28', 'Inner\nCircle', _rose),
                const SizedBox(width: 8),
                _QuickStat('147', 'Network', _pink),
                const SizedBox(width: 8),
                _QuickStat('94%', 'Trust\nScore', _violet),
                const SizedBox(width: 8),
                _QuickStat('7.4/10', 'Depth\nAvg', _teal),
              ]),
            ]),
          ),
          const SizedBox(height: 20),
          // RELATIONSHIP TIERS (Profile Cards)
          _SecHead('RELATIONSHIP TIERS', _rose),
          const SizedBox(height: 12),
          _TierCard(
            color: _rose, tierName: 'INTIMATE CIRCLE', count: '3–5 people',
            icon: Icons.favorite_rounded, depth: 5,
            desc: 'The people with whom you can be completely honest, who know your full story, and who would help you in any crisis without asking why. These relationships require the most investment and return the highest emotional value.'),
          const SizedBox(height: 10),
          _TierCard(
            color: _pink, tierName: 'CLOSE FRIENDS', count: '12–15 people',
            icon: Icons.people_rounded, depth: 4,
            desc: 'People you genuinely like, trust substantially, and interact with regularly. These relationships are the primary source of daily social satisfaction and peer accountability. They sustain motivation through mutual investment.'),
          const SizedBox(height: 10),
          _TierCard(
            color: _violet, tierName: 'ACTIVE NETWORK', count: '50–150 people',
            icon: Icons.hub_rounded, depth: 3,
            desc: 'Your extended community of professional colleagues, acquaintances, and associates you know well enough to call on. This tier provides opportunity, information, and cross-domain connection — it operates at lower emotional intensity but high strategic value.'),
          const SizedBox(height: 10),
          _TierCard(
            color: _blue, tierName: 'PASSIVE NETWORK', count: '500+ people',
            icon: Icons.language_rounded, depth: 2,
            desc: 'The extended reach of your reputation and visibility. These are people who know of you, have worked with you once, or follow your ideas. Maintaining this tier requires presence and consistency rather than individual investment.'),
          const SizedBox(height: 20),
          _SecHead('RELATIONSHIP PRINCIPLES', _teal),
          const SizedBox(height: 12),
          _RelCard(color: _teal, icon: Icons.trending_up_rounded, title: 'The Relationship Compound',
              body: 'Every investment in a relationship — a genuine check-in, a thoughtful introduction, a kept promise — compounds in trust and goodwill over time. Relationships treated as transactions deplete; relationships treated as investments appreciate.'),
          const SizedBox(height: 8),
          _RelCard(color: _amber, icon: Icons.balance_rounded, title: 'Reciprocity Architecture',
              body: 'Healthy relationships have rough reciprocity over time — not transactional exchange in every interaction, but a general balance of giving and receiving. Chronically one-directional relationships — where all energy flows in one direction — are unsustainable for both parties.'),
          const SizedBox(height: 8),
          _RelCard(color: _sky, icon: Icons.schedule_rounded, title: 'Maintenance Scheduling',
              body: 'Important relationships that are not actively maintained decay at a rate proportional to their importance. The most valuable relationships are the most easily neglected — because the trust is highest, absence feels less urgent. Schedule maintenance deliberately.'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [_rose.withOpacity(0.08), _violet.withOpacity(0.05)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: _rose.withOpacity(0.18))),
            child: Row(children: [
              Icon(Icons.format_quote_rounded, color: _amber, size: 26), const SizedBox(width: 12),
              const Expanded(child: Text('"The quality of your life is the quality of your relationships." — Tony Robbins', style: TextStyle(color: Colors.white, fontSize: 12, height: 1.4, fontStyle: FontStyle.italic))),
            ]),
          ),
        ],
      ),
    );
  }
}

class _QuickStat extends StatelessWidget {
  final String value, label; final Color color;
  const _QuickStat(this.value, this.label, this.color);
  @override
  Widget build(BuildContext context) => Expanded(child: Container(
    padding: const EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(8), border: Border.all(color: color.withOpacity(0.18))),
    child: Column(children: [
      Text(value, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w900)),
      Text(label, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white38, fontSize: 8, height: 1.2)),
    ]),
  ));
}

class _TierCard extends StatelessWidget {
  final Color color; final String tierName, count, desc; final IconData icon; final int depth;
  const _TierCard({required this.color, required this.tierName, required this.count, required this.desc, required this.icon, required this.depth});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: color.withOpacity(0.07), borderRadius: BorderRadius.circular(16), border: Border.all(color: color.withOpacity(0.22))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: color, size: 18)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(tierName, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1)),
          Text(count, style: TextStyle(color: color.withOpacity(0.7), fontSize: 10)),
        ])),
        Row(children: List.generate(5, (i) => Icon(Icons.circle, color: i < depth ? color : Colors.white12, size: 7))),
      ]),
      const SizedBox(height: 10),
      Text(desc, style: const TextStyle(color: Colors.white60, fontSize: 11, height: 1.5)),
    ]),
  );
}

class _SecHead extends StatelessWidget {
  final String text; final Color color;
  const _SecHead(this.text, this.color);
  @override
  Widget build(BuildContext context) => Row(children: [Container(width: 3, height: 14, color: color), const SizedBox(width: 8), Text(text, style: TextStyle(color: color.withOpacity(0.85), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2))]);
}

class _RelCard extends StatelessWidget {
  final Color color; final IconData icon; final String title, body;
  const _RelCard({required this.color, required this.icon, required this.title, required this.body});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: color.withOpacity(0.07), borderRadius: BorderRadius.circular(14), border: Border.all(color: color.withOpacity(0.2))),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(padding: const EdgeInsets.all(7), decoration: BoxDecoration(color: color.withOpacity(0.14), borderRadius: BorderRadius.circular(9)), child: Icon(icon, color: color, size: 16)),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.w700)),
        const SizedBox(height: 5),
        Text(body, style: const TextStyle(color: Colors.white60, fontSize: 11, height: 1.5)),
      ])),
    ]),
  );
}
