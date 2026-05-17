import 'package:flutter/material.dart';

/// DESIGN: Dictionary/Word Cards — flashcard-style vocabulary with etymology
class VocabularyBestView extends StatelessWidget {
  const VocabularyBestView({super.key});

  static const _indigo = Color(0xFF4F46E5);
  static const _violet = Color(0xFF7C3AED);
  static const _sky = Color(0xFF0EA5E9);
  static const _teal = Color(0xFF0D9488);
  static const _amber = Color(0xFFF59E0B);
  static const _green = Color(0xFF10B981);
  static const _rose = Color(0xFFF43F5E);
  static const _bg = Color(0xFF04030E);

  @override
  Widget build(BuildContext context) {
    final words = [
      _Word(word: 'Erudite', pos: 'adj.', color: _indigo, phon: '/ˈer.ʊ.daɪt/', defn: 'Having or showing great knowledge or learning, especially that gained from books and study.', etymology: 'Latin eruditus, from e- (out) + rudis (rough, untrained)', usage: '"An erudite professor whose lectures transformed the way students thought about history."', synonyms: ['Learned', 'Scholarly', 'Knowledgeable', 'Lettered']),
      _Word(word: 'Equanimity', pos: 'n.', color: _violet, phon: '/ˌiː.kwəˈnɪm.ɪ.ti/', defn: 'Mental calmness and composure, especially in difficult situations; evenness of mind under stress.', etymology: 'Latin aequanimitas, from aequus (equal) + animus (mind)', usage: '"She faced the loss with remarkable equanimity, never losing her characteristic composure."', synonyms: ['Composure', 'Serenity', 'Calm', 'Equilibrium']),
      _Word(word: 'Perspicacious', pos: 'adj.', color: _teal, phon: '/ˌpɜː.spɪˈkeɪ.ʃəs/', defn: 'Having a ready insight into things; shrewdly perceptive; having a keen ability to see and understand clearly.', etymology: 'Latin perspicax, from perspicere (to look through clearly)', usage: '"A perspicacious observer would notice the subtle shifts in market sentiment weeks before they became obvious."', synonyms: ['Perceptive', 'Discerning', 'Sharp', 'Insightful']),
      _Word(word: 'Magnanimous', pos: 'adj.', color: _amber, phon: '/mæɡˈnæn.ɪ.məs/', defn: 'Generous or forgiving, especially toward a rival or someone less powerful; showing great generosity of spirit.', etymology: 'Latin magnanimis, from magnus (great) + animus (spirit)', usage: '"In a magnanimous gesture, the champion publicly praised the runner-up\'s exceptional performance."', synonyms: ['Generous', 'Forgiving', 'Noble', 'Gracious']),
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: const Text('VOCABULARY', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 3, fontSize: 14, color: Colors.white)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 14), child: Icon(Icons.translate_rounded, color: _indigo, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        children: [
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(
              gradient: LinearGradient(colors: [const Color(0xFF0A0825), const Color(0xFF050415)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(18), border: Border.all(color: _indigo.withOpacity(0.3)),
            ),
            child: Row(children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('VOCABULARY ENGINE', style: TextStyle(color: _indigo, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 2)),
                const SizedBox(height: 6),
                const Text('Words are the tools of thought. Expand your vocabulary and you expand the precision of your thinking.', style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.35)),
              ])),
              const SizedBox(width: 16),
              Column(children: [
                _VocabStat('2,847', 'Words\nLearned', _indigo),
                const SizedBox(height: 6),
                _VocabStat('94%', 'Retention\nRate', _green),
              ]),
            ]),
          ),
          const SizedBox(height: 20),
          _SecHead('WORD OF THE DAY SERIES', _indigo),
          const SizedBox(height: 12),
          ...words.map((w) => _WordCard(word: w)),
          const SizedBox(height: 20),
          _SecHead('VOCABULARY LEARNING SYSTEM', _teal),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: _LearningMethod(color: _sky, icon: Icons.flash_on_rounded, title: 'Spaced Repetition', body: 'Words reviewed at optimal intervals for long-term retention.')),
            const SizedBox(width: 10),
            Expanded(child: _LearningMethod(color: _violet, icon: Icons.account_tree_rounded, title: 'Etymology Chains', body: 'Understanding roots multiplies vocabulary — learn one root, gain 50 words.')),
          ]),
          const SizedBox(height: 10),
          Row(children: [
            Expanded(child: _LearningMethod(color: _amber, icon: Icons.record_voice_over_rounded, title: 'Contextual Usage', body: 'Words learned in rich contexts are retained 3x longer than definitions alone.')),
            const SizedBox(width: 10),
            Expanded(child: _LearningMethod(color: _green, icon: Icons.edit_rounded, title: 'Active Writing', body: 'Using new words in writing within 24 hours converts passive to active knowledge.')),
          ]),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [_indigo.withOpacity(0.10), _violet.withOpacity(0.06)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: _indigo.withOpacity(0.2))),
            child: Row(children: [
              Icon(Icons.format_quote_rounded, color: _amber, size: 26), const SizedBox(width: 12),
              const Expanded(child: Text('"The limits of my language mean the limits of my world." — Ludwig Wittgenstein', style: TextStyle(color: Colors.white, fontSize: 13, height: 1.4, fontStyle: FontStyle.italic))),
            ]),
          ),
        ],
      ),
    );
  }
}

