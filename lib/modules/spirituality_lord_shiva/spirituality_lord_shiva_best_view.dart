import 'package:flutter/material.dart';
import 'dart:math' as math;

/// DESIGN: Sacred Cosmos — deep space spiritual aesthetic with trishul and cosmic elements
class SpiritualityLordShivaBestView extends StatelessWidget {
  const SpiritualityLordShivaBestView({super.key});

  static const _saffron = Color(0xFFFF6B35);
  static const _gold = Color(0xFFD4A853);
  static const _indigo = Color(0xFF1E1B4B);
  static const _violet = Color(0xFF7C3AED);
  static const _sky = Color(0xFF0EA5E9);
  static const _teal = Color(0xFF0D9488);
  static const _bg = Color(0xFF06020E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            backgroundColor: _bg,
            foregroundColor: Colors.white,
            title: const Text('OM NAMAH SHIVAYA', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 12, color: Colors.white)),
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(gradient: RadialGradient(colors: [Color(0xFF1A0030), Color(0xFF08000E), Color(0xFF06020E)], center: Alignment.topCenter, radius: 1.5)),
                child: Stack(children: [
                  Positioned.fill(child: CustomPaint(painter: _CosmicPainter())),
                  Padding(padding: const EdgeInsets.fromLTRB(24, 80, 24, 24), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const SizedBox(height: 10),
                    Text('ॐ', style: TextStyle(fontSize: 60, color: _gold, fontWeight: FontWeight.w900, height: 1.0)),
                    Text('SPIRITUALITY & LORD SHIVA', style: TextStyle(color: _saffron, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 2)),
                    const SizedBox(height: 4),
                    Text('The consciousness that pervades all creation', style: TextStyle(color: Colors.white60, fontSize: 11, textAlign: TextAlign.center)),
                  ])),
                ]),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
            sliver: SliverList(delegate: SliverChildListDelegate([
              // SHIVA ASPECTS
              _SecHead('THE DIVINE ASPECTS', _gold),
              const SizedBox(height: 12),
              _AspectCard(name: 'Shiva as Mahakala', color: _violet, icon: Icons.access_time_rounded, desc: 'The Great Time — the aspect that governs the cycle of creation, preservation, and dissolution. Time is not linear but cyclical; every ending is the seed of a new beginning. This cosmic understanding dissolves attachment to impermanent forms.'),
              const SizedBox(height: 8),
              _AspectCard(name: 'Shiva as Nataraja', color: _saffron, icon: Icons.self_improvement_rounded, desc: 'The Cosmic Dancer — whose dance sustains creation and whose still point at the centre of motion represents the consciousness beneath all activity. The dance teaches that action without ego does not bind; it liberates.'),
              const SizedBox(height: 8),
              _AspectCard(name: 'Shiva as Ardhanarishvara', color: _sky, icon: Icons.balance_rounded, desc: 'The half-male, half-female form — representing the inseparability of masculine and feminine principles in all creation. Balance is not the blending of opposites but their creative integration into a unity that transcends both.'),
              const SizedBox(height: 8),
              _AspectCard(name: 'Shiva as Sadashiva', color: _gold, icon: Icons.star_rounded, desc: 'The Eternal Shiva — the aspect of pure consciousness that exists before, during, and after all manifestation. This is the witness — the unchanging awareness in which the changing world appears and disappears like clouds in a clear sky.'),
              const SizedBox(height: 20),
              _SecHead('SPIRITUAL PRACTICES', _teal),
              const SizedBox(height: 12),
              _PracticeGrid(),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [_violet.withOpacity(0.10), _bg]), borderRadius: BorderRadius.circular(16), border: Border.all(color: _gold.withOpacity(0.25))),
                child: Column(children: [
                  Text('ॐ नमः शिवाय', style: TextStyle(color: _gold, fontSize: 22, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 8),
                  const Text('Om Namah Shivaya — I bow to Shiva, the auspicious one, the inner Self. This mantra is a salutation to the divine consciousness within every being — a reminder that the sacred is not distant but present in every moment of awareness.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white60, fontSize: 11, height: 1.55)),
                ]),
              ),
            ])),
          ),
        ],
      ),
    );
  }
}

class _CosmicPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..style = PaintingStyle.fill;
    final rng = math.Random(42);
    for (int i = 0; i < 40; i++) {
      p.color = Colors.white.withOpacity(0.3 + rng.nextDouble() * 0.4);
      canvas.drawCircle(Offset(rng.nextDouble() * size.width, rng.nextDouble() * size.height), 1.0 + rng.nextDouble() * 1.5, p);
    }
    // Rings
    final rp = Paint()..color = const Color(0xFF7C3AED).withOpacity(0.1)..strokeWidth = 1..style = PaintingStyle.stroke;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 80, rp);
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 110, rp);
  }
  @override bool shouldRepaint(_) => false;
}

class _AspectCard extends StatelessWidget {
  final String name, desc; final Color color; final IconData icon;
  const _AspectCard({required this.name, required this.desc, required this.color, required this.icon});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: color.withOpacity(0.07), borderRadius: BorderRadius.circular(14), border: Border.all(color: color.withOpacity(0.22))),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(padding: const EdgeInsets.all(7), decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(9)), child: Icon(icon, color: color, size: 16)),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(name, style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.w700)),
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

class _PracticeGrid extends StatelessWidget {
  const _PracticeGrid();
  static const items = [
    ('Meditation', Icons.self_improvement_rounded, Color(0xFF7C3AED)),
    ('Pranayama', Icons.air_rounded, Color(0xFF0EA5E9)),
    ('Mantra Japa', Icons.record_voice_over_rounded, Color(0xFFD4A853)),
    ('Satsang', Icons.people_rounded, Color(0xFF0D9488)),
    ('Seva', Icons.volunteer_activism_rounded, Color(0xFFFF6B35)),
    ('Dhyana', Icons.visibility_rounded, Color(0xFF10B981)),
  ];
  @override
  Widget build(BuildContext context) => GridView.count(crossAxisCount: 3, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisSpacing: 8, mainAxisSpacing: 8, childAspectRatio: 1.3,
    children: items.map((it) => Container(
      decoration: BoxDecoration(color: it.$3.withOpacity(0.08), borderRadius: BorderRadius.circular(12), border: Border.all(color: it.$3.withOpacity(0.2))),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(it.$2, color: it.$3, size: 20),
        const SizedBox(height: 5),
        Text(it.$1, style: TextStyle(color: it.$3, fontSize: 10, fontWeight: FontWeight.w700)),
      ]),
    )).toList());
}
