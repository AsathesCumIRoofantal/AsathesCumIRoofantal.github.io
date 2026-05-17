import 'package:flutter/material.dart';

/// DESIGN: Values Compass — compass-rose layout with value cards radiating outward
class BeliefsValuesBestView extends StatelessWidget {
  const BeliefsValuesBestView({super.key});

  static const _gold = Color(0xFFD4A853);
  static const _amber = Color(0xFFF59E0B);
  static const _teal = Color(0xFF0D9488);
  static const _violet = Color(0xFF7C3AED);
  static const _sky = Color(0xFF0EA5E9);
  static const _green = Color(0xFF10B981);
  static const _rose = Color(0xFFF43F5E);
  static const _bg = Color(0xFF06040A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: const Text('BELIEFS & VALUES', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 13, color: Colors.white)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 14), child: Icon(Icons.explore_rounded, color: _gold, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        children: [
          // COMPASS HERO
          SizedBox(height: 220, child: Center(child: CustomPaint(painter: _CompassPainter(), size: const Size(200, 200)))),
          Center(child: Text('Your values are your compass — they determine direction when the map is unclear', style: TextStyle(color: _gold.withOpacity(0.7), fontSize: 11, fontStyle: FontStyle.italic, textAlign: TextAlign.center))),
          const SizedBox(height: 24),
          // VALUE CATEGORIES
          _SecHead('CORE VALUE FRAMEWORK', _gold),
          const SizedBox(height: 12),
          _ValueCard(color: _gold, icon: Icons.all_inclusive_rounded, title: 'Transcendent Values', category: 'Level 1',
              desc: 'Values that hold regardless of context or consequence — honesty, justice, dignity. These are the non-negotiables from which all other values derive their meaning. They do not bend under pressure; if they do, they were never genuinely held.'),
          const SizedBox(height: 8),
          _ValueCard(color: _teal, icon: Icons.business_rounded, title: 'Professional Values', category: 'Level 2',
              desc: 'Values that govern how you work — excellence, reliability, integrity, collaboration. These translate transcendent principles into operational behaviour. They determine how you act when no one is watching and when the deadline creates pressure to compromise.'),
          const SizedBox(height: 8),
          _ValueCard(color: _violet, icon: Icons.people_rounded, title: 'Relational Values', category: 'Level 3',
              desc: 'Values that govern how you relate — kindness, respect, loyalty, honesty. These determine the quality of connection you create in every interaction. Relational values, consistently expressed, become the foundation of your reputation and relationships.'),
          const SizedBox(height: 8),
          _ValueCard(color: _sky, icon: Icons.psychology_rounded, title: 'Personal Values', category: 'Level 4',
              desc: 'Values specific to your individual character and calling — courage, creativity, curiosity, discipline. These are what make your contribution distinctive. They are the values that, when suppressed, make you feel like you are living someone else\'s life.'),
          const SizedBox(height: 20),
          _SecHead('BELIEFS AUDIT', _violet),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: _violet.withOpacity(0.07), borderRadius: BorderRadius.circular(16), border: Border.all(color: _violet.withOpacity(0.2))),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('4 Questions for Every Belief', style: TextStyle(color: _violet, fontSize: 13, fontWeight: FontWeight.w800)),
              const SizedBox(height: 10),
              ...['Is it true? (Not just plausible — actually supported by evidence?)', 'Is it serving me? (Does holding it help me or limit me?)', 'Is it mine? (Did I choose it or did I inherit it without examination?)', 'Is it current? (Did it make sense for who I was, rather than who I am?)')].asMap().entries.map((e) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(width: 18, height: 18, decoration: BoxDecoration(shape: BoxShape.circle, color: _violet.withOpacity(0.15), border: Border.all(color: _violet.withOpacity(0.3))), child: Center(child: Text('${e.key + 1}', style: TextStyle(color: _violet, fontSize: 9, fontWeight: FontWeight.w900)))),
                  const SizedBox(width: 8),
                  Expanded(child: Text(e.value, style: const TextStyle(color: Colors.white70, fontSize: 11, height: 1.4))),
                ]),
              )),
            ]),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [_gold.withOpacity(0.10), _amber.withOpacity(0.06)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: _gold.withOpacity(0.2))),
            child: Row(children: [
              Icon(Icons.format_quote_rounded, color: _amber, size: 26), const SizedBox(width: 12),
              const Expanded(child: Text('"It\'s not hard to make decisions when you know what your values are." — Roy Disney', style: TextStyle(color: Colors.white, fontSize: 13, height: 1.4, fontStyle: FontStyle.italic))),
            ]),
          ),
        ],
      ),
    );
  }
}

class _CompassPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2; final cy = size.height / 2;
    final p = Paint()..style = PaintingStyle.stroke;
    // Outer ring
    p.color = const Color(0xFFD4A853).withOpacity(0.2); p.strokeWidth = 1;
    canvas.drawCircle(Offset(cx, cy), 90, p);
    canvas.drawCircle(Offset(cx, cy), 60, p);
    canvas.drawCircle(Offset(cx, cy), 30, p);
    // Cardinal lines
    p.color = const Color(0xFFD4A853).withOpacity(0.3); p.strokeWidth = 1;
    canvas.drawLine(Offset(cx, cy - 90), Offset(cx, cy + 90), p);
    canvas.drawLine(Offset(cx - 90, cy), Offset(cx + 90, cy), p);
    // Center
    final cp = Paint()..color = const Color(0xFFD4A853);
    canvas.drawCircle(Offset(cx, cy), 8, cp);
    // N/S/E/W points
    final pF = Paint()..color = const Color(0xFFD4A853).withOpacity(0.6)..style = PaintingStyle.fill;
    final paths = [Path()..moveTo(cx, cy - 90)..lineTo(cx - 8, cy - 70)..lineTo(cx + 8, cy - 70)..close(), Path()..moveTo(cx, cy + 90)..lineTo(cx - 8, cy + 70)..lineTo(cx + 8, cy + 70)..close()];
    for (final path in paths) canvas.drawPath(path, pF);
  }
  @override bool shouldRepaint(_) => false;
}

class _ValueCard extends StatelessWidget {
  final Color color; final IconData icon; final String title, category, desc;
  const _ValueCard({required this.color, required this.icon, required this.title, required this.category, required this.desc});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: color.withOpacity(0.07), borderRadius: BorderRadius.circular(14), border: Border.all(color: color.withOpacity(0.2))),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Column(children: [
        Container(padding: const EdgeInsets.all(7), decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(9)), child: Icon(icon, color: color, size: 16)),
        const SizedBox(height: 4),
        Text(category, style: TextStyle(color: color.withOpacity(0.6), fontSize: 8, fontWeight: FontWeight.w700)),
      ]),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.w700)),
        const SizedBox(height: 5),
        Text(desc, style: const TextStyle(color: Colors.white60, fontSize: 11, height: 1.5)),
      ])),
    ]),
  );
}

class _SecHead extends StatelessWidget {
  final String text; final Color color;
  const _SecHead(this.text, this.color);
  @override
  Widget build(BuildContext context) => Row(children: [Container(width: 3, height: 14, color: color), const SizedBox(width: 8), Text(text, style: TextStyle(color: color.withOpacity(0.85), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2))]);
}
