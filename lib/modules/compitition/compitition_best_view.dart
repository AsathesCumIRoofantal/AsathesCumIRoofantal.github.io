import 'package:flutter/material.dart';

/// DESIGN: Leaderboard/Scoreboard — sports-style competitive standings with match cards
class CompititionBestView extends StatelessWidget {
  const CompititionBestView({super.key});

  static const _gold = Color(0xFFD4A853);
  static const _silver = Color(0xFF94A3B8);
  static const _bronze = Color(0xFFB45309);
  static const _blue = Color(0xFF2563EB);
  static const _green = Color(0xFF10B981);
  static const _red = Color(0xFFEF4444);
  static const _violet = Color(0xFF7C3AED);
  static const _amber = Color(0xFFF59E0B);
  static const _bg = Color(0xFF030508);

  @override
  Widget build(BuildContext context) {
    final leaders = [
      _Leader(rank: 1, name: 'Team Alpha', score: 2847, change: '+124', color: _gold, icon: Icons.emoji_events_rounded),
      _Leader(rank: 2, name: 'Team Beta', score: 2720, change: '+87', color: _silver, icon: Icons.emoji_events_rounded),
      _Leader(rank: 3, name: 'Team Gamma', score: 2688, change: '-12', color: _bronze, icon: Icons.emoji_events_rounded),
      _Leader(rank: 4, name: 'Team Delta', score: 2540, change: '+45', color: _blue, icon: Icons.people_rounded),
      _Leader(rank: 5, name: 'Team Epsilon', score: 2480, change: '+62', color: _violet, icon: Icons.people_rounded),
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: const Text('COMPETITION ARENA', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 13, color: Colors.white)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 14), child: Icon(Icons.sports_score_rounded, color: _gold, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        children: [
          // MATCH BANNER
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(
              gradient: LinearGradient(colors: [const Color(0xFF0A0820), const Color(0xFF04040E)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(20), border: Border.all(color: _gold.withOpacity(0.3)),
            ),
            child: Column(children: [
              Text('COMPETITION INTELLIGENCE', style: TextStyle(color: _gold, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 2)),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(child: _MatchSide('You', 'Player', _blue)),
                Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: _gold.withOpacity(0.1), borderRadius: BorderRadius.circular(8), border: Border.all(color: _gold.withOpacity(0.3))), child: Text('VS', style: TextStyle(color: _gold, fontSize: 16, fontWeight: FontWeight.w900))),
                Expanded(child: _MatchSide('World', 'Competition', _red)),
              ]),
            ]),
          ),
          const SizedBox(height: 20),
          // LEADERBOARD
          _SecHead('LIVE LEADERBOARD', _gold),
          const SizedBox(height: 12),
          ...leaders.map((l) => _LeaderCard(l: l)),
          const SizedBox(height: 20),
          // COMPETITION TOOLS
          _SecHead('COMPETITION INTELLIGENCE', _blue),
          const SizedBox(height: 12),
          _CompCard(color: _blue, icon: Icons.analytics_rounded, title: 'Competitive Analysis Framework',
              body: 'Systematic analysis of competitors across capability, positioning, pricing, customer experience, and strategic direction. Identifying competitive gaps before they become competitive threats is the primary purpose.'),
          const SizedBox(height: 8),
          _CompCard(color: _green, icon: Icons.track_changes_rounded, title: 'Win/Loss Analysis',
              body: 'Document every competitive win and loss with the same rigour — who won, what drove the outcome, what could have been done differently. Win/loss analysis is the fastest learning loop in competitive environments.'),
          const SizedBox(height: 8),
          _CompCard(color: _violet, icon: Icons.psychology_rounded, title: 'Competitive Psychology',
              body: 'The mental game of competition: managing pre-competition anxiety, maintaining focus under pressure, recovering from setbacks mid-competition, and performing at peak when the stakes are highest. These are learnable skills.'),
          const SizedBox(height: 8),
          _CompCard(color: _amber, icon: Icons.sports_rounded, title: 'Fair Play Standards',
              body: 'Competition that compromises integrity is competition that hollows out the competitor. Winning through rule-breaking, sabotage, or deception produces wins that cannot be internalised as genuine achievements. Fair play is not naive — it is the preservation of the competitive system itself.'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [_gold.withOpacity(0.08), _blue.withOpacity(0.05)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: _gold.withOpacity(0.18))),
            child: Row(children: [
              Icon(Icons.format_quote_rounded, color: _amber, size: 26), const SizedBox(width: 12),
              const Expanded(child: Text('"Competition makes us faster; collaboration makes us better." — Fyrefly', style: TextStyle(color: Colors.white, fontSize: 12, height: 1.4, fontStyle: FontStyle.italic))),
            ]),
          ),
        ],
      ),
    );
  }
}

