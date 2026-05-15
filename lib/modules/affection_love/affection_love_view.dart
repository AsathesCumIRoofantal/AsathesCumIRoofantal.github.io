import 'package:flutter/material.dart';

/// AFFECTION & LOVE — Unique design: rose blush + cream, soft heart-arc theme.
/// New sections: Love Languages (5), Daily Acts (8), Tender Promises, Reflection prompt.
class AffectionLoveView extends StatelessWidget {
  const AffectionLoveView({Key? key}) : super(key: key);

  static const _cream = Color(0xFFFFF5F0);
  static const _rose = Color(0xFFE94B6A);
  static const _blush = Color(0xFFFCD8DA);
  static const _wine = Color(0xFF6B0F2A);
  static const _gold = Color(0xFFD4A24A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _cream,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 240,
            backgroundColor: _wine,
            foregroundColor: _cream,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [_wine, _rose, _blush],
                      ),
                    ),
                  ),
                  CustomPaint(painter: _HeartArc()),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 30),
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.white,
                            size: 34,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'AFFECTION & LOVE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 4,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'the quiet language of belonging',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
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
            padding: const EdgeInsets.all(18),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _intro(),
                const SizedBox(height: 22),
                _h('FIVE LOVE LANGUAGES'),
                const SizedBox(height: 10),
                _languages(),
                const SizedBox(height: 22),
                _h('EIGHT DAILY ACTS'),
                const SizedBox(height: 10),
                _acts(),
                const SizedBox(height: 22),
                _h('TENDER PROMISES'),
                const SizedBox(height: 10),
                _promises(),
                const SizedBox(height: 22),
                _reflection(),
                const SizedBox(height: 22),
                _split('ORIGINAL AFFECTION & LOVE CONTENT'),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _intro() => Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [BoxShadow(color: _rose.withOpacity(0.12), blurRadius: 20)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.spa, color: _rose),
            const SizedBox(width: 8),
            const Text(
              'A SOFT BEGINNING',
              style: TextStyle(
                color: _wine,
                letterSpacing: 2,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          'Love is not loud. It is the second cup of tea you pour without '
          'asking, the chair you turn slightly when someone joins, the small '
          'remembering of what they last said.',
          style: TextStyle(
            fontSize: 15,
            height: 1.55,
            color: Color(0xFF333033),
          ),
        ),
      ],
    ),
  );

  Widget _h(String t) => Row(
    children: [
      Container(width: 28, height: 2, color: _gold),
      const SizedBox(width: 8),
      Text(
        t,
        style: const TextStyle(
          color: _wine,
          fontSize: 11,
          letterSpacing: 3,
          fontWeight: FontWeight.w900,
        ),
      ),
    ],
  );

  Widget _split(String t) => Row(
    children: [
      Expanded(child: Container(height: 1, color: _rose.withOpacity(0.3))),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          t,
          style: const TextStyle(
            color: _wine,
            letterSpacing: 3,
            fontSize: 11,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      Expanded(child: Container(height: 1, color: _rose.withOpacity(0.3))),
    ],
  );

  Widget _languages() {
    final l = [
      ('Words', 'Of affirmation & gentleness.', Icons.chat_bubble),
      ('Time', 'Undivided presence, patient attention.', Icons.schedule),
      ('Touch', 'A hand held, a forehead kissed.', Icons.front_hand),
      ('Service', 'Acts that lighten their load.', Icons.volunteer_activism),
      ('Gifts', 'Small tokens chosen with care.', Icons.card_giftcard),
    ];
    return Column(
      children: l
          .map(
            (x) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _blush.withOpacity(0.4),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: _rose,
                    child: Icon(x.$3, color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          x.$1.toUpperCase(),
                          style: const TextStyle(
                            color: _wine,
                            fontWeight: FontWeight.w900,
                            fontSize: 13,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          x.$2,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF553344),
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

  Widget _acts() {
    final a = [
      'Send a "thinking of you" with no agenda.',
      'Refill water before being asked.',
      'Forward a memory, photo, or song.',
      'Compliment something nobody else noticed.',
      'Forgive a small slight without speaking of it.',
      'Ask a curious question, then truly listen.',
      'Cook the dish they crave, the way they like.',
      'End the day with one specific thank-you.',
    ];
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.7,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      children: List.generate(
        a.length,
        (i) => Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _rose.withOpacity(0.25)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${i + 1}',
                style: const TextStyle(
                  color: _gold,
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Expanded(
                child: Text(
                  a[i],
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: Color(0xFF3A2630),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _promises() {
    final p = [
      'I will be soft when you are sharp.',
      'I will be still when you are storm.',
      'I will hold the lamp when your hands are full.',
      'I will tell you the truth, kindly.',
    ];
    return Column(
      children: p
          .map(
            (t) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [_rose, _wine]),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                    size: 18,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      t,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _reflection() => Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: _gold.withOpacity(0.15),
      border: Border.all(color: _gold),
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'REFLECT',
          style: TextStyle(
            color: _wine,
            letterSpacing: 3,
            fontSize: 11,
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Who in your life has loved you in a language you didn\'t '
          'recognise at first? What did it teach you?',
          style: TextStyle(
            fontSize: 14.5,
            fontStyle: FontStyle.italic,
            height: 1.55,
            color: Color(0xFF3A2030),
          ),
        ),
      ],
    ),
  );
}

class _HeartArc extends CustomPainter {
  @override
  void paint(Canvas c, Size s) {
    final p = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    final path = Path()
      ..moveTo(0, s.height * 0.85)
      ..quadraticBezierTo(
        s.width * 0.5,
        s.height * 0.6,
        s.width,
        s.height * 0.85,
      );
    c.drawPath(path, p);
    final dot = Paint()..color = Colors.white.withOpacity(0.4);
    c.drawCircle(Offset(s.width * 0.2, s.height * 0.3), 3, dot);
    c.drawCircle(Offset(s.width * 0.8, s.height * 0.25), 3, dot);
    c.drawCircle(Offset(s.width * 0.5, s.height * 0.15), 2, dot);
  }

  @override
  bool shouldRepaint(covariant CustomPainter o) => false;
}
