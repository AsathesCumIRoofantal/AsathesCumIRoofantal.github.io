import 'package:flutter/material.dart';

/// ABOUT APP — Unique design: dark indigo + cyan terminal/dossier theme.
/// New sections added: App Identity Card, Capability Matrix (8 features),
/// Architecture Pillars, Roadmap timeline. Original content preserved below.
class AboutAppView extends StatelessWidget {
  const AboutAppView({Key? key}) : super(key: key);

  static const _bg = Color(0xFF050814);
  static const _panel = Color(0xFF0B1226);
  static const _cyan = Color(0xFF22D3EE);
  static const _violet = Color(0xFF8B5CF6);
  static const _amber = Color(0xFFF59E0B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 220,
            backgroundColor: _bg,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [_bg, _panel, Color(0xFF1E1B4B)],
                      ),
                    ),
                  ),
                  CustomPaint(painter: _GridPainter()),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 70, 20, 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: _cyan,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'SYSTEM:ACTIVE',
                              style: TextStyle(
                                color: _cyan,
                                fontSize: 11,
                                letterSpacing: 2,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'ABOUT THIS APP',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 3,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '// dossier · build manifest · v1.0',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 12,
                            fontFamily: 'monospace',
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
                _identityCard(),
                const SizedBox(height: 18),
                _eyebrow('CAPABILITY MATRIX', _cyan),
                const SizedBox(height: 10),
                _capabilityGrid(),
                const SizedBox(height: 22),
                _eyebrow('ARCHITECTURE PILLARS', _violet),
                const SizedBox(height: 10),
                _pillars(),
                const SizedBox(height: 22),
                _eyebrow('ROADMAP', _amber),
                const SizedBox(height: 10),
                _roadmap(),
                const SizedBox(height: 28),
                _divider('ORIGINAL DOSSIER'),
                const SizedBox(height: 8),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _eyebrow(String t, Color c) => Row(
    children: [
      Container(width: 28, height: 2, color: c),
      const SizedBox(width: 8),
      Text(
        t,
        style: TextStyle(
          color: c,
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 2,
        ),
      ),
    ],
  );

  Widget _divider(String t) => Row(
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
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      Expanded(child: Container(height: 1, color: Colors.white24)),
    ],
  );

  Widget _identityCard() => Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: _panel,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _cyan.withOpacity(0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [_cyan, _violet]),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.hub, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AIR — All In Reach',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'A people-first knowledge & action platform',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _chip('Open', _cyan),
            _chip('Modular', _violet),
            _chip('Bilingual', _amber),
            _chip('Offline-aware', _cyan),
          ],
        ),
      ],
    ),
  );

  Widget _chip(String t, Color c) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: c.withOpacity(0.15),
      border: Border.all(color: c.withOpacity(0.5)),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      t,
      style: TextStyle(color: c, fontSize: 11, fontWeight: FontWeight.w700),
    ),
  );

  Widget _capabilityGrid() {
    final caps = [
      ('Knowledge Centre', Icons.menu_book, _cyan),
      ('Voice & Vision', Icons.record_voice_over, _violet),
      ('Service Tracking', Icons.track_changes, _amber),
      ('Community Pulse', Icons.groups, _cyan),
      ('Records Vault', Icons.shield, _violet),
      ('Quick Actions', Icons.bolt, _amber),
      ('Multi-language', Icons.translate, _cyan),
      ('Daily Inspiration', Icons.auto_awesome, _violet),
    ];
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.4,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: caps
          .map(
            (c) => Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _panel,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: c.$3.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(c.$2, color: c.$3, size: 24),
                  Text(
                    c.$1,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _pillars() {
    final p = [
      ('FLUTTER', 'Single codebase, every device.', _cyan),
      ('GETX', 'Reactive state, simple routing.', _violet),
      ('MODULAR', '140+ feature modules, isolated.', _amber),
      ('THEMED', 'Dark/light, palette per page.', _cyan),
    ];
    return Column(
      children: p
          .map(
            (x) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _panel,
                borderRadius: BorderRadius.circular(10),
                border: Border(left: BorderSide(color: x.$3, width: 4)),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 90,
                    child: Text(
                      x.$1,
                      style: TextStyle(
                        color: x.$3,
                        fontWeight: FontWeight.w900,
                        fontSize: 12,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      x.$2,
                      style: const TextStyle(
                        color: Colors.white70,
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

  Widget _roadmap() {
    final r = [
      ('Q1', 'Knowledge centre + bilingual UX', true),
      ('Q2', 'Service tracking & community pulse', true),
      ('Q3', 'Records vault + offline mode', false),
      ('Q4', 'AI assistant + smart recommendations', false),
    ];
    return Column(
      children: r
          .map(
            (x) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _panel,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white12),
              ),
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: x.$3 ? _cyan.withOpacity(0.2) : Colors.white10,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        x.$1,
                        style: TextStyle(
                          color: x.$3 ? _cyan : Colors.white54,
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      x.$2,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13.5,
                      ),
                    ),
                  ),
                  Icon(
                    x.$3 ? Icons.check_circle : Icons.schedule,
                    color: x.$3 ? _cyan : Colors.white38,
                    size: 18,
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = const Color(0xFF22D3EE).withOpacity(0.12)
      ..strokeWidth = 0.5;
    for (double x = 0; x < size.width; x += 24) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    }
    for (double y = 0; y < size.height; y += 24) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter o) => false;
}
