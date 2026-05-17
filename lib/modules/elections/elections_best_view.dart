import 'package:flutter/material.dart';
import 'dart:math' as math;

/// DESIGN: Data Journalism — infographic-style election intelligence dashboard
class ElectionsBestView extends StatelessWidget {
  const ElectionsBestView({super.key});

  static const _blue = Color(0xFF1D4ED8);
  static const _red = Color(0xFFDC2626);
  static const _gold = Color(0xFFD97706);
  static const _green = Color(0xFF059669);
  static const _violet = Color(0xFF7C3AED);
  static const _sky = Color(0xFF0EA5E9);
  static const _bg = Color(0xFF030A1A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: const Text('ELECTIONS INTELLIGENCE', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 12, color: Colors.white)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 14), child: Icon(Icons.how_to_vote_rounded, color: _gold, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        children: [
          // BREAKING NEWS TICKER
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(color: _red.withOpacity(0.1), borderRadius: BorderRadius.circular(8), border: Border.all(color: _red.withOpacity(0.3))),
            child: Row(children: [
              Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: _red, borderRadius: BorderRadius.circular(4)), child: const Text('LIVE', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w900))),
              const SizedBox(width: 10),
              const Expanded(child: Text('Election monitoring active • 3 upcoming contests • Voter registration open', style: TextStyle(color: Colors.white70, fontSize: 11))),
            ]),
          ),
          // VOTE SHARE DONUT
          _SectionHead('CURRENT POLLING LANDSCAPE', _gold),
          const SizedBox(height: 12),
          Row(children: [
            SizedBox(width: 140, height: 140, child: CustomPaint(painter: _DonutPainter())),
            const SizedBox(width: 16),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _Legend('Party A', _blue, '34.2%'),
              _Legend('Party B', _red, '28.7%'),
              _Legend('Party C', _green, '18.4%'),
              _Legend('Others', Colors.white38, '18.7%'),
              const SizedBox(height: 8),
              Text('Sample: 12,840 voters\nMargin of error: ±2.1%', style: TextStyle(color: Colors.white38, fontSize: 9, height: 1.4)),
            ])),
          ]),
          const SizedBox(height: 20),
          // ELECTORAL MODULES
          _SectionHead('ELECTORAL INTELLIGENCE TOOLS', _blue),
          const SizedBox(height: 12),
          _ElecCard(color: _blue, icon: Icons.how_to_vote_rounded, title: 'Campaign Tracker',
              body: 'Monitor active campaigns — their stated policies, funding sources, messaging strategy, and target demographics. Cross-reference promises against track records to surface credibility gaps before election day.'),
          const SizedBox(height: 8),
          _ElecCard(color: _red, icon: Icons.people_rounded, title: 'Candidate Profiles',
              body: 'Structured profiles for every candidate: professional history, policy positions, voting record (if incumbent), declared assets, criminal background check status, and endorsement map.'),
          const SizedBox(height: 8),
          _ElecCard(color: _gold, icon: Icons.bar_chart_rounded, title: 'Poll Aggregator',
              body: 'Multiple polls combined using sample-size weighting and house-effect correction — a far more reliable picture than any single poll. Trend lines show movement over the last 90 days.'),
          const SizedBox(height: 8),
          _ElecCard(color: _violet, icon: Icons.map_rounded, title: 'Constituency Map',
              body: 'Granular constituency-level data: historical results, swing margin, key demographics, dominant industries, and current candidate ratings — all visualised on an interactive map.'),
          const SizedBox(height: 8),
          _ElecCard(color: _green, icon: Icons.fact_check_rounded, title: 'Promise Accountability',
              body: 'Track the promises made in previous elections and log their fulfilment status. The accountability register computes a promise-kept percentage for every incumbent — making past behaviour visible before the next vote.'),
          const SizedBox(height: 8),
          _ElecCard(color: _sky, icon: Icons.groups_rounded, title: 'Voter Engagement Log',
              body: 'Record your own civic participation — voter registration, constituency meetings attended, issues raised with representatives, and response received — building a personal accountability log of democratic engagement.'),
          const SizedBox(height: 20),
          // KEY STATS ROW
          _SectionHead('DEMOCRACY METRICS', _gold),
          const SizedBox(height: 12),
          GridView.count(crossAxisCount: 3, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisSpacing: 8, mainAxisSpacing: 8, childAspectRatio: 1.1,
            children: [
              _StatTile('67.4%', 'Voter\nTurnout', _blue),
              _StatTile('₹42B', 'Campaign\nSpend', _red),
              _StatTile('1,847', 'Candidates', _gold),
              _StatTile('543', 'Seats', _violet),
              _StatTile('34', 'Parties', _green),
              _StatTile('28%', 'Women\nCandidates', _sky),
            ]),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [_blue.withOpacity(0.08), _gold.withOpacity(0.05)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: _blue.withOpacity(0.18))),
            child: Row(children: [
              Icon(Icons.format_quote_rounded, color: _gold, size: 26), const SizedBox(width: 12),
              const Expanded(child: Text('"Democracy is not something you believe in or a place you hang your hat, but something you do." — Abbie Hoffman', style: TextStyle(color: Colors.white, fontSize: 12, height: 1.4, fontStyle: FontStyle.italic))),
            ]),
          ),
        ],
      ),
    );
  }
}

