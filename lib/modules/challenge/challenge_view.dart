import 'package:flutter/material.dart';

/// CHALLENGE — Unique: crimson + slate "battle map / arena" theme.
/// New sections: Challenge Tracker, 6 Types of Challenge, Battle Plan, Mindset Mantras.
class ChallengeView extends StatelessWidget {
  const ChallengeView({super.key});

  static const _bg = Color(0xFF0E0B0B);
  static const _slate = Color(0xFF1F2937);
  static const _crimson = Color(0xFFDC2626);
  static const _orange = Color(0xFFF97316);
  static const _gold = Color(0xFFFBBF24);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 240,
            backgroundColor: _bg,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [_bg, _slate, Color(0xFF7F1D1D)],
                      ),
                    ),
                  ),
                  CustomPaint(painter: _SwordsPainter()),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 70, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _crimson,
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: const Text(
                            'ENTER · ENGAGE · ENDURE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              letterSpacing: 3,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'CHALLENGE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 8,
                          ),
                        ),
                        Text(
                          'the friction that forges',
                          style: TextStyle(
                            color: _gold,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _tracker(),
                const SizedBox(height: 22),
                _h('SIX TYPES OF CHALLENGE'),
                const SizedBox(height: 10),
                _types(),
                const SizedBox(height: 22),
                _h('BATTLE PLAN'),
                const SizedBox(height: 10),
                _plan(),
                const SizedBox(height: 22),
                _h('MINDSET MANTRAS'),
                const SizedBox(height: 10),
                _mantras(),
                const SizedBox(height: 22),
                _split('ORIGINAL CHALLENGE CONTENT'),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _h(String t) => Row(
    children: [
      Container(width: 4, height: 22, color: _crimson),
      const SizedBox(width: 10),
      Text(
        t,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          letterSpacing: 3,
          fontWeight: FontWeight.w900,
        ),
      ),
    ],
  );

  Widget _split(String t) => Row(
    children: [
      Expanded(
        child: Container(height: 1, color: _crimson.withValues(alpha: 0.4)),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          t,
          style: const TextStyle(
            color: _gold,
            letterSpacing: 3,
            fontSize: 11,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      Expanded(
        child: Container(height: 1, color: _crimson.withValues(alpha: 0.4)),
      ),
    ],
  );

  Widget _tracker() => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _slate,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _crimson.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'THIS WEEK',
              style: TextStyle(
                color: Colors.white70,
                letterSpacing: 2,
                fontSize: 11,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              '3 / 5 ENGAGED',
              style: TextStyle(
                color: _gold,
                fontSize: 14,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: List.generate(
            5,
            (i) => Expanded(
              child: Container(
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: i < 3 ? _crimson : Colors.white12,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Don\'t flinch. The next rep is where the change begins.',
          style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
        ),
      ],
    ),
  );

  Widget _types() {
    final t = [
      ('PHYSICAL', 'Body, breath, endurance.', Icons.fitness_center, _crimson),
      ('MENTAL', 'Focus, decision, mastery.', Icons.psychology, _orange),
      ('EMOTIONAL', 'Pain, fear, restraint.', Icons.favorite_border, _gold),
      ('SOCIAL', 'Conflict, exposure, leadership.', Icons.groups, _crimson),
      ('CREATIVE', 'Empty page, hardest first.', Icons.brush, _orange),
      ('SPIRITUAL', 'Doubt, surrender, faith.', Icons.self_improvement, _gold),
    ];
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.4,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      children: t
          .map(
            (x) => Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _slate,
                borderRadius: BorderRadius.circular(10),
                border: Border(bottom: BorderSide(color: x.$4, width: 3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(x.$3, color: x.$4, size: 22),
                  const SizedBox(height: 6),
                  Text(
                    x.$1,
                    style: TextStyle(
                      color: x.$4,
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    x.$2,
                    style: const TextStyle(color: Colors.white70, fontSize: 11),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _plan() {
    final p = [
      'Name the dragon — write what you fear.',
      'Cut it small — break into single moves.',
      'Pick the first move — do it before doubt arrives.',
      'Mark progress visibly — score your reps.',
      'Recover deliberately — rest is not weakness.',
    ];
    return Column(
      children: List.generate(
        p.length,
        (i) => Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _slate,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: _crimson,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    '${i + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  p[i],
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mantras() => Column(
    children: [
      _m('"Do hard things — softly."'),
      _m('"The wall is a door turned sideways."'),
      _m('"Discomfort is information, not the verdict."'),
      _m('"Win the rep, not the war."'),
    ],
  );
  Widget _m(String t) => Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: const LinearGradient(colors: [_crimson, Color(0xFF7F1D1D)]),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        const Icon(Icons.flash_on, color: _gold),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            t,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );
}

class _SwordsPainter extends CustomPainter {
  @override
  void paint(Canvas c, Size s) {
    final p = Paint()
      ..color = const Color(0xFFFBBF24).withValues(alpha: 0.3)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    c.drawLine(
      Offset(s.width * 0.2, s.height * 0.3),
      Offset(s.width * 0.5, s.height * 0.7),
      p,
    );
    c.drawLine(
      Offset(s.width * 0.5, s.height * 0.3),
      Offset(s.width * 0.2, s.height * 0.7),
      p,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter o) => false;
}
