import 'dart:math' as math;
import 'package:flutter/material.dart';

/// APPRECIATIONS & THANKS — Unique: amber sunrise + cream "gratitude card" theme.
/// New sections: Today's Thank-You, Gratitude Wall, 7 Forms of Thanks, Pay-It-Forward ladder.
class AppreciationsThanksView extends StatelessWidget {
  const AppreciationsThanksView({Key? key}) : super(key: key);

  static const _cream = Color(0xFFFFFBF0);
  static const _amber = Color(0xFFF59E0B);
  static const _sun = Color(0xFFFBBF24);
  static const _coffee = Color(0xFF3D2817);
  static const _moss = Color(0xFF65A30D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _cream,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 230,
            backgroundColor: _amber,
            foregroundColor: _coffee,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [_sun, _amber, Color(0xFFEA580C)],
                      ),
                    ),
                  ),
                  CustomPaint(painter: _RaysPainter()),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 30),
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 16,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.emoji_events,
                            color: _amber,
                            size: 36,
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          'APPRECIATIONS & THANKS',
                          style: TextStyle(
                            color: _coffee,
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 3,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'a culture of acknowledgement',
                          style: TextStyle(
                            color: _coffee,
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
                _todaysCard(),
                const SizedBox(height: 22),
                _h('GRATITUDE WALL'),
                const SizedBox(height: 10),
                _wall(),
                const SizedBox(height: 22),
                _h('SEVEN FORMS OF THANKS'),
                const SizedBox(height: 10),
                _forms(),
                const SizedBox(height: 22),
                _h('PAY IT FORWARD'),
                const SizedBox(height: 10),
                _ladder(),
                const SizedBox(height: 22),
                _split('ORIGINAL APPRECIATIONS CONTENT'),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _h(String t) => Row(
    children: [
      Container(width: 4, height: 22, color: _amber),
      const SizedBox(width: 10),
      Text(
        t,
        style: const TextStyle(
          color: _coffee,
          fontSize: 13,
          letterSpacing: 3,
          fontWeight: FontWeight.w900,
        ),
      ),
    ],
  );

  Widget _split(String t) => Row(
    children: [
      Expanded(child: Container(height: 1, color: _amber.withOpacity(0.4))),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          t,
          style: const TextStyle(
            color: _coffee,
            letterSpacing: 3,
            fontSize: 11,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      Expanded(child: Container(height: 1, color: _amber.withOpacity(0.4))),
    ],
  );

  Widget _todaysCard() => Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: _amber.withOpacity(0.5)),
      boxShadow: [BoxShadow(color: _amber.withOpacity(0.2), blurRadius: 20)],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'TODAY\'S THANK-YOU',
          style: TextStyle(
            color: _amber,
            letterSpacing: 3,
            fontSize: 11,
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Name one person who carried something for you this week.\n'
          'Tell them — by voice, by note, by deed. Specifics over generics.',
          style: TextStyle(color: _coffee, fontSize: 15, height: 1.55),
        ),
      ],
    ),
  );

  Widget _wall() => Wrap(
    spacing: 8,
    runSpacing: 8,
    children: [
      _stickyNote(
        'To the elders who held the door open while we caught up.',
        _sun,
      ),
      _stickyNote(
        'To friends who stayed when it would have been easier to leave.',
        _moss,
      ),
      _stickyNote(
        'To strangers whose small kindness changed an ordinary day.',
        _amber,
      ),
      _stickyNote(
        'To teachers who corrected us patiently, twice, gently.',
        _sun,
      ),
      _stickyNote('To family who learned new words for old feelings.', _moss),
      _stickyNote(
        'To rivals who pushed us to be sharper, fairer, better.',
        _amber,
      ),
    ],
  );

  Widget _stickyNote(String t, Color c) => Container(
    width: 160,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: c.withOpacity(0.25),
      border: Border.all(color: c),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(2),
        topRight: Radius.circular(2),
        bottomLeft: Radius.circular(12),
        bottomRight: Radius.circular(2),
      ),
    ),
    child: Text(
      t,
      style: const TextStyle(
        fontSize: 12,
        height: 1.4,
        color: _coffee,
        fontStyle: FontStyle.italic,
      ),
    ),
  );

  Widget _forms() {
    final f = [
      ('Spoken', 'A clear, witnessed thank-you.', Icons.record_voice_over),
      (
        'Written',
        'A note that can be re-read in lonely hours.',
        Icons.edit_note,
      ),
      ('Acted', 'Repaying with something they need.', Icons.handyman),
      ('Public', 'Credited where their peers can hear it.', Icons.campaign),
      ('Private', 'Quiet, between only the two of you.', Icons.lock),
      (
        'Material',
        'A token chosen with thought, not size.',
        Icons.card_giftcard,
      ),
      (
        'Continued',
        'Remembered months later, unprompted.',
        Icons.all_inclusive,
      ),
    ];
    return Column(
      children: f
          .map(
            (x) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border(left: BorderSide(color: _amber, width: 4)),
              ),
              child: Row(
                children: [
                  Icon(x.$3, color: _amber, size: 22),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          x.$1.toUpperCase(),
                          style: const TextStyle(
                            color: _coffee,
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          x.$2,
                          style: const TextStyle(
                            fontSize: 12.5,
                            color: _coffee,
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

  Widget _ladder() {
    final l = [
      'Receive thanks gracefully — no deflection.',
      'Pause to name what made it land.',
      'Find someone you can thank similarly today.',
      'Tell them why their work matters beyond the task.',
    ];
    return Column(
      children: List.generate(
        l.length,
        (i) => Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _sun.withOpacity(0.2 + i * 0.15),
                _amber.withOpacity(0.2 + i * 0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  color: _coffee,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${i + 1}',
                    style: const TextStyle(
                      color: _sun,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  l[i],
                  style: const TextStyle(color: _coffee, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RaysPainter extends CustomPainter {
  @override
  void paint(Canvas c, Size s) {
    final p = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..strokeWidth = 1.5;
    final cx = s.width * 0.5;
    final cy = s.height * 0.4;
    for (int i = 0; i < 18; i++) {
      final a = (i / 18) * 2 * math.pi;
      c.drawLine(
        Offset(cx, cy),
        Offset(cx + 200 * math.cos(a), cy + 200 * math.sin(a)),
        p,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter o) => false;
}