class _SectionHead extends StatelessWidget {
  final String text; final Color color;
  const _SectionHead(this.text, this.color);
  @override
  Widget build(BuildContext context) => Row(children: [Container(width: 3, height: 14, color: color), const SizedBox(width: 8), Text(text, style: TextStyle(color: color.withOpacity(0.85), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2))]);
}

class _DonutPainter extends CustomPainter {
  static const shares = [0.342, 0.287, 0.184, 0.187];
  static const colors = [Color(0xFF1D4ED8), Color(0xFFDC2626), Color(0xFF059669), Colors.white24];
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2; final cy = size.height / 2; final r = size.width / 2 - 8;
    double start = -math.pi / 2;
    for (int i = 0; i < shares.length; i++) {
      final sweep = shares[i] * 2 * math.pi;
      final p = Paint()..color = colors[i]..style = PaintingStyle.stroke..strokeWidth = 22..strokeCap = StrokeCap.butt;
      canvas.drawArc(Rect.fromCircle(center: Offset(cx, cy), radius: r), start, sweep - 0.05, false, p);
      start += sweep;
    }
    final textP = TextPainter(text: const TextSpan(text: 'LIVE\nPOLL', style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.w900, height: 1.2)), textDirection: TextDirection.ltr)..layout();
    textP.paint(canvas, Offset(cx - textP.width / 2, cy - textP.height / 2));
  }
  @override bool shouldRepaint(_) => false;
}

class _Legend extends StatelessWidget {
  final String label, pct; final Color color;
  const _Legend(this.label, this.color, this.pct);
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Row(children: [
    Container(width: 10, height: 10, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
    const SizedBox(width: 8),
    Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
    const Spacer(),
    Text(pct, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w800)),
  ]));
}

class _ElecCard extends StatelessWidget {
  final Color color; final IconData icon; final String title, body;
  const _ElecCard({required this.color, required this.icon, required this.title, required this.body});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: color.withOpacity(0.07), borderRadius: BorderRadius.circular(14), border: Border.all(color: color.withOpacity(0.2))),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(padding: const EdgeInsets.all(7), decoration: BoxDecoration(color: color.withOpacity(0.14), borderRadius: BorderRadius.circular(9)), child: Icon(icon, color: color, size: 16)),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.w700)),
        const SizedBox(height: 5),
        Text(body, style: const TextStyle(color: Colors.white54, fontSize: 11, height: 1.45)),
      ])),
    ]),
  );
}

class _StatTile extends StatelessWidget {
  final String value, label; final Color color;
  const _StatTile(this.value, this.label, this.color);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withOpacity(0.2))),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(value, textAlign: TextAlign.center, style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w900)),
      Text(label, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white38, fontSize: 8, height: 1.2)),
    ]),
  );
}
