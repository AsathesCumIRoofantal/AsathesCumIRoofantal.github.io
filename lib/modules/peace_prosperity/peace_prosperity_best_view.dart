import 'package:flutter/material.dart';

/// DESIGN: Layered Horizon — full-bleed peacock gradient layers with flowing section dividers
class PeaceProsperityBestView extends StatelessWidget {
  const PeaceProsperityBestView({super.key});

  static const _teal = Color(0xFF0D9488);
  static const _sky = Color(0xFF0EA5E9);
  static const _gold = Color(0xFFD97706);
  static const _green = Color(0xFF059669);
  static const _violet = Color(0xFF7C3AED);
  static const _amber = Color(0xFFF59E0B);
  static const _bg = Color(0xFF020E0E);

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
            title: const Text('PEACE & PROSPERITY', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 12, color: Colors.white)),
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF003333), Color(0xFF00261A), Color(0xFF020E0E)], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                child: Stack(children: [
                  Positioned.fill(child: CustomPaint(painter: _WavePainter())),
                  Padding(padding: const EdgeInsets.fromLTRB(24, 80, 24, 24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.end, children: [
                    Text('PEACE • PROSPERITY • POSSIBILITY', style: TextStyle(color: _teal, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 2)),
                    const SizedBox(height: 8),
                    const Text('Peace and prosperity are not opposed — they are prerequisites for each other.', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900, height: 1.25)),
                  ])),
                ]),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
            sliver: SliverList(delegate: SliverChildListDelegate([
              _HorizonSection(color: _teal, icon: Icons.spa_rounded, title: 'The Inner Foundation', number: '01',
                  body: 'Lasting peace begins within. External conditions shift; inner stillness is a cultivated capacity that does not depend on circumstances. Meditation, reflection, and mental discipline are not luxuries — they are the infrastructure of consistent external peace-making.\n\nAIR\'s inner peace tracker logs your daily stillness practice and correlates it with your decision quality scores over time.'),
              _HorizonSection(color: _sky, icon: Icons.handshake_rounded, title: 'Peace as Practice', number: '02',
                  body: 'Peace is not the absence of conflict — it is the skilled management of conflict in ways that do not produce ongoing harm. Every conflict offers a choice: resolution that leaves both parties with dignity, or resolution that leaves one or both with grievance. The latter always compounds.\n\nConflict resolution skill is one of the most leverage-rich investments any individual, organisation, or community can make.'),
              _HorizonSection(color: _gold, icon: Icons.trending_up_rounded, title: 'Prosperity Architecture', number: '03',
                  body: 'Prosperity is a system property, not a personal achievement. Individual wealth in an impoverished community is fragile and defended at great cost. Shared prosperity — where the surrounding community is also rising — is self-reinforcing, lower cost to maintain, and far more durable.\n\nAIR\'s prosperity model tracks both personal wealth-building and community economic health indicators together.'),
              _HorizonSection(color: _green, icon: Icons.public_rounded, title: 'Peace as Infrastructure', number: '04',
                  body: 'Political and social peace is the invisible infrastructure that makes all economic activity possible. Every unit of prosperity is built on a foundation of peace — reliable contracts, safe transit, predictable legal systems, and the absence of organised violence. When that infrastructure degrades, prosperity follows it downward.'),
              _HorizonSection(color: _violet, icon: Icons.all_inclusive_rounded, title: 'The Peace-Prosperity Cycle', number: '05',
                  body: 'Peace enables prosperity; prosperity funds the institutions that maintain peace. This virtuous cycle has produced the most dramatic increases in human wellbeing in history — and its breakdown explains most of the worst episodes of human suffering. Protecting and extending this cycle is among the highest collective obligations.'),
              Container(
                padding: const EdgeInsets.all(20), margin: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(gradient: LinearGradient(colors: [_teal.withOpacity(0.12), _gold.withOpacity(0.06)]), borderRadius: BorderRadius.circular(18), border: Border.all(color: _teal.withOpacity(0.25))),
                child: Row(children: [
                  Icon(Icons.format_quote_rounded, color: _amber, size: 28), const SizedBox(width: 14),
                  const Expanded(child: Text('"Peace is not the absence of conflict, but the presence of creative alternatives for responding to conflict." — Dorothy Thompson', style: TextStyle(color: Colors.white, fontSize: 13, height: 1.45, fontStyle: FontStyle.italic))),
                ]),
              ),
            ])),
          ),
        ],
      ),
    );
  }
}

class _HorizonSection extends StatelessWidget {
  final Color color; final IconData icon; final String title, body, number;
  const _HorizonSection({required this.color, required this.icon, required this.title, required this.body, required this.number});
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(color: color.withOpacity(0.07), borderRadius: BorderRadius.circular(18), border: Border.all(color: color.withOpacity(0.18))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Text(number, style: TextStyle(color: color.withOpacity(0.35), fontSize: 32, fontWeight: FontWeight.w900, height: 1.0)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          Text(title, style: TextStyle(color: color, fontSize: 15, fontWeight: FontWeight.w900)),
        ])),
      ]),
      const SizedBox(height: 10),
      Text(body, style: const TextStyle(color: Colors.white60, fontSize: 12, height: 1.55)),
    ]),
  );
}

class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = const Color(0xFF0D9488).withOpacity(0.12)..style = PaintingStyle.fill;
    final path = Path()..moveTo(0, size.height * 0.6)..quadraticBezierTo(size.width * 0.3, size.height * 0.4, size.width * 0.6, size.height * 0.6)..quadraticBezierTo(size.width * 0.8, size.height * 0.75, size.width, size.height * 0.55)..lineTo(size.width, size.height)..lineTo(0, size.height)..close();
    canvas.drawPath(path, p);
  }
  @override bool shouldRepaint(_) => false;
}
