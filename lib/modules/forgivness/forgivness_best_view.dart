import 'package:flutter/material.dart';
import 'dart:math' as math;

/// DESIGN: Concentric Circles / Healing Journey — radial healing progress rings
class ForgivnessBestView extends StatelessWidget {
  const ForgivnessBestView({super.key});

  static const _rose = Color(0xFFF43F5E);
  static const _pink = Color(0xFFEC4899);
  static const _violet = Color(0xFF7C3AED);
  static const _sky = Color(0xFF0EA5E9);
  static const _teal = Color(0xFF0D9488);
  static const _amber = Color(0xFFF59E0B);
  static const _green = Color(0xFF10B981);
  static const _bg = Color(0xFF080010);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: const Text('FORGIVENESS', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 3, fontSize: 13, color: Colors.white)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 14), child: Icon(Icons.healing_rounded, color: _rose, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        children: [
          // CONCENTRIC RINGS HERO
          SizedBox(
            height: 260,
            child: Center(child: Stack(alignment: Alignment.center, children: [
              // Outer rings
              _Ring(radius: 110, color: _violet, progress: 0.85, label: 'Release'),
              _Ring(radius: 87, color: _sky, progress: 0.70, label: 'Accept'),
              _Ring(radius: 64, color: _teal, progress: 0.92, label: 'Understand'),
              _Ring(radius: 41, color: _green, progress: 0.78, label: 'Heal'),
              // Center
              Container(
                width: 52, height: 52,
                decoration: BoxDecoration(shape: BoxShape.circle, gradient: RadialGradient(colors: [_rose.withOpacity(0.3), _bg])),
                child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(Icons.healing_rounded, color: Colors.white, size: 18),
                  Text('PEACE', style: TextStyle(color: Colors.white, fontSize: 6, fontWeight: FontWeight.w900, letterSpacing: 1)),
                ]),
              ),
              // Ring labels positioned
              const Positioned(top: 10, right: 50, child: Text('Release 85%', style: TextStyle(color: Color(0xFF7C3AED), fontSize: 8, fontWeight: FontWeight.w700))),
              const Positioned(top: 30, left: 30, child: Text('Accept 70%', style: TextStyle(color: Color(0xFF0EA5E9), fontSize: 8, fontWeight: FontWeight.w700))),
              const Positioned(bottom: 30, right: 30, child: Text('Understand 92%', style: TextStyle(color: Color(0xFF0D9488), fontSize: 8, fontWeight: FontWeight.w700))),
              const Positioned(bottom: 15, left: 50, child: Text('Heal 78%', style: TextStyle(color: Color(0xFF10B981), fontSize: 8, fontWeight: FontWeight.w700))),
            ])),
          ),
          Center(child: Text('The Four Rings of Forgiveness', style: TextStyle(color: _rose.withOpacity(0.7), fontSize: 11, fontStyle: FontStyle.italic))),
          const SizedBox(height: 24),
          // FORGIVENESS STAGES
          _SecHead('THE FORGIVENESS JOURNEY', _rose),
          const SizedBox(height: 12),
          _StageCard(ring: '1', color: _green, title: 'Understand',
              body: 'Forgiveness begins with understanding — not excusing — what happened. Understanding the context, motivations, and limitations of the person who caused harm does not make the harm acceptable; it makes it comprehensible. Comprehension is the first exit from the prison of incomprehension.'),
          const SizedBox(height: 8),
          _StageCard(ring: '2', color: _teal, title: 'Accept',
              body: 'Acceptance acknowledges that the harm occurred — that the loss, the breach, the hurt was real. It resists the twin traps of minimisation (pretending it wasn\'t that bad) and rumination (replaying it endlessly). Acceptance is the stable ground from which movement becomes possible.'),
          const SizedBox(height: 8),
          _StageCard(ring: '3', color: _sky, title: 'Release',
              body: 'Release is the choice to stop carrying the weight of resentment. It is not done for the person who caused the harm — it is done for yourself. Sustained resentment is a toxin with a long half-life; release is not a gift to the other person, it is an act of self-care.'),
          const SizedBox(height: 8),
          _StageCard(ring: '4', color: _violet, title: 'Integrate',
              body: 'The final stage transforms the experience of harm into a part of your story that you carry with wisdom rather than bitterness. Integration does not erase what happened — it incorporates it into an identity that is stronger, more compassionate, and more capable of nuance.'),
          const SizedBox(height: 20),
          _SecHead('KEY DISTINCTIONS', _teal),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: _DistCard(color: _green, title: 'Forgiveness IS', items: ['Releasing resentment', 'A personal act of healing', 'Possible without reconciliation', 'Done for yourself', 'A process, not an event'])),
            const SizedBox(width: 10),
            Expanded(child: _DistCard(color: _red, title: 'Forgiveness is NOT', items: ['Excusing the harm', 'Forgetting what happened', 'Requiring the other person', 'Weakness or surrender', 'Instant or simple'])),
          ]),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [_rose.withOpacity(0.08), _violet.withOpacity(0.05)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: _rose.withOpacity(0.18))),
            child: Row(children: [
              Icon(Icons.format_quote_rounded, color: _amber, size: 26), const SizedBox(width: 12),
              const Expanded(child: Text('"Forgiveness is not an occasional act; it is a constant attitude." — Martin Luther King Jr.', style: TextStyle(color: Colors.white, fontSize: 12, height: 1.4, fontStyle: FontStyle.italic))),
            ]),
          ),
        ],
      ),
    );
  }
}

