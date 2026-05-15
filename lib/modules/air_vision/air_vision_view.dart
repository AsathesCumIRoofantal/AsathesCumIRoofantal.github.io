import 'package:flutter/material.dart';

/// AIR VISION — Unique design: cosmic indigo + neon cyan blueprint theme.
/// New sections: Vision Beacon, 6 Vision Pillars, 5-stage Roadmap, Manifesto.
class AirVisionView extends StatelessWidget {
  const AirVisionView({super.key});

  static const _bg = Color(0xFF030318);
  static const _ink = Color(0xFF0A0A2E);
  static const _cyan = Color(0xFF00E5FF);
  static const _violet = Color(0xFF7C3AED);
  static const _gold = Color(0xFFFBBF24);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 280,
            backgroundColor: _bg,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(background: _beacon()),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _summary(),
                const SizedBox(height: 22),
                _h('SIX VISION PILLARS', _cyan),
                const SizedBox(height: 10),
                _pillars(),
                const SizedBox(height: 22),
                _h('FIVE-STAGE ROADMAP', _violet),
                const SizedBox(height: 10),
                _roadmap(),
                const SizedBox(height: 22),
                _h('MANIFESTO', _gold),
                const SizedBox(height: 10),
                _manifesto(),
                const SizedBox(height: 22),
                _split('ORIGINAL AIR VISION CONTENT'),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _beacon() => Stack(
    fit: StackFit.expand,
    children: [
      Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.0,
            colors: [_violet, _ink, _bg],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
      ),
      CustomPaint(painter: _StarsPainter()),
      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const RadialGradient(colors: [_cyan, _violet]),
                boxShadow: [
                  BoxShadow(
                    color: _cyan.withOpacity(0.6),
                    blurRadius: 30,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: const Icon(
                Icons.visibility,
                color: Colors.white,
                size: 44,
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'AIR · VISION',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                letterSpacing: 6,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              '— charting the long horizon —',
              style: TextStyle(
                color: _cyan.withOpacity(0.9),
                fontSize: 11,
                letterSpacing: 4,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    ],
  );

  Widget _h(String t, Color c) => Row(
    children: [
      Container(width: 4, height: 22, color: c),
      const SizedBox(width: 10),
      Text(
        t,
        style: TextStyle(
          color: c,
          fontSize: 12,
          letterSpacing: 3,
          fontWeight: FontWeight.w900,
        ),
      ),
    ],
  );

  Widget _split(String t) => Row(
    children: [
      Expanded(child: Container(height: 1, color: Colors.white24)),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          t,
          style: const TextStyle(
            color: Colors.white54,
            letterSpacing: 3,
            fontSize: 11,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      Expanded(child: Container(height: 1, color: Colors.white24)),
    ],
  );

  Widget _summary() => Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: _ink,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _cyan.withOpacity(0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.flag, color: _cyan, size: 18),
            SizedBox(width: 6),
            Text(
              'NORTH STAR',
              style: TextStyle(
                color: _cyan,
                letterSpacing: 2,
                fontSize: 11,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'A connected world where information serves the public — '
          'where every voice is heard, every record honoured, and every '
          'service measurable, transparent, and humane.',
          style: TextStyle(color: Colors.white, fontSize: 15, height: 1.55),
        ),
      ],
    ),
  );

  Widget _pillars() {
    final p = [
      ('Reach', 'Every village, every device.', Icons.public),
      ('Truth', 'Verified, sourced, dated.', Icons.verified),
      ('Voice', 'Multilingual, accessible.', Icons.record_voice_over),
      ('Memory', 'Records that outlast people.', Icons.archive),
      ('Service', 'Action over analysis.', Icons.volunteer_activism),
      ('Stewardship', 'Open & accountable forever.', Icons.shield),
    ];
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: p
          .map(
            (x) => Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _ink,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _violet.withOpacity(0.4)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(x.$3, color: _cyan, size: 22),
                  const SizedBox(height: 6),
                  Text(
                    x.$1.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    x.$2,
                    style: const TextStyle(color: Colors.white60, fontSize: 11),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _roadmap() {
    final r = [
      ('I', 'Seed', 'Foundation modules, language, identity.', _cyan),
      ('II', 'Sprout', 'Knowledge centre + community pulse live.', _violet),
      ('III', 'Branch', 'Records vault, services, accountability.', _gold),
      ('IV', 'Bloom', 'AI assistant, predictive guidance.', _cyan),
      ('V', 'Forest', 'Open ecosystem, partner organisations.', _violet),
    ];
    return Column(
      children: r
          .map(
            (x) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _ink,
                borderRadius: BorderRadius.circular(10),
                border: Border(left: BorderSide(color: x.$4, width: 4)),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 32,
                    child: Text(
                      x.$1,
                      style: TextStyle(
                        color: x.$4,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          x.$2.toUpperCase(),
                          style: TextStyle(
                            color: x.$4,
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          x.$3,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _manifesto() => Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: const LinearGradient(colors: [_violet, _ink]),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.format_quote, color: _gold, size: 30),
        const SizedBox(height: 4),
        const Text(
          'We do not predict the future.\nWe build the floor it stands on.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w800,
            height: 1.4,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '— AIR Vision',
          style: TextStyle(
            color: _gold,
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 2,
          ),
        ),
      ],
    ),
  );
}

class _StarsPainter extends CustomPainter {
  @override
  void paint(Canvas c, Size s) {
    final p = Paint()..color = Colors.white;
    const positions = [
      [0.1, 0.2],
      [0.25, 0.4],
      [0.7, 0.15],
      [0.85, 0.5],
      [0.4, 0.7],
      [0.15, 0.55],
      [0.6, 0.6],
      [0.9, 0.3],
      [0.5, 0.25],
      [0.3, 0.85],
    ];
    for (final pos in positions) {
      p.color = Colors.white.withOpacity(0.3 + (pos[0] * 0.5));
      c.drawCircle(
        Offset(s.width * pos[0], s.height * pos[1]),
        1 + pos[1] * 1.5,
        p,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter o) => false;
}
