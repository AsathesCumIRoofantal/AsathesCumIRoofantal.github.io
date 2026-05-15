import 'package:flutter/material.dart';

/// ABOUT ORG — Unique design: warm parchment + ink, civic crest theme.
/// New sections: Mission Crest, Values Hexagon, Org Numbers, Leadership Voices.
class AboutOrgView extends StatelessWidget {
  const AboutOrgView({Key? key}) : super(key: key);

  static const _ink = Color(0xFF1F1A14);
  static const _paper = Color(0xFFFBF6EC);
  static const _gold = Color(0xFFB8860B);
  static const _wine = Color(0xFF7B1F2A);
  static const _moss = Color(0xFF4A6741);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _paper,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 260,
            backgroundColor: _ink,
            foregroundColor: _paper,
            flexibleSpace: FlexibleSpaceBar(background: _crest()),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(18),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _mission(),
                const SizedBox(height: 22),
                _eyebrow('VALUES'),
                const SizedBox(height: 10),
                _valuesGrid(),
                const SizedBox(height: 22),
                _eyebrow('ORG IN NUMBERS'),
                const SizedBox(height: 10),
                _numbers(),
                const SizedBox(height: 22),
                _eyebrow('VOICES'),
                const SizedBox(height: 10),
                _voices(),
                const SizedBox(height: 26),
                _ornament('Original Charter'),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _crest() => Stack(
    fit: StackFit.expand,
    children: [
      Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [_ink, Color(0xFF2E2418)],
          ),
        ),
      ),
      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 30),
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                border: Border.all(color: _gold, width: 2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.account_balance, color: _gold, size: 36),
            ),
            const SizedBox(height: 10),
            const Text(
              'ABOUT THE ORGANISATION',
              style: TextStyle(
                color: _paper,
                letterSpacing: 3,
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 6),
            Container(width: 60, height: 1, color: _gold),
            const SizedBox(height: 6),
            const Text(
              '— EST. STRUCTURE & PURPOSE —',
              style: TextStyle(
                color: _gold,
                letterSpacing: 4,
                fontSize: 9,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    ],
  );

  Widget _eyebrow(String t) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(width: 24, height: 1, color: _gold),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          t,
          style: const TextStyle(
            color: _wine,
            letterSpacing: 4,
            fontSize: 12,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      Container(width: 24, height: 1, color: _gold),
    ],
  );

  Widget _ornament(String t) => Center(
    child: Column(
      children: [
        const Icon(Icons.diamond_outlined, color: _gold, size: 16),
        const SizedBox(height: 4),
        Text(
          t.toUpperCase(),
          style: const TextStyle(
            color: _ink,
            letterSpacing: 5,
            fontSize: 11,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        Container(width: 80, height: 1, color: _gold),
      ],
    ),
  );

  Widget _mission() => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: _gold.withOpacity(0.4)),
      borderRadius: BorderRadius.circular(4),
      boxShadow: [
        BoxShadow(
          color: _ink.withOpacity(0.08),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Mission',
          style: TextStyle(
            color: _wine,
            fontSize: 13,
            letterSpacing: 3,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'To gather knowledge, coordinate service, and uphold dignity '
          'for every person in reach — through transparent process, shared '
          'records, and a culture of patient, principled action.',
          style: TextStyle(color: _ink, fontSize: 15, height: 1.55),
        ),
        SizedBox(height: 14),
        Text(
          'Vision',
          style: TextStyle(
            color: _wine,
            fontSize: 13,
            letterSpacing: 3,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'A connected society where information serves people, not the '
          'other way around — and where every member can contribute, learn, '
          'and be heard.',
          style: TextStyle(color: _ink, fontSize: 15, height: 1.55),
        ),
      ],
    ),
  );

  Widget _valuesGrid() {
    final v = [
      ('Truth', Icons.verified, _wine),
      ('Service', Icons.volunteer_activism, _moss),
      ('Discipline', Icons.gavel, _gold),
      ('Inclusion', Icons.diversity_3, _wine),
      ('Transparency', Icons.visibility, _moss),
      ('Continuity', Icons.all_inclusive, _gold),
    ];
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 0.95,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      children: v
          .map(
            (x) => Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: x.$3.withOpacity(0.4)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(x.$2, color: x.$3, size: 26),
                  const SizedBox(height: 6),
                  Text(
                    x.$1,
                    style: TextStyle(
                      color: x.$3,
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _numbers() {
    final n = [
      ('14+', 'Years'),
      ('120+', 'Modules'),
      ('5', 'Languages'),
      ('∞', 'Goal'),
    ];
    return Row(
      children: n
          .map(
            (x) => Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: _ink,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  children: [
                    Text(
                      x.$1,
                      style: const TextStyle(
                        color: _gold,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      x.$2.toUpperCase(),
                      style: const TextStyle(
                        color: _paper,
                        fontSize: 9,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _voices() {
    final v = [
      ('"We do not chase relevance — we cultivate it."', '— Founder'),
      ('"Records outlast rhetoric."', '— Operations Lead'),
      ('"Service is the only sustainable scale."', '— Community Head'),
    ];
    return Column(
      children: v
          .map(
            (x) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(left: BorderSide(color: _gold, width: 3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    x.$1,
                    style: TextStyle(
                      color: _ink,
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    x.$2,
                    style: const TextStyle(
                      color: _wine,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
