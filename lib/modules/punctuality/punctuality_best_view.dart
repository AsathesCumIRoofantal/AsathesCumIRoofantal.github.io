import 'package:flutter/material.dart';
import 'dart:math' as math;

/// DESIGN: Clock/Time Grid — watch-face hero with time-discipline grid cards
class PunctualityBestView extends StatelessWidget {
  const PunctualityBestView({super.key});

  static const _steel = Color(0xFF64748B);
  static const _silver = Color(0xFF94A3B8);
  static const _gold = Color(0xFFD4A853);
  static const _amber = Color(0xFFF59E0B);
  static const _blue = Color(0xFF2563EB);
  static const _green = Color(0xFF10B981);
  static const _red = Color(0xFFEF4444);
  static const _bg = Color(0xFF050508);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: const Text('PUNCTUALITY', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 14, color: Colors.white)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 14), child: Icon(Icons.access_time_rounded, color: _gold, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        children: [
          // WATCH FACE HERO
          Center(child: SizedBox(width: 200, height: 200, child: CustomPaint(painter: _WatchPainter()))),
          const SizedBox(height: 6),
          Center(child: Text('09:16 AM', style: TextStyle(color: _gold, fontSize: 28, fontWeight: FontWeight.w900, letterSpacing: 4, fontFamily: 'monospace'))),
          Center(child: Text('Thursday, May 16, 2026', style: TextStyle(color: Colors.white38, fontSize: 11, letterSpacing: 1))),
          const SizedBox(height: 24),
          // PUNCTUALITY METRICS GRID
          _SecHead('PUNCTUALITY DASHBOARD', _gold),
          const SizedBox(height: 12),
          GridView.count(crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 1.6,
            children: [
              _TimeMetric('97%', 'On-Time Rate\n(30 days)', _green, Icons.check_circle_rounded),
              _TimeMetric('2.3 min', 'Avg. Early\nArrival', _gold, Icons.access_time_rounded),
              _TimeMetric('3', 'Late\nInstances', _amber, Icons.warning_rounded),
              _TimeMetric('18', 'Streak\nDays', _blue, Icons.local_fire_department_rounded),
            ]),
          const SizedBox(height: 20),
          // PRINCIPLE CARDS
          _SecHead('TIME DISCIPLINE PRINCIPLES', _amber),
          const SizedBox(height: 12),
          _TimeCard(color: _gold, icon: Icons.alarm_rounded, title: 'The Buffer Rule',
              body: 'Always add 20% buffer time to any travel or preparation estimate. Human beings systematically underestimate transit time, preparation complexity, and the probability of the unexpected. Building the buffer in prevents the apology cycle.'),
          const SizedBox(height: 8),
          _TimeCard(color: _green, icon: Icons.calculate_rounded, title: 'Reverse Time Mapping',
              body: 'Start from the arrival time and work backward — when must you leave? When must you finish preparation? When must you start? Reverse mapping converts the vague intention to be on time into a specific sequence of trackable actions.'),
          const SizedBox(height: 8),
          _TimeCard(color: _blue, icon: Icons.psychology_rounded, title: 'Punctuality as Respect',
              body: 'Arriving late communicates — regardless of intent — that your time is more valuable than the other person\'s. The consistent late-arriver trains people around them to expect less reliability, with compounding effects on trust and professional standing.'),
          const SizedBox(height: 8),
          _TimeCard(color: _amber, icon: Icons.trending_up_rounded, title: 'The Compound Effect',
              body: 'A reputation for punctuality takes years to build and one public failure to damage. The compound interest of consistent punctuality — in how people trust you, rely on you, and recommend you — is one of the most underrated professional investments available.'),
          const SizedBox(height: 8),
          _TimeCard(color: _steel, icon: Icons.self_improvement_rounded, title: 'Recovery Protocol',
              body: 'When late is unavoidable: communicate as early as possible, estimate accurately rather than optimistically, apologise sincerely once (not repeatedly), and deliver the best quality of meeting possible to honour the reduced time. Brevity and quality are your recovery tools.'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [_gold.withOpacity(0.08), _amber.withOpacity(0.05)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: _gold.withOpacity(0.18))),
            child: Row(children: [
              Icon(Icons.format_quote_rounded, color: _amber, size: 26), const SizedBox(width: 12),
              const Expanded(child: Text('"Better three hours too soon than a minute too late." — William Shakespeare', style: TextStyle(color: Colors.white, fontSize: 13, height: 1.4, fontStyle: FontStyle.italic))),
            ]),
          ),
        ],
      ),
    );
  }
}

