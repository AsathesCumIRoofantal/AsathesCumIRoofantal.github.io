import 'package:flutter/material.dart';

/// CATEGORY DOCS — Unique: slate + lime "filing cabinet / archive" theme.
/// New sections: Document Health, 6 Doc Types, Filing Workflow, Compliance Tags.
class CategoryDocsView extends StatelessWidget {
  const CategoryDocsView({super.key});

  static const _bg = Color(0xFFF5F5F0);
  static const _slate = Color(0xFF263238);
  static const _lime = Color(0xFF84CC16);
  static const _amber = Color(0xFFF59E0B);
  static const _ink = Color(0xFF111418);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 220,
            backgroundColor: _slate,
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
                        colors: [_ink, _slate],
                      ),
                    ),
                  ),
                  CustomPaint(painter: _CabinetPainter()),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 70, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _lime,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: const Text(
                            '// ARCHIVE INDEX',
                            style: TextStyle(
                              color: _ink,
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'CATEGORY · DOCUMENTS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            letterSpacing: 4,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          'all paperwork, sorted, sealed, searchable',
                          style: TextStyle(
                            color: _lime.withOpacity(0.9),
                            fontSize: 12,
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
                _h('SIX DOCUMENT TYPES'),
                const SizedBox(height: 10),
                _types(),
                const SizedBox(height: 22),
                _h('FILING WORKFLOW'),
                const SizedBox(height: 10),
                _workflow(),
                const SizedBox(height: 22),
                _h('COMPLIANCE TAGS'),
                const SizedBox(height: 10),
                _tags(),
                const SizedBox(height: 22),
                _split('ORIGINAL CATEGORY DOCS CONTENT'),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _h(String t) => Row(
    children: [
      Container(width: 4, height: 22, color: _lime),
      const SizedBox(width: 10),
      Text(
        t,
        style: const TextStyle(
          color: _slate,
          fontSize: 13,
          letterSpacing: 3,
          fontWeight: FontWeight.w900,
        ),
      ),
    ],
  );

  Widget _split(String t) => Row(
    children: [
      Expanded(child: Container(height: 1, color: _slate.withOpacity(0.3))),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          t,
          style: const TextStyle(
            color: _slate,
            letterSpacing: 3,
            fontSize: 11,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      Expanded(child: Container(height: 1, color: _slate.withOpacity(0.3))),
    ],
  );

  Widget _health() => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _slate.withOpacity(0.15)),
    ),
    child: Column(
      children: [
        Row(
          children: const [
            Icon(Icons.health_and_safety, color: _lime),
            SizedBox(width: 8),
            Text(
              'ARCHIVE HEALTH',
              style: TextStyle(
                color: _slate,
                letterSpacing: 2,
                fontSize: 12,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _stat('Filed', '1,284', _lime),
            _stat('Pending', '37', _amber),
            _stat('Expiring', '8', Colors.red),
          ],
        ),
      ],
    ),
  );

  Widget _stat(String l, String v, Color c) => Expanded(
    child: Column(
      children: [
        Text(
          v,
          style: TextStyle(color: c, fontSize: 22, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 2),
        Text(
          l.toUpperCase(),
          style: const TextStyle(
            color: _slate,
            fontSize: 10,
            letterSpacing: 2,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );

  Widget _types() {
    final t = [
      ('Identity', Icons.badge, _lime),
      ('Property', Icons.home_work, _amber),
      ('Financial', Icons.account_balance, _lime),
      ('Legal', Icons.gavel, _amber),
      ('Educational', Icons.school, _lime),
      ('Medical', Icons.medical_services, _amber),
    ];
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 2.2,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      children: t
          .map(
            (x) => Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: x.$3.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: x.$3.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(x.$2, color: x.$3, size: 20),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      x.$1,
                      style: const TextStyle(
                        color: _slate,
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
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

  Widget _workflow() {
    final w = [
      ('CAPTURE', 'Scan or photograph original.'),
      ('TAG', 'Add category, owner, expiry.'),
      ('VERIFY', 'Cross-check with source authority.'),
      ('SEAL', 'Lock with hash & access policy.'),
      ('SHARE', 'Issue scoped links, log every view.'),
    ];
    return Column(
      children: List.generate(
        w.length,
        (i) => Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    color: _lime,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${i + 1}',
                      style: const TextStyle(
                        color: _ink,
                        fontWeight: FontWeight.w900,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                if (i < w.length - 1)
                  Container(
                    width: 2,
                    height: 36,
                    color: _lime.withOpacity(0.4),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _slate.withOpacity(0.15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      w[i].$1,
                      style: const TextStyle(
                        color: _slate,
                        fontWeight: FontWeight.w900,
                        fontSize: 12,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(w[i].$2, style: const TextStyle(fontSize: 13)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tags() => Wrap(
    spacing: 8,
    runSpacing: 8,
    children: [
      _tag('GDPR-OK', _lime),
      _tag('AADHAAR-LINKED', _amber),
      _tag('ARCHIVED', _slate),
      _tag('NOTARISED', _lime),
      _tag('EXPIRES <30D', Colors.red),
      _tag('PUBLIC RECORD', _amber),
      _tag('ENCRYPTED', _slate),
    ],
  );
  Widget _tag(String t, Color c) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: c.withOpacity(0.15),
      border: Border.all(color: c),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(
      t,
      style: TextStyle(
        color: c,
        fontSize: 11,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.5,
      ),
    ),
  );
}

class _CabinetPainter extends CustomPainter {
  @override
  void paint(Canvas c, Size s) {
    final p = Paint()
      ..color = const Color(0xFF84CC16).withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    for (double x = 0; x < s.width; x += 60) {
      c.drawRect(Rect.fromLTWH(x, 20, 50, 30), p);
      c.drawRect(Rect.fromLTWH(x, 60, 50, 30), p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter o) => false;
}
