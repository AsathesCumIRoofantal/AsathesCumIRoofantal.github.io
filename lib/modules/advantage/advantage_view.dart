import 'package:flutter/material.dart';

/// ADVANTAGE — Unique design: emerald + gold "leverage / lever" theme.
/// New sections: Edge Quotient meter, 6 Strategic Edges, Compounding Steps, Risks-vs-Rewards.
class AdvantageView extends StatelessWidget {
  const AdvantageView({Key? key}) : super(key: key);

  static const _bg = Color(0xFF02140C);
  static const _emerald = Color(0xFF10B981);
  static const _gold = Color(0xFFF5C542);
  static const _ink = Color(0xFF0A1F18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 230,
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
                        colors: [_bg, _ink, Color(0xFF064E3B)],
                      ),
                    ),
                  ),
                  CustomPaint(painter: _LeverPainter()),
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
                            color: _gold,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'LEVERAGE · POSITION · TIMING',
                            style: TextStyle(
                              color: _bg,
                              fontSize: 10,
                              letterSpacing: 2,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'ADVANTAGE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 6,
                          ),
                        ),
                        Text(
                          'the quiet edge that compounds',
                          style: TextStyle(
                            color: _emerald,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
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
                _meter(),
                const SizedBox(height: 22),
                _h('SIX STRATEGIC EDGES'),
                const SizedBox(height: 10),
                _edges(),
                const SizedBox(height: 22),
                _h('COMPOUNDING STEPS'),
                const SizedBox(height: 10),
                _steps(),
                const SizedBox(height: 22),
                _h('TRADE-OFFS'),
                const SizedBox(height: 10),
                _tradeoffs(),
                const SizedBox(height: 24),
                _split('ORIGINAL ADVANTAGE CONTENT'),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _h(String t) => Row(
    children: [
      Container(width: 4, height: 22, color: _gold),
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
      Expanded(child: Container(height: 1, color: _emerald.withOpacity(0.4))),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          t,
          style: const TextStyle(
            color: _emerald,
            fontSize: 11,
            fontWeight: FontWeight.w900,
            letterSpacing: 3,
          ),
        ),
      ),
      Expanded(child: Container(height: 1, color: _emerald.withOpacity(0.4))),
    ],
  );

  Widget _meter() => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _ink,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _emerald.withOpacity(0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'YOUR EDGE QUOTIENT',
              style: TextStyle(
                color: Colors.white70,
                letterSpacing: 2,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '72 / 100',
              style: TextStyle(
                color: _gold,
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(99),
          child: const LinearProgressIndicator(
            value: 0.72,
            minHeight: 10,
            backgroundColor: Colors.white12,
            valueColor: AlwaysStoppedAnimation(_emerald),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'You\'re ahead in clarity & timing — strengthen network depth and capital.',
          style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.5),
        ),
      ],
    ),
  );

  Widget _edges() {
    final e = [
      ('Information', 'Know first, decide first.', Icons.insights),
      ('Skill', 'Practiced craft, hard to copy.', Icons.handyman),
      ('Network', 'Trust paths others lack.', Icons.share),
      ('Capital', 'Patient resources.', Icons.savings),
      ('Timing', 'Right move, right hour.', Icons.schedule),
      ('Reputation', 'Credit earned across years.', Icons.verified),
    ];
    return Column(
      children: e
          .map(
            (x) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _ink,
                borderRadius: BorderRadius.circular(12),
                border: Border(left: BorderSide(color: _emerald, width: 4)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: _emerald.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(x.$3, color: _emerald),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          x.$1.toUpperCase(),
                          style: const TextStyle(
                            color: _gold,
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          x.$2,
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

  Widget _steps() {
    final s = [
      'Identify your one true edge.',
      'Protect it from noise & dilution.',
      'Re-invest gains into the same edge.',
      'Compound for 1000 days.',
    ];
    return Column(
      children: List.generate(
        s.length,
        (i) => Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _ink,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  color: _gold,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${i + 1}',
                    style: const TextStyle(
                      color: _bg,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  s[i],
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tradeoffs() => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _ink,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        _tRow('Speed', 'Stability'),
        _tRow('Breadth', 'Depth'),
        _tRow('Visibility', 'Privacy'),
        _tRow('Solo control', 'Shared scale'),
      ],
    ),
  );
  Widget _tRow(String a, String b) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Expanded(
          child: Text(
            a,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: _emerald,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text('⇄', style: TextStyle(color: _gold, fontSize: 18)),
        ),
        Expanded(
          child: Text(
            b,
            style: const TextStyle(color: _gold, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    ),
  );
}

class _LeverPainter extends CustomPainter {
  @override
  void paint(Canvas c, Size s) {
    final p = Paint()
      ..color = const Color(0xFFF5C542).withOpacity(0.25)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    c.drawLine(Offset(0, s.height * 0.7), Offset(s.width, s.height * 0.4), p);
    c.drawCircle(Offset(s.width * 0.4, s.height * 0.58), 14, p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter o) => false;
}