class _Leader {
  final int rank; final String name, change; final int score; final Color color; final IconData icon;
  const _Leader({required this.rank, required this.name, required this.score, required this.change, required this.color, required this.icon});
}

class _LeaderCard extends StatelessWidget {
  final _Leader l;
  const _LeaderCard({required this.l});
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 6),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: BoxDecoration(color: l.color.withOpacity(0.07), borderRadius: BorderRadius.circular(12), border: Border.all(color: l.color.withOpacity(l.rank <= 3 ? 0.3 : 0.15))),
    child: Row(children: [
      Container(width: 32, height: 32, decoration: BoxDecoration(shape: BoxShape.circle, color: l.color.withOpacity(0.15)), child: Center(child: l.rank <= 3 ? Icon(l.icon, color: l.color, size: 16) : Text('${l.rank}', style: TextStyle(color: l.color, fontSize: 12, fontWeight: FontWeight.w900)))),
      const SizedBox(width: 12),
      Expanded(child: Text(l.name, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700))),
      Text('${l.score}', style: TextStyle(color: l.color, fontSize: 14, fontWeight: FontWeight.w900)),
      const SizedBox(width: 10),
      Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: l.change.startsWith('+') ? const Color(0xFF10B981).withOpacity(0.1) : const Color(0xFFEF4444).withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
        child: Text(l.change, style: TextStyle(color: l.change.startsWith('+') ? const Color(0xFF10B981) : const Color(0xFFEF4444), fontSize: 9, fontWeight: FontWeight.w700))),
    ]),
  );
}

class _MatchSide extends StatelessWidget {
  final String name, role; final Color color;
  const _MatchSide(this.name, this.role, this.color);
  @override
  Widget build(BuildContext context) => Column(children: [
    Container(width: 44, height: 44, decoration: BoxDecoration(shape: BoxShape.circle, color: color.withOpacity(0.15), border: Border.all(color: color.withOpacity(0.3))), child: Center(child: Icon(Icons.person_rounded, color: color, size: 24))),
    const SizedBox(height: 6),
    Text(name, style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.w900)),
    Text(role, style: const TextStyle(color: Colors.white38, fontSize: 9)),
  ]);
}

class _SecHead extends StatelessWidget {
  final String text; final Color color;
  const _SecHead(this.text, this.color);
  @override
  Widget build(BuildContext context) => Row(children: [Container(width: 3, height: 14, color: color), const SizedBox(width: 8), Text(text, style: TextStyle(color: color.withOpacity(0.85), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2))]);
}

class _CompCard extends StatelessWidget {
  final Color color; final IconData icon; final String title, body;
  const _CompCard({required this.color, required this.icon, required this.title, required this.body});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(13), decoration: BoxDecoration(color: color.withOpacity(0.07), borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withOpacity(0.18))),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(padding: const EdgeInsets.all(7), decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(9)), child: Icon(icon, color: color, size: 15)),
      const SizedBox(width: 10),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w800)),
        const SizedBox(height: 4),
        Text(body, style: const TextStyle(color: Colors.white54, fontSize: 11, height: 1.4)),
      ])),
    ]),
  );
}