class _Ring extends StatelessWidget {
  final double radius; final Color color; final double progress; final String label;
  const _Ring({required this.radius, required this.color, required this.progress, required this.label});
  @override
  Widget build(BuildContext context) => SizedBox(
    width: radius * 2, height: radius * 2,
    child: CustomPaint(painter: _RingPainter(color: color, progress: progress)),
  );
}

class _RingPainter extends CustomPainter {
  final Color color; final double progress;
  _RingPainter({required this.color, required this.progress});
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2; final cy = size.height / 2; final r = (size.width - 6) / 2;
    final bg = Paint()..color = color.withOpacity(0.08)..strokeWidth = 5..style = PaintingStyle.stroke;
    final fg = Paint()..color = color..strokeWidth = 5..style = PaintingStyle.stroke..strokeCap = StrokeCap.round;
    canvas.drawCircle(Offset(cx, cy), r, bg);
    canvas.drawArc(Rect.fromCircle(center: Offset(cx, cy), radius: r), -math.pi / 2, 2 * math.pi * progress, false, fg);
  }
  @override bool shouldRepaint(_) => false;
}

const _red = Color(0xFFEF4444);

class _StageCard extends StatelessWidget {
  final String ring, title, body; final Color color;
  const _StageCard({required this.ring, required this.title, required this.body, required this.color});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: color.withOpacity(0.07), borderRadius: BorderRadius.circular(14), border: Border.all(color: color.withOpacity(0.2))),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(width: 28, height: 28, decoration: BoxDecoration(shape: BoxShape.circle, color: color.withOpacity(0.15), border: Border.all(color: color.withOpacity(0.4))), child: Center(child: Text(ring, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w900)))),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.w700)),
        const SizedBox(height: 5),
        Text(body, style: const TextStyle(color: Colors.white60, fontSize: 11, height: 1.5)),
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

class _DistCard extends StatelessWidget {
  final Color color; final String title; final List<String> items;
  const _DistCard({required this.color, required this.title, required this.items});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: color.withOpacity(0.07), borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withOpacity(0.2))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1)),
      const SizedBox(height: 8),
      ...items.map((i) => Padding(padding: const EdgeInsets.only(bottom: 5), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(Icons.circle, color: color.withOpacity(0.6), size: 6),
        const SizedBox(width: 6),
        Expanded(child: Text(i, style: const TextStyle(color: Colors.white60, fontSize: 10, height: 1.3))),
      ]))),
    ]),
  );
}