class _Word {
  final String word, pos, phon, defn, etymology, usage; final Color color; final List<String> synonyms;
  const _Word({required this.word, required this.pos, required this.phon, required this.defn, required this.etymology, required this.usage, required this.color, required this.synonyms});
}

class _WordCard extends StatelessWidget {
  final _Word word;
  const _WordCard({required this.word});
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: word.color.withOpacity(0.07), borderRadius: BorderRadius.circular(16), border: Border.all(color: word.color.withOpacity(0.22))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Text(word.word, style: TextStyle(color: word.color, fontSize: 20, fontWeight: FontWeight.w900)),
        const SizedBox(width: 8),
        Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: word.color.withOpacity(0.12), borderRadius: BorderRadius.circular(4)), child: Text(word.pos, style: TextStyle(color: word.color, fontSize: 10, fontWeight: FontWeight.w700))),
        const Spacer(),
        Text(word.phon, style: const TextStyle(color: Colors.white38, fontSize: 11, fontFamily: 'monospace')),
      ]),
      const SizedBox(height: 8),
      Text(word.defn, style: const TextStyle(color: Colors.white80, fontSize: 12, height: 1.45)),
      const SizedBox(height: 8),
      Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white.withOpacity(0.04), borderRadius: BorderRadius.circular(8)),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(Icons.history_edu_rounded, color: word.color.withOpacity(0.6), size: 12), const SizedBox(width: 6),
          Expanded(child: Text(word.etymology, style: const TextStyle(color: Colors.white38, fontSize: 10, height: 1.4, fontStyle: FontStyle.italic))),
        ])),
      const SizedBox(height: 8),
      Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: word.color.withOpacity(0.06), borderRadius: BorderRadius.circular(8), border: Border.all(color: word.color.withOpacity(0.12))),
        child: Text(word.usage, style: const TextStyle(color: Colors.white60, fontSize: 11, height: 1.45, fontStyle: FontStyle.italic))),
      const SizedBox(height: 8),
      Wrap(spacing: 6, runSpacing: 4, children: word.synonyms.map((s) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.04), borderRadius: BorderRadius.circular(6), border: Border.all(color: Colors.white.withOpacity(0.08))),
        child: Text(s, style: const TextStyle(color: Colors.white54, fontSize: 9)),
      )).toList()),
    ]),
  );
}

class _VocabStat extends StatelessWidget {
  final String v, l; final Color c;
  const _VocabStat(this.v, this.l, this.c);
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: c.withOpacity(0.1), borderRadius: BorderRadius.circular(8), border: Border.all(color: c.withOpacity(0.2))), child: Column(children: [Text(v, style: TextStyle(color: c, fontSize: 13, fontWeight: FontWeight.w900)), Text(l, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white38, fontSize: 8, height: 1.2))]));
}

class _SecHead extends StatelessWidget {
  final String text; final Color color;
  const _SecHead(this.text, this.color);
  @override
  Widget build(BuildContext context) => Row(children: [Container(width: 3, height: 14, color: color), const SizedBox(width: 8), Text(text, style: TextStyle(color: color.withOpacity(0.85), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2))]);
}

class _LearningMethod extends StatelessWidget {
  final Color color; final IconData icon; final String title, body;
  const _LearningMethod({required this.color, required this.icon, required this.title, required this.body});
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: color.withOpacity(0.07), borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withOpacity(0.18))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Icon(icon, color: color, size: 18), const SizedBox(height: 6),
    Text(title, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w800)), const SizedBox(height: 4),
    Text(body, style: const TextStyle(color: Colors.white54, fontSize: 10, height: 1.4)),
  ]));
}
