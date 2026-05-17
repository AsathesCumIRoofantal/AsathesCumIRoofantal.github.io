import 'package:flutter/material.dart';
import 'dart:math' as math;

/// DESIGN: Hexagonal Honeycomb Grid — hex cells forming an innovation map
class InnovationKeyBestView extends StatelessWidget {
  const InnovationKeyBestView({super.key});

  static const _lime = Color(0xFF84CC16);
  static const _yellow = Color(0xFFEAB308);
  static const _orange = Color(0xFFF97316);
  static const _teal = Color(0xFF0D9488);
  static const _blue = Color(0xFF2563EB);
  static const _violet = Color(0xFF7C3AED);
  static const _bg = Color(0xFF040A04);

  @override
  Widget build(BuildContext context) {
    final cells = [
      _HexCell(color: _lime, icon: Icons.lightbulb_rounded, label: 'Ideation'),
      _HexCell(color: _yellow, icon: Icons.science_rounded, label: 'Experiment'),
      _HexCell(color: _orange, icon: Icons.bolt_rounded, label: 'Prototype'),
      _HexCell(color: _teal, icon: Icons.loop_rounded, label: 'Iterate'),
      _HexCell(color: _blue, icon: Icons.rocket_launch_rounded, label: 'Launch'),
      _HexCell(color: _violet, icon: Icons.trending_up_rounded, label: 'Scale'),
      _HexCell(color: _lime, icon: Icons.psychology_rounded, label: 'Insight'),
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: const Text('INNOVATION KEY', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 3, fontSize: 13, color: Colors.white)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 14), child: Icon(Icons.hub_rounded, color: _lime, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        children: [
          // HERO BANNER
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [const Color(0xFF0A1A00), _lime.withOpacity(0.08)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(22), border: Border.all(color: _lime.withOpacity(0.28)),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('INNOVATION INTELLIGENCE', style: TextStyle(color: _lime, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 2)),
              const SizedBox(height: 8),
              const Text('Unlock the systematic\nside of breakthrough thinking.', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900, height: 1.2)),
              const SizedBox(height: 10),
              Text('Innovation is not an accident — it is the output of a structured process that can be learned, practised, and improved.', style: TextStyle(color: Colors.white60, fontSize: 12, height: 1.4)),
            ]),
          ),
          const SizedBox(height: 24),
          // HEXAGONAL MAP LABEL
          Row(children: [
            Container(width: 3, height: 14, color: _lime),
            const SizedBox(width: 8),
            Text('THE INNOVATION MAP', style: TextStyle(color: _lime.withOpacity(0.8), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2)),
          ]),
          const SizedBox(height: 16),
          // CUSTOM HEX GRID
          SizedBox(
            height: 220,
            child: CustomPaint(
              painter: _HexGridPainter(cells: cells),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: cells.asMap().entries.map((e) {
                final cell = e.value;
                final row = e.key ~/ 4;
                final isOdd = row % 2 == 1;
                return Transform.translate(
                  offset: Offset(isOdd ? 28 : 0, row * 52.0),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Container(
                        width: 52, height: 52,
                        decoration: BoxDecoration(color: cell.color.withOpacity(0.12), shape: BoxShape.circle, border: Border.all(color: cell.color.withOpacity(0.4), width: 1.5)),
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Icon(cell.icon, color: cell.color, size: 18),
                          const SizedBox(height: 2),
                          Text(cell.label, textAlign: TextAlign.center, style: TextStyle(color: cell.color, fontSize: 7, fontWeight: FontWeight.w700, height: 1.1)),
                        ]),
                      ),
                    ]),
                  ),
                );
              }).toList()),
            ),
          ),
          const SizedBox(height: 20),
          // INNOVATION PILLARS
          _InnoSection(color: _lime, icon: Icons.lightbulb_rounded, title: 'Structured Ideation',
              body: 'The best innovations emerge not from random inspiration but from systematic ideation — forcing divergent thinking through constraint, analogy, and inversion techniques. AIR\'s ideation session templates guide you through SCAMPER, first-principles, and Jobs-to-be-Done frameworks in structured sprints.'),
          const SizedBox(height: 10),
          _InnoSection(color: _orange, icon: Icons.science_rounded, title: 'Rapid Experimentation',
              body: 'The velocity of learning determines the velocity of innovation. Small, fast, cheap experiments that produce binary outcomes — it works or it doesn\'t — generate 10x the learning per unit of time compared to large, slow, expensive ones. Design your experiments to fail fast and informatively.'),
          const SizedBox(height: 10),
          _InnoSection(color: _teal, icon: Icons.loop_rounded, title: 'Iteration Protocol',
              body: 'Every prototype contains assumptions. Iteration is the discipline of replacing assumptions with evidence, one cycle at a time. AIR\'s iteration log captures what changed, why, and what the outcome reveals — building a documented learning trail that informs the next cycle.'),
          const SizedBox(height: 10),
          _InnoSection(color: _violet, icon: Icons.hub_rounded, title: 'Cross-Domain Connection',
              body: 'The most powerful innovations are almost always transfers — a solution from one domain applied to a problem in another. Deliberately exposing yourself to adjacent fields and maintaining a cross-domain idea journal is the systematic version of the "eureka" that looks accidental from the outside.'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [_lime.withOpacity(0.08), _teal.withOpacity(0.05)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: _lime.withOpacity(0.18))),
            child: Row(children: [
              Icon(Icons.format_quote_rounded, color: _yellow, size: 26), const SizedBox(width: 12),
              const Expanded(child: Text('"Innovation distinguishes between a leader and a follower." — Steve Jobs', style: TextStyle(color: Colors.white, fontSize: 13, height: 1.4, fontStyle: FontStyle.italic))),
            ]),
          ),
        ],
      ),
    );
  }
}

class _HexCell { final Color color; final IconData icon; final String label; const _HexCell({required this.color, required this.icon, required this.label}); }

class _HexGridPainter extends CustomPainter {
  final List<_HexCell> cells;
  _HexGridPainter({required this.cells});
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..style = PaintingStyle.stroke..strokeWidth = 0.5;
    for (int i = 0; i < cells.length; i++) {
      p.color = cells[i].color.withOpacity(0.08);
      final cx = 40.0 + (i % 4) * 80;
      final cy = 60.0 + (i ~/ 4) * 80;
      final path = Path();
      for (int j = 0; j < 6; j++) {
        final a = math.pi / 180 * (60 * j - 30);
        final x = cx + 36 * math.cos(a); final y = cy + 36 * math.sin(a);
        if (j == 0) path.moveTo(x, y); else path.lineTo(x, y);
      }
      path.close();
      canvas.drawPath(path, p);
    }
  }
  @override bool shouldRepaint(_) => false;
}

class _InnoSection extends StatelessWidget {
  final Color color; final IconData icon; final String title, body;
  const _InnoSection({required this.color, required this.icon, required this.title, required this.body});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: color.withOpacity(0.07), borderRadius: BorderRadius.circular(14), border: Border.all(color: color.withOpacity(0.18))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(8)), child: Icon(icon, color: color, size: 16)), const SizedBox(width: 10), Text(title, style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.w800))]),
      const SizedBox(height: 8),
      Text(body, style: const TextStyle(color: Colors.white70, fontSize: 12, height: 1.5)),
    ]),
  );
}
