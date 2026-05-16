import 'package:flutter/material.dart';

/// CATEGORY TREE — Unique: forest green "living tree / mind-map" theme.
/// New sections: Tree Health, Visual Branch Map, How to Navigate, Naming Rules.
class CategoryTreeView extends StatelessWidget {
  const CategoryTreeView({super.key});

  static const _bg = Color(0xFFF1F8F2);
  static const _forest = Color(0xFF14532D);
  static const _leaf = Color(0xFF22C55E);
  static const _bark = Color(0xFF78350F);
  static const _gold = Color(0xFFEAB308);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 220,
            backgroundColor: _forest,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [_forest, Color(0xFF166534), _leaf],
                      ),
                    ),
                  ),
                  CustomPaint(painter: _BranchesPainter()),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 30),
                        const Icon(
                          Icons.account_tree,
                          color: Colors.white,
                          size: 50,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'CATEGORY · TREE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 4,
                          ),
                        ),
                        Text(
                          'roots · trunk · branches · leaves',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.85),
                            fontSize: 11,
                            letterSpacing: 3,
                            fontWeight: FontWeight.w600,
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
                _health(),
                const SizedBox(height: 22),
                _h('VISUAL BRANCH MAP'),
                const SizedBox(height: 10),
                _branchMap(),
                const SizedBox(height: 22),
                _h('HOW TO NAVIGATE'),
                const SizedBox(height: 10),
                _navigation(),
                const SizedBox(height: 22),
                _h('NAMING RULES'),
                const SizedBox(height: 10),
                _rules(),
                const SizedBox(height: 22),
                _split('ORIGINAL CATEGORY TREE CONTENT'),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _h(String t) => Row(
    children: [
      Container(width: 4, height: 22, color: _leaf),
      const SizedBox(width: 10),
      Text(
        t,
        style: const TextStyle(
          color: _forest,
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
        child: Container(height: 1, color: _leaf.withValues(alpha: 0.4)),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          t,
          style: const TextStyle(
            color: _forest,
            letterSpacing: 3,
            fontSize: 11,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      Expanded(
        child: Container(height: 1, color: _leaf.withValues(alpha: 0.4)),
      ),
    ],
  );

  Widget _health() => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(color: _forest.withValues(alpha: 0.08), blurRadius: 12),
      ],
    ),
    child: Row(
      children: [
        _badge('7', 'ROOTS', _bark),
        _badge('28', 'BRANCHES', _forest),
        _badge('142', 'LEAVES', _leaf),
      ],
    ),
  );

  Widget _badge(String v, String l, Color c) => Expanded(
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: c.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Text(
            v,
            style: TextStyle(
              color: c,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          l,
          style: TextStyle(
            color: c,
            fontSize: 10,
            letterSpacing: 2,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    ),
  );

  Widget _branchMap() {
    final branches = ['Knowledge', 'Service', 'Records', 'Community', 'Action'];
    final leaves = [
      ['Wisdom', 'Education', 'Research'],
      ['Volunteer', 'Help', 'Donate'],
      ['Documents', 'Identity', 'Property'],
      ['Family', 'Friends', 'Groups'],
      ['Tasks', 'Goals', 'Reports'],
    ];
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _bark,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              '🌱 ROOT · ALL CATEGORIES',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 2,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 8),
          ...List.generate(
            branches.length,
            (i) => Container(
              margin: const EdgeInsets.only(top: 6),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _forest.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(8),
                border: Border(left: BorderSide(color: _forest, width: 4)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        '├ ',
                        style: TextStyle(
                          color: _forest,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        branches[i],
                        style: const TextStyle(
                          color: _forest,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: leaves[i]
                        .map(
                          (l) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: _leaf.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(99),
                            ),
                            child: Text(
                              '🍃 $l',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Color(0xFF14532D),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navigation() {
    final n = [
      ('Tap a node', 'Expands its sub-categories.', Icons.touch_app),
      ('Long-press', 'Reveals quick actions.', Icons.touch_app_outlined),
      ('Swipe right', 'Marks favourite for quick access.', Icons.bookmark),
      ('Search bar', 'Finds across all leaves instantly.', Icons.search),
    ];
    return Column(
      children: n
          .map(
            (x) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _leaf.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Icon(x.$3, color: _gold),
                  const SizedBox(width: 10),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${x.$1} — ',
                            style: const TextStyle(
                              color: _forest,
                              fontWeight: FontWeight.w900,
                              fontSize: 13,
                            ),
                          ),
                          TextSpan(
                            text: x.$2,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 13,
                            ),
                          ),
                        ],
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

  Widget _rules() {
    final r = [
      'Use lowercase, hyphenated names: family-records.',
      'Avoid abbreviations unless universally understood.',
      'Limit depth to 4 levels — anything more should be a tag.',
      'Each leaf must belong to exactly one branch.',
      'Re-org major branches no more than once per quarter.',
    ];
    return Column(
      children: r
          .map(
            (t) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Icon(Icons.eco, color: _leaf, size: 16),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      t,
                      style: const TextStyle(
                        fontSize: 13.5,
                        height: 1.5,
                        color: Color(0xFF1F2937),
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
}

class _BranchesPainter extends CustomPainter {
  @override
  void paint(Canvas c, Size s) {
    final p = Paint()
      ..color = Colors.white.withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    final cx = s.width / 2;
    final cy = s.height * 0.55;
    c.drawLine(Offset(cx, cy), Offset(cx, s.height), p);
    c.drawLine(Offset(cx, cy), Offset(cx - 60, cy - 40), p);
    c.drawLine(Offset(cx, cy), Offset(cx + 60, cy - 40), p);
    c.drawLine(Offset(cx - 60, cy - 40), Offset(cx - 90, cy - 70), p);
    c.drawLine(Offset(cx + 60, cy - 40), Offset(cx + 90, cy - 70), p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter o) => false;
}
