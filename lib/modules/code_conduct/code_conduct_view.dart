import 'package:flutter/material.dart';

/// CODE OF CONDUCT — Unique: navy + ivory "civic charter / seal" theme.
/// New sections: Charter Seal, 7 Conduct Principles, Do/Don't matrix, Reporting & Recourse.
class CodeConductView extends StatelessWidget {
  const CodeConductView({super.key});

  static const _ivory = Color(0xFFF8F4E9);
  static const _navy = Color(0xFF0B1B3A);
  static const _gold = Color(0xFFC9A24C);
  static const _wine = Color(0xFF7F1D1D);
  static const _moss = Color(0xFF4D7C0F);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _ivory,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 250,
            backgroundColor: _navy,
            foregroundColor: _ivory,
            flexibleSpace: FlexibleSpaceBar(background: _seal()),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(18),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _preamble(),
                const SizedBox(height: 24),
                _h('SEVEN PRINCIPLES'),
                const SizedBox(height: 10),
                _principles(),
                const SizedBox(height: 24),
                _h('DO & DO NOT'),
                const SizedBox(height: 10),
                _matrix(),
                const SizedBox(height: 24),
                _h('REPORTING & RECOURSE'),
                const SizedBox(height: 10),
                _reporting(),
                const SizedBox(height: 24),
                _split('ORIGINAL CODE OF CONDUCT'),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _seal() => Stack(
    fit: StackFit.expand,
    children: [
      Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [_navy, Color(0xFF1E3A8A)],
          ),
        ),
      ),
      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 30),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: _gold, width: 2),
                  ),
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: _gold, width: 1),
                  ),
                ),
                const Icon(Icons.gavel, color: _gold, size: 40),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'CODE OF CONDUCT',
              style: TextStyle(
                color: _ivory,
                fontSize: 18,
                fontWeight: FontWeight.w900,
                letterSpacing: 4,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '— THE PUBLIC CHARTER —',
              style: TextStyle(
                color: _gold,
                fontSize: 10,
                letterSpacing: 4,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    ],
  );

  Widget _h(String t) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(width: 24, height: 1, color: _gold),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          t,
          style: const TextStyle(
            color: _navy,
            letterSpacing: 4,
            fontSize: 12,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      Container(width: 24, height: 1, color: _gold),
    ],
  );

  Widget _split(String t) => Row(
    children: [
      Expanded(
        child: Container(height: 1, color: _navy.withValues(alpha: 0.3)),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          t,
          style: const TextStyle(
            color: _navy,
            letterSpacing: 3,
            fontSize: 11,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      Expanded(
        child: Container(height: 1, color: _navy.withValues(alpha: 0.3)),
      ),
    ],
  );

  Widget _preamble() => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: _gold.withValues(alpha: 0.4)),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'PREAMBLE',
          style: TextStyle(
            color: _wine,
            letterSpacing: 4,
            fontSize: 11,
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'We, the members of this community, agree to a public standard '
          'of conduct — that our conduct toward one another, in word and deed, '
          'shall reflect the dignity, fairness, and patience we would wish '
          'shown to ourselves.',
          style: TextStyle(
            color: _navy,
            fontSize: 14.5,
            height: 1.6,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );

  Widget _principles() {
    final p = [
      ('Respect', 'Address persons, never their dignity.'),
      ('Honesty', 'Speak truth even when it inconveniences us.'),
      ('Fairness', 'Apply the same standard to friend and stranger.'),
      ('Accountability', 'Own outcomes — including the unintended.'),
      ('Confidentiality', 'Hold what was shared in trust, in trust.'),
      ('Inclusion', 'Make room before being asked.'),
      ('Integrity', 'Act the same when no one is watching.'),
    ];
    return Column(
      children: List.generate(
        p.length,
        (i) => Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: _navy.withValues(alpha: 0.15)),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: _navy,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(
                    '${i + 1}',
                    style: const TextStyle(
                      color: _gold,
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      p[i].$1.toUpperCase(),
                      style: const TextStyle(
                        color: _navy,
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      p[i].$2,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF374151),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _matrix() => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: _col('DO', _moss, [
          'Speak directly, kindly.',
          'Cite sources where known.',
          'Make space for new voices.',
          'Apologise specifically.',
        ]),
      ),
      const SizedBox(width: 8),
      Expanded(
        child: _col('DON\'T', _wine, [
          'Mock, belittle, or shame.',
          'Share private detail publicly.',
          'Speak over those still arriving.',
          'Apologise vaguely & move on.',
        ]),
      ),
    ],
  );

  Widget _col(String t, Color c, List<String> items) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(top: BorderSide(color: c, width: 4)),
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t,
          style: TextStyle(
            color: c,
            fontSize: 14,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 8),
        ...items.map(
          (i) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  t == 'DO' ? Icons.check_circle : Icons.cancel,
                  color: c,
                  size: 14,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    i,
                    style: const TextStyle(fontSize: 12, height: 1.4),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  Widget _reporting() => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _navy,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.shield, color: _gold, size: 20),
            SizedBox(width: 8),
            Text(
              'IF SOMETHING IS WRONG',
              style: TextStyle(
                color: _gold,
                letterSpacing: 2,
                fontSize: 12,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          '1. Document what happened, when, and who saw it.\n'
          '2. Tell a steward — confidentially, without fear of reprisal.\n'
          '3. The steward will acknowledge within 48 hours.\n'
          '4. A panel reviews — both sides heard, dignity preserved.\n'
          '5. Outcome is recorded and, where appropriate, made public.',
          style: TextStyle(color: Colors.white, fontSize: 13, height: 1.7),
        ),
      ],
    ),
  );
}
