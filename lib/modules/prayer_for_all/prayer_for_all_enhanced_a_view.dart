import 'package:flutter/material.dart';
import 'dart:math' as math;

/// DESIGN: Sacred Mandala — concentric spiritual design with prayer cards
class PrayerForAllBestAView extends StatelessWidget {
  final bool isEmbedded;
  const PrayerForAllBestAView({super.key, this.isEmbedded = false});

  static const _gold = Color(0xFFD4A853);
  static const _amber = Color(0xFFF59E0B);
  static const _orange = Color(0xFFF97316);
  static const _violet = Color(0xFF7C3AED);
  static const _sky = Color(0xFF0EA5E9);
  static const _teal = Color(0xFF0D9488);
  static const _bg = Color(0xFF080400);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: const Text(
          'PRAYER FOR ALL',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
            fontSize: 13,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: Icon(Icons.auto_awesome_rounded, color: _gold, size: 22),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        shrinkWrap: isEmbedded,
        physics: isEmbedded ? const NeverScrollableScrollPhysics() : null,
        children: [
          // SACRED MANDALA HERO
          SizedBox(
            height: 220,
            child: Center(
              child: CustomPaint(
                painter: _MandalaPainter(),
                size: const Size(200, 200),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              'Peace be upon all living beings',
              style: TextStyle(
                color: _gold.withOpacity(0.8),
                fontSize: 12,
                fontStyle: FontStyle.italic,
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(height: 24),
          // PRAYER CARDS — one for each tradition
          _SecHead('UNIVERSAL PRAYERS', _gold),
          const SizedBox(height: 12),
          _PrayerCard(
            tradition: 'Peace',
            color: _teal,
            icon: Icons.spa_rounded,
            prayer:
                'May all beings be peaceful. May all beings be happy. May all beings be safe. May all beings awaken to the light of their true nature. May all beings be free from suffering.',
          ),
          const SizedBox(height: 8),
          _PrayerCard(
            tradition: 'Strength',
            color: _violet,
            icon: Icons.fitness_center_rounded,
            prayer:
                'Grant us the strength to face what must be faced, the wisdom to understand what must be understood, and the courage to act on what we know to be right — even when the cost is high and the outcome uncertain.',
          ),
          const SizedBox(height: 8),
          _PrayerCard(
            tradition: 'Healing',
            color: _sky,
            icon: Icons.healing_rounded,
            prayer:
                'For all who suffer in body, mind, or spirit — may healing find them. May the darkness of illness, grief, and confusion yield to light, to relief, and to the quiet courage of those who tend to the wounded.',
          ),
          const SizedBox(height: 8),
          _PrayerCard(
            tradition: 'Guidance',
            color: _amber,
            icon: Icons.explore_rounded,
            prayer:
                'Lead us through the complexity of choices to the ones that honour our deepest values. Where the path is unclear, grant clarity. Where clarity fails, grant trust. Where trust wavers, grant patience enough to wait for the light.',
          ),
          const SizedBox(height: 8),
          _PrayerCard(
            tradition: 'Gratitude',
            color: _orange,
            icon: Icons.favorite_rounded,
            prayer:
                'For the breath that sustains us, the beauty that delights us, the love that anchors us, and the grace that forgives us — deep gratitude. May we live in a way that honours these gifts by returning them multiplied.',
          ),
          const SizedBox(height: 8),
          _PrayerCard(
            tradition: 'Community',
            color: _gold,
            icon: Icons.people_rounded,
            prayer:
                'Bless all who are trying — parents, teachers, healers, builders, peacemakers, and those who quietly carry others through difficult seasons. May none of them carry their burden alone. May community rise to meet every genuine need.',
          ),
          const SizedBox(height: 20),
          // SPIRITUAL REFLECTION
          _SecHead('REFLECTION PRACTICE', _teal),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _teal.withOpacity(0.07),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _teal.withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'The Daily Intention',
                  style: TextStyle(
                    color: _teal,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Begin each day with three questions: • What do I hope to give today? • Who needs grace from me today? • What am I grateful for that I haven\'t yet acknowledged? The answers need not be elaborate — even a single honest sentence for each creates the orientation that shapes the day.',
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 12,
                    height: 1.55,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_gold.withOpacity(0.10), _amber.withOpacity(0.06)],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _gold.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                Icon(Icons.format_quote_rounded, color: _amber, size: 26),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    '"Prayer is not asking. It is a longing of the soul." — Mahatma Gandhi',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      height: 1.4,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MandalaPainter extends CustomPainter {
  static const _colors = [
    Color(0xFFD4A853),
    Color(0xFFF59E0B),
    Color(0xFF7C3AED),
    Color(0xFF0EA5E9),
    Color(0xFF0D9488),
  ];
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    for (int ring = 0; ring < 5; ring++) {
      final r = 20.0 + ring * 18;
      final p = Paint()
        ..color = _colors[ring].withOpacity(0.2)
        ..strokeWidth = 1
        ..style = PaintingStyle.stroke;
      canvas.drawCircle(Offset(cx, cy), r, p);
      // Petals
      for (int i = 0; i < 8 + ring * 4; i++) {
        final a = i * (2 * math.pi / (8 + ring * 4));
        final x = cx + r * math.cos(a);
        final y = cy + r * math.sin(a);
        canvas.drawCircle(
          Offset(x, y),
          2 + ring.toDouble(),
          Paint()..color = _colors[ring].withOpacity(0.15 + ring * 0.05),
        );
      }
    }
    canvas.drawCircle(
      Offset(cx, cy),
      12,
      Paint()..color = const Color(0xFFD4A853).withOpacity(0.4),
    );
    canvas.drawCircle(
      Offset(cx, cy),
      6,
      Paint()..color = const Color(0xFFD4A853),
    );
  }

  @override
  bool shouldRepaint(_) => false;
}

class _SecHead extends StatelessWidget {
  final String text;
  final Color color;
  const _SecHead(this.text, this.color);
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Container(width: 3, height: 14, color: color),
      const SizedBox(width: 8),
      Text(
        text,
        style: TextStyle(
          color: color.withOpacity(0.85),
          fontSize: 10,
          fontWeight: FontWeight.w800,
          letterSpacing: 2,
        ),
      ),
    ],
  );
}

class _PrayerCard extends StatelessWidget {
  final String tradition, prayer;
  final Color color;
  final IconData icon;
  const _PrayerCard({
    required this.tradition,
    required this.prayer,
    required this.color,
    required this.icon,
  });
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: color.withOpacity(0.07),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: color.withOpacity(0.22)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 14),
            ),
            const SizedBox(width: 8),
            Text(
              tradition.toUpperCase(),
              style: TextStyle(
                color: color,
                fontSize: 9,
                fontWeight: FontWeight.w900,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          prayer,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
            height: 1.6,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}
