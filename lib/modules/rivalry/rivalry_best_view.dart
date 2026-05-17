import 'package:flutter/material.dart';

/// DESIGN: Versus/Battle Split Screen — two-sided competitive comparison cards
class RivalryBestView extends StatelessWidget {
  const RivalryBestView({super.key});

  static const _blue = Color(0xFF1D4ED8);
  static const _red = Color(0xFFDC2626);
  static const _amber = Color(0xFFF59E0B);
  static const _green = Color(0xFF10B981);
  static const _violet = Color(0xFF7C3AED);
  static const _teal = Color(0xFF0D9488);
  static const _bg = Color(0xFF050510);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: const Text('RIVALRY INTELLIGENCE', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 13, color: Colors.white)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 14), child: Icon(Icons.compare_arrows_rounded, color: _amber, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        children: [
          // HERO VERSUS
          Container(
            height: 140, decoration: BoxDecoration(
              gradient: LinearGradient(colors: [_blue.withOpacity(0.12), const Color(0xFF080810), _red.withOpacity(0.12)], begin: Alignment.centerLeft, end: Alignment.centerRight),
              borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white.withOpacity(0.08)),
            ),
            child: Row(children: [
              Expanded(child: Container(padding: const EdgeInsets.all(16), child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                Icon(Icons.psychology_rounded, color: _blue, size: 32),
                const SizedBox(height: 6),
                Text('CONSTRUCTIVE\nRIVALRY', textAlign: TextAlign.center, style: TextStyle(color: _blue, fontSize: 11, fontWeight: FontWeight.w900, height: 1.2)),
              ]))),
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [_blue.withOpacity(0.2), _red.withOpacity(0.2)]), border: Border.all(color: Colors.white.withOpacity(0.15))),
                child: const Center(child: Text('VS', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w900))),
              ),
              Expanded(child: Container(padding: const EdgeInsets.all(16), child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                Icon(Icons.warning_rounded, color: _red, size: 32),
                const SizedBox(height: 6),
                Text('DESTRUCTIVE\nRIVALRY', textAlign: TextAlign.center, style: TextStyle(color: _red, fontSize: 11, fontWeight: FontWeight.w900, height: 1.2)),
              ]))),
            ]),
          ),
          const SizedBox(height: 20),
          // VS COMPARISON ROWS
          _SecHead('RIVALRY SPECTRUM', _amber),
          const SizedBox(height: 12),
          ...[
            ('Focused on growth', 'Focused on defeating', 'Motivation Source'),
            ('Raises your standard', 'Lowers your character', 'Primary Effect'),
            ('Broadens your skills', 'Narrows your focus', 'Capability Impact'),
            ('Sustainable long-term', 'Corrosive over time', 'Durability'),
            ('Mutual respect', 'Contempt or resentment', 'Relationship Quality'),
          ].map((r) => _VsRow(left: r.$1, right: r.$2, label: r.$3)),
          const SizedBox(height: 20),
          _SecHead('RIVALRY INTELLIGENCE TOOLS', _teal),
          const SizedBox(height: 12),
          _RivCard(color: _blue, icon: Icons.leaderboard_rounded, title: 'Competitive Benchmarking',
              body: 'Track your key rivals\' capabilities, strategies, and market positions systematically. Effective competitive intelligence is not about fear or obsession — it is about using external comparison as a calibration tool for your own development targets.'),
          const SizedBox(height: 8),
          _RivCard(color: _teal, icon: Icons.psychology_rounded, title: 'Productive Competitive Energy',
              body: 'Channel competitive energy into performance improvement rather than into undermining others. The athlete who trains harder when they see a faster competitor is using rivalry productively; the one who tries to sabotage the faster runner is wasting energy on destruction.'),
          const SizedBox(height: 8),
          _RivCard(color: _violet, icon: Icons.people_rounded, title: 'Converting Rivals to Allies',
              body: 'Some of the most powerful professional relationships begin as competitive ones. The person who beats you consistently in a domain often has precisely the complementary skills you lack. Rivalry, resolved with maturity, can become the foundation of a powerful partnership.'),
          const SizedBox(height: 8),
          _RivCard(color: _amber, icon: Icons.balance_rounded, title: 'The Internal Rival',
              body: 'The most productive rivalry is with your own previous performance. The standard set by yesterday\'s work, last quarter\'s results, or last year\'s achievement is the cleanest possible competitive benchmark — it is entirely within your control to close and it never resorts to sabotage.'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [_blue.withOpacity(0.08), _red.withOpacity(0.05)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: _amber.withOpacity(0.18))),
            child: Row(children: [
              Icon(Icons.format_quote_rounded, color: _amber, size: 26), const SizedBox(width: 12),
              const Expanded(child: Text('"Iron sharpens iron, and one person sharpens another." — Proverbs 27:17', style: TextStyle(color: Colors.white, fontSize: 13, height: 1.4, fontStyle: FontStyle.italic))),
            ]),
          ),
        ],
      ),
    );
  }
}

class _VsRow extends StatelessWidget {
  final String left, right, label;
  const _VsRow({required this.left, required this.right, required this.label});
  static const _blue = Color(0xFF1D4ED8);
  static const _red = Color(0xFFDC2626);
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 8),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.white.withOpacity(0.06))),
    child: Column(children: [
      Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5), decoration: BoxDecoration(color: Colors.white.withOpacity(0.04), borderRadius: const BorderRadius.vertical(top: Radius.circular(9))),
        child: Center(child: Text(label.toUpperCase(), style: const TextStyle(color: Colors.white30, fontSize: 8, fontWeight: FontWeight.w800, letterSpacing: 1)))),
      Row(children: [
        Expanded(child: Container(padding: const EdgeInsets.all(10), color: _blue.withOpacity(0.05), child: Text(left, textAlign: TextAlign.center, style: TextStyle(color: _blue.withOpacity(0.9), fontSize: 11, fontWeight: FontWeight.w600)))),
        Container(width: 1, height: 30, color: Colors.white.withOpacity(0.06)),
        Expanded(child: Container(padding: const EdgeInsets.all(10), color: _red.withOpacity(0.05), child: Text(right, textAlign: TextAlign.center, style: TextStyle(color: _red.withOpacity(0.9), fontSize: 11, fontWeight: FontWeight.w600)))),
      ]),
    ]),
  );
}

class _SecHead extends StatelessWidget {
  final String text; final Color color;
  const _SecHead(this.text, this.color);
  @override
  Widget build(BuildContext context) => Row(children: [Container(width: 3, height: 14, color: color), const SizedBox(width: 8), Text(text, style: TextStyle(color: color.withOpacity(0.85), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2))]);
}

class _RivCard extends StatelessWidget {
  final Color color; final IconData icon; final String title, body;
  const _RivCard({required this.color, required this.icon, required this.title, required this.body});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(13), decoration: BoxDecoration(color: color.withOpacity(0.07), borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withOpacity(0.18))),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(padding: const EdgeInsets.all(7), decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(9)), child: Icon(icon, color: color, size: 15)),
      const SizedBox(width: 10),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w800)),
        const SizedBox(height: 4),
        Text(body, style: const TextStyle(color: Colors.white54, fontSize: 11, height: 1.4)),
      ])),
    ]),
  );
}
