import 'package:flutter/material.dart';

/// DESIGN: Love Language Cards — five love languages with interactive visual cards
class AffectionLoveBestView extends StatelessWidget {
  const AffectionLoveBestView({super.key});

  static const _rose = Color(0xFFF43F5E);
  static const _pink = Color(0xFFEC4899);
  static const _violet = Color(0xFF7C3AED);
  static const _amber = Color(0xFFF59E0B);
  static const _red = Color(0xFFDC2626);
  static const _bg = Color(0xFF0A0010);

  @override
  Widget build(BuildContext context) {
    final languages = [
      _LoveLang(icon: Icons.volunteer_activism_rounded, color: _rose, lang: 'Words of Affirmation', score: 0.88, desc: 'Verbal expressions of love, appreciation, and encouragement. The person whose primary love language is Words needs to hear "I love you", specific praise, and verbal gratitude to feel loved.', examples: ['Daily genuine compliments', 'Written notes of appreciation', 'Public acknowledgement', 'Verbal encouragement']),
      _LoveLang(icon: Icons.timer_rounded, color: _violet, lang: 'Quality Time', score: 0.72, desc: 'Undivided, focused attention — not just being in the same room but being fully present. The person who speaks this language feels loved when you are completely with them, phone away, eyes connected.', examples: ['Screen-free dinners', 'Shared activities', 'Long walks', 'Undistracted conversation']),
      _LoveLang(icon: Icons.redeem_rounded, color: _amber, lang: 'Receiving Gifts', score: 0.61, desc: 'Not materialism — it\'s about the symbolism of the gift as an expression of thought. The perfect gift says "I was thinking of you, I know you, and I took the time to show it." Presence in absence.', examples: ['Thoughtful small gifts', 'Meaningful souvenirs', 'Surprises "just because"', 'Remembering what matters']),
      _LoveLang(icon: Icons.handshake_rounded, color: _pink, lang: 'Acts of Service', score: 0.94, desc: 'Doing helpful things — not because you have to, but as a free gift. The person who values this language feels most loved when burdens are lightened without being asked and when promises about tasks are kept.', examples: ['Proactive help with tasks', 'Keeping domestic promises', 'Noticing and acting', 'Running errands']),
      _LoveLang(icon: Icons.touch_app_rounded, color: _red, lang: 'Physical Touch', score: 0.79, desc: 'Appropriate physical connection — holding hands, hugs, a hand on the shoulder — as communication of love and safety. The person who speaks this language feels disconnected and unloved without regular, appropriate touch.', examples: ['Greeting hugs', 'Hand-holding', 'Shoulder touch', 'Comforting presence']),
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: const Text('AFFECTION & LOVE', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 13, color: Colors.white)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 14), child: Icon(Icons.favorite_rounded, color: _rose, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        children: [
          Container(
            padding: const EdgeInsets.all(18), decoration: BoxDecoration(
              gradient: LinearGradient(colors: [const Color(0xFF1A0020), const Color(0xFF08000E)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(20), border: Border.all(color: _rose.withOpacity(0.3)),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('LOVE LANGUAGE INTELLIGENCE', style: TextStyle(color: _rose, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 2)),
              const SizedBox(height: 8),
              const Text('Understanding how each person gives and receives love is the single highest-leverage relationship skill you can develop.', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700, height: 1.3)),
              const SizedBox(height: 12),
              Row(children: [
                Icon(Icons.info_outline_rounded, color: _violet.withOpacity(0.7), size: 14),
                const SizedBox(width: 6),
                Expanded(child: Text('Score bars show YOUR primary language strengths. Your partner\'s profile may be different — discover and compare.', style: TextStyle(color: Colors.white38, fontSize: 10, height: 1.3))),
              ]),
            ]),
          ),
          const SizedBox(height: 20),
          ...languages.asMap().entries.map((e) => _LangCard(lang: e.value, rank: e.key + 1)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [_rose.withOpacity(0.10), _violet.withOpacity(0.06)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: _rose.withOpacity(0.2))),
            child: Row(children: [
              Icon(Icons.format_quote_rounded, color: _amber, size: 26), const SizedBox(width: 12),
              const Expanded(child: Text('"The greatest thing you\'ll ever learn is just to love, and be loved in return." — Nat King Cole', style: TextStyle(color: Colors.white, fontSize: 12, height: 1.4, fontStyle: FontStyle.italic))),
            ]),
          ),
        ],
      ),
    );
  }
}

class _LoveLang {
  final IconData icon; final Color color; final String lang, desc; final double score; final List<String> examples;
  const _LoveLang({required this.icon, required this.color, required this.lang, required this.score, required this.desc, required this.examples});
}

class _LangCard extends StatelessWidget {
  final _LoveLang lang; final int rank;
  const _LangCard({required this.lang, required this.rank});
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: lang.color.withOpacity(0.07), borderRadius: BorderRadius.circular(16), border: Border.all(color: lang.color.withOpacity(0.22))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: lang.color.withOpacity(0.15), borderRadius: BorderRadius.circular(10)), child: Icon(lang.icon, color: lang.color, size: 18)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('#$rank ${lang.lang}', style: TextStyle(color: lang.color, fontSize: 13, fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Stack(children: [
            Container(height: 5, decoration: BoxDecoration(color: Colors.white.withOpacity(0.06), borderRadius: BorderRadius.circular(3))),
            FractionallySizedBox(widthFactor: lang.score, child: Container(height: 5, decoration: BoxDecoration(color: lang.color, borderRadius: BorderRadius.circular(3)))),
          ]),
        ])),
        const SizedBox(width: 10),
        Text('${(lang.score * 100).round()}%', style: TextStyle(color: lang.color, fontSize: 13, fontWeight: FontWeight.w900)),
      ]),
      const SizedBox(height: 10),
      Text(lang.desc, style: const TextStyle(color: Colors.white60, fontSize: 11, height: 1.45)),
      const SizedBox(height: 10),
      Wrap(spacing: 6, runSpacing: 4, children: lang.examples.map((e) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(color: lang.color.withOpacity(0.10), borderRadius: BorderRadius.circular(6), border: Border.all(color: lang.color.withOpacity(0.2))),
        child: Text(e, style: TextStyle(color: lang.color, fontSize: 9, fontWeight: FontWeight.w600)),
      )).toList()),
    ]),
  );
}