class _WatchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2; final cy = size.height / 2; final r = size.width / 2 - 4;
    // Outer ring
    final outer = Paint()..color = const Color(0xFFD4A853).withOpacity(0.3)..strokeWidth = 2..style = PaintingStyle.stroke;
    canvas.drawCircle(Offset(cx, cy), r, outer);
    // Inner
    final inner = Paint()..color = const Color(0xFF0F0F14);
    canvas.drawCircle(Offset(cx, cy), r - 2, inner);
    // Hour marks
    for (int i = 0; i < 12; i++) {
      final a = i * math.pi / 6 - math.pi / 2;
      final isMain = i % 3 == 0;
      final p = Paint()..color = isMain ? const Color(0xFFD4A853) : const Color(0xFF64748B)..strokeWidth = isMain ? 2.5 : 1;
      canvas.drawLine(Offset(cx + (r - 14) * math.cos(a), cy + (r - 14) * math.sin(a)), Offset(cx + r * math.cos(a), cy + r * math.sin(a)), p);
    }
    // Minute hand (pointing to ~16 min)
    final minA = (16 / 60) * 2 * math.pi - math.pi / 2;
    final hA = (9 / 12 + 16 / (60 * 12)) * 2 * math.pi - math.pi / 2;
    canvas.drawLine(Offset(cx, cy), Offset(cx + (r - 20) * math.cos(minA), cy + (r - 20) * math.sin(minA)), Paint()..color = Colors.white..strokeWidth = 2..strokeCap = StrokeCap.round);
    canvas.drawLine(Offset(cx, cy), Offset(cx + (r - 40) * math.cos(hA), cy + (r - 40) * math.sin(hA)), Paint()..color = const Color(0xFFD4A853)..strokeWidth = 3..strokeCap = StrokeCap.round);
    // Center dot
    canvas.drawCircle(Offset(cx, cy), 4, Paint()..color = const Color(0xFFD4A853));
  }
  @override bool shouldRepaint(_) => false;
}

class _SecHead extends StatelessWidget {
  final String text; final Color color;
  const _SecHead(this.text, this.color);
  @override
  Widget build(BuildContext context) => Row(children: [Container(width: 3, height: 14, color: color), const SizedBox(width: 8), Text(text, style: TextStyle(color: color.withOpacity(0.85), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2))]);
}

class _TimeMetric extends StatelessWidget {
  final String value, label; final Color color; final IconData icon;
  const _TimeMetric(this.value, this.label, this.color, this.icon);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(14), border: Border.all(color: color.withOpacity(0.2))),
    child: Row(children: [
      Icon(icon, color: color, size: 22),
      const SizedBox(width: 10),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(value, style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.w900)),
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 9, height: 1.2)),
      ]),
    ]),
  );
}

class _TimeCard extends StatelessWidget {
  final Color color; final IconData icon; final String title, body;
  const _TimeCard({required this.color, required this.icon, required this.title, required this.body});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(13), decoration: BoxDecoration(color: color.withOpacity(0.07), borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withOpacity(0.18))),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(padding: const EdgeInsets.all(7), decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(9)), child: Icon(icon, color: color, size: 15)),
      const SizedBox(width: 10),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w800)),
        const SizedBox(height: 4),
        Text(body, style: const TextStyle(color: Colors.white54, fontSize: 11, height: 1.45)),
      ])),
    ]),
  );
}
