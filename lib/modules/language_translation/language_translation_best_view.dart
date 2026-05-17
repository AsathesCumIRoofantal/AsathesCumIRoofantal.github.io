import 'package:flutter/material.dart';

/// DESIGN: Translation Hub — side-by-side language panels with linguistics dashboard
class LanguageTranslationBestView extends StatelessWidget {
  const LanguageTranslationBestView({super.key});

  static const _indigo = Color(0xFF4F46E5);
  static const _sky = Color(0xFF0EA5E9);
  static const _teal = Color(0xFF0D9488);
  static const _amber = Color(0xFFF59E0B);
  static const _green = Color(0xFF10B981);
  static const _violet = Color(0xFF7C3AED);
  static const _bg = Color(0xFF020A0E);

  @override
  Widget build(BuildContext context) {
    final langs = [
      _Lang(flag: '🇬🇧', name: 'English', speakers: '1.5B', color: _indigo, level: 'Native'),
      _Lang(flag: '🇪🇸', name: 'Spanish', speakers: '560M', color: _sky, level: 'Advanced'),
      _Lang(flag: '🇨🇳', name: 'Mandarin', speakers: '1.1B', color: _teal, level: 'Intermediate'),
      _Lang(flag: '🇫🇷', name: 'French', speakers: '280M', color: _violet, level: 'Beginner'),
      _Lang(flag: '🇩🇪', name: 'German', speakers: '135M', color: _amber, level: 'Beginner'),
      _Lang(flag: '🇦🇪', name: 'Arabic', speakers: '420M', color: _green, level: 'Learning'),
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: const Text('LANGUAGE TRANSLATION', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1, fontSize: 12, color: Colors.white)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 14), child: Icon(Icons.translate_rounded, color: _indigo, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        children: [
          // TRANSLATION WIDGET MOCK
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(
              gradient: LinearGradient(colors: [const Color(0xFF080A1A), const Color(0xFF04050E)]),
              borderRadius: BorderRadius.circular(20), border: Border.all(color: _indigo.withOpacity(0.25)),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('TRANSLATION ENGINE', style: TextStyle(color: _indigo, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 2)),
              const SizedBox(height: 14),
              Row(children: [
                Expanded(child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white.withOpacity(0.04), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white.withOpacity(0.08))),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [const Text('🇬🇧', style: TextStyle(fontSize: 14)), const SizedBox(width: 6), Text('English', style: TextStyle(color: _indigo, fontSize: 10, fontWeight: FontWeight.w700))]),
                    const SizedBox(height: 8),
                    const Text('Knowledge is the foundation of all progress.', style: TextStyle(color: Colors.white, fontSize: 12, height: 1.3)),
                  ]))),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: Icon(Icons.swap_horiz_rounded, color: _sky, size: 24)),
                Expanded(child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: _sky.withOpacity(0.06), borderRadius: BorderRadius.circular(12), border: Border.all(color: _sky.withOpacity(0.2))),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [const Text('🇪🇸', style: TextStyle(fontSize: 14)), const SizedBox(width: 6), Text('Español', style: TextStyle(color: _sky, fontSize: 10, fontWeight: FontWeight.w700))]),
                    const SizedBox(height: 8),
                    Text('El conocimiento es la base de todo progreso.', style: TextStyle(color: _sky.withOpacity(0.9), fontSize: 12, height: 1.3)),
                  ]))),
              ]),
            ]),
          ),
          const SizedBox(height: 20),
          // LANGUAGE PROFILES
          _SecHead('LANGUAGE PROFILE', _indigo),
          const SizedBox(height: 12),
          GridView.count(crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 2.0,
            children: langs.map((l) => _LangCard(lang: l)).toList()),
          const SizedBox(height: 20),
          _SecHead('LINGUISTICS INTELLIGENCE', _teal),
          const SizedBox(height: 12),
          _LingCard(color: _indigo, icon: Icons.psychology_rounded, title: 'Linguistic Relativity',
              body: 'The language you think in shapes how you categorise reality. Languages with more colour words perceive more colour distinctions; languages with spatial metaphors for time create different temporal intuitions. Learning a new language literally expands the perceivable world.'),
          const SizedBox(height: 8),
          _LingCard(color: _sky, icon: Icons.trending_up_rounded, title: 'The Acquisition Curve',
              body: 'Language acquisition follows a predictable curve: the first 500 words are the hardest but cover 80% of daily conversation. After 2,000 words, comprehension of authentic content becomes possible. AIR\'s vocabulary tracker shows exactly where you are on the acquisition curve for each language.'),
          const SizedBox(height: 8),
          _LingCard(color: _violet, icon: Icons.hub_rounded, title: 'Cross-Linguistic Transfer',
              body: 'Skills in one language partially transfer to others — especially within language families. A Spanish speaker learning Italian progresses 3x faster than a Mandarin speaker. AIR\'s learning path accounts for your existing language base and sequences new language acquisition optimally.'),
          const SizedBox(height: 8),
          _LingCard(color: _amber, icon: Icons.business_rounded, title: 'Economic Value of Language',
              body: 'Each additional language adds approximately 5–15% to lifetime earning potential in roles where it is relevant. Mandarin and Spanish show the highest economic returns globally for English speakers. AIR tracks language investment against your career trajectory.'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [_indigo.withOpacity(0.08), _teal.withOpacity(0.05)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: _indigo.withOpacity(0.18))),
            child: Row(children: [
              Icon(Icons.format_quote_rounded, color: _amber, size: 26), const SizedBox(width: 12),
              const Expanded(child: Text('"To have another language is to possess a second soul." — Charlemagne', style: TextStyle(color: Colors.white, fontSize: 13, height: 1.4, fontStyle: FontStyle.italic))),
            ]),
          ),
        ],
      ),
    );
  }
}

class _Lang { final String flag, name, speakers, level; final Color color; const _Lang({required this.flag, required this.name, required this.speakers, required this.level, required this.color}); }

class _LangCard extends StatelessWidget {
  final _Lang lang;
  const _LangCard({required this.lang});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(color: lang.color.withOpacity(0.08), borderRadius: BorderRadius.circular(12), border: Border.all(color: lang.color.withOpacity(0.2))),
    child: Row(children: [
      Text(lang.flag, style: const TextStyle(fontSize: 22)),
      const SizedBox(width: 10),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(lang.name, style: TextStyle(color: lang.color, fontSize: 12, fontWeight: FontWeight.w800)),
        Text(lang.speakers, style: const TextStyle(color: Colors.white38, fontSize: 9)),
        Container(margin: const EdgeInsets.only(top: 4), padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: lang.color.withOpacity(0.12), borderRadius: BorderRadius.circular(4)), child: Text(lang.level, style: TextStyle(color: lang.color, fontSize: 8, fontWeight: FontWeight.w700))),
      ])),
    ]),
  );
}

class _SecHead extends StatelessWidget {
  final String text; final Color color;
  const _SecHead(this.text, this.color);
  @override
  Widget build(BuildContext context) => Row(children: [Container(width: 3, height: 14, color: color), const SizedBox(width: 8), Text(text, style: TextStyle(color: color.withOpacity(0.85), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2))]);
}

class _LingCard extends StatelessWidget {
  final Color color; final IconData icon; final String title, body;
  const _LingCard({required this.color, required this.icon, required this.title, required this.body});
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
