import 'package:flutter/material.dart';

/// DESIGN: Large Typography Storytelling — cinematic oversized chapter text
class HopeBestView extends StatelessWidget {
  const HopeBestView({super.key});

  static const _sky = Color(0xFF0EA5E9);
  static const _violet = Color(0xFF7C3AED);
  static const _gold = Color(0xFFD97706);
  static const _rose = Color(0xFFF43F5E);
  static const _teal = Color(0xFF0D9488);
  static const _bg = Color(0xFF010810);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: const Text('HOPE', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 6, fontSize: 14, color: Colors.white)),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 260,
            decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF0A0020), Color(0xFF001540), Color(0xFF000D30)], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: Stack(children: [
              Positioned.fill(child: CustomPaint(painter: _StarPainter())),
              Padding(padding: const EdgeInsets.fromLTRB(28, 60, 28, 28), child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.end, children: [
                Text('HOPE', style: TextStyle(fontSize: 72, fontWeight: FontWeight.w900, color: Colors.white.withOpacity(0.06), height: 0.9, letterSpacing: 8)),
                const Text('The architecture\nof tomorrow.', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Colors.white, height: 1.1, letterSpacing: -0.5)),
                const SizedBox(height: 12),
                Text('Hope is not naïve optimism. It is the rational decision to act as if a better future is possible — because without that decision, it never will be.', style: TextStyle(color: Colors.white60, fontSize: 12, height: 1.5)),
              ])),
            ]),
          ),
          _Chapter(number: '01', word: 'GROUNDED', color: _sky, body: 'Genuine hope is not detached from reality — it is anchored in it. It sees clearly what is difficult, what is uncertain, and what might fail, and chooses forward motion anyway. This is why hope and honesty are not opposites; they are partners.\n\nAIR\'s hope practice begins with a rigorous assessment of the current situation — not to discourage, but because hope built on accurate understanding is more resilient than hope built on wishful thinking.'),
          _PullQuote(text: '"Hope is being able to see that there is light despite all of the darkness."', author: 'Desmond Tutu', color: _gold),
          _Chapter(number: '02', word: 'ACTIVE', color: _violet, body: 'Passive hope waits. Active hope acts. The difference between wishful thinking and genuine hope is the behaviour it produces — the early morning when no one is watching, the revised plan after the rejection, the call made despite the fear of another no.\n\nThe Hope Action Log tracks one concrete act of hope-based action each day — turning the feeling into a practice with a measurable output.'),
          _Chapter(number: '03', word: 'CONTAGIOUS', color: _teal, body: 'Hope travels. When you carry it visibly — in how you speak about the future, in the risks you take publicly, in the way you recover from setbacks — you create a field of possibility that others enter and expand. Leaders are amplifiers of hope.\n\nStudies on emotional contagion show that a single visible act of hope-based action by a leader changes the decision behaviour of their team within 48 hours.'),
          _PullQuote(text: '"We must accept finite disappointment, but never lose infinite hope."', author: 'Martin Luther King Jr.', color: _rose),
          _Chapter(number: '04', word: 'PRACTISED', color: _gold, body: 'Hope is a skill developed through deliberate practice. The Hope Log in AIR is not a gratitude journal — it is a structured record of evidence: moments when things went better than expected, problems that yielded to effort, and futures that materialised because someone believed in them enough to act.'),
          _Chapter(number: '05', word: 'RESILIENT', color: _rose, body: 'Tested hope is more powerful than untested hope. Every time hope survived a genuine disappointment — not by denying the pain, but by maintaining the orientation toward the possible — it deepened its root. Resilient hope has been broken and rebuilt. That is why it holds.\n\nThe resilience rating in AIR tracks your recovery time after setbacks — the single most predictive metric of long-term hope sustainability.'),
          Container(
            padding: const EdgeInsets.all(28), color: const Color(0xFF000A18),
            child: Column(children: [
              Icon(Icons.star_rounded, color: _sky, size: 32),
              const SizedBox(height: 16),
              const Text('Begin your Hope Log today', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900)),
              const SizedBox(height: 8),
              Text('Document one piece of evidence that a better future is possible.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white54, fontSize: 12, height: 1.45)),
            ]),
          ),
        ],
      ),
    );
  }
}

class _Chapter extends StatelessWidget {
  final String number, word, body; final Color color;
  const _Chapter({required this.number, required this.word, required this.body, required this.color});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(28), color: const Color(0xFF010810),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('CHAPTER $number', style: TextStyle(color: color.withOpacity(0.5), fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 3)),
      const SizedBox(height: 6),
      Text(word, style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: color, height: 0.9, letterSpacing: 2)),
      Container(height: 2, width: 40, margin: const EdgeInsets.symmetric(vertical: 14), color: color.withOpacity(0.4)),
      Text(body, style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.65)),
    ]),
  );
}

class _PullQuote extends StatelessWidget {
  final String text, author; final Color color;
  const _PullQuote({required this.text, required this.author, required this.color});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.fromLTRB(28, 20, 28, 20), color: color.withOpacity(0.06),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(Icons.format_quote_rounded, color: color, size: 32),
      const SizedBox(height: 8),
      Text(text, style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700, height: 1.4, fontStyle: FontStyle.italic)),
      const SizedBox(height: 10),
      Text('— $author', style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1)),
    ]),
  );
}

class _StarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = Colors.white.withOpacity(0.6);
    for (final pos in [(0.1, 0.2), (0.3, 0.1), (0.5, 0.3), (0.7, 0.15), (0.9, 0.25), (0.15, 0.6), (0.45, 0.5), (0.8, 0.55), (0.6, 0.7), (0.25, 0.8)]) {
      canvas.drawCircle(Offset(size.width * pos.$1, size.height * pos.$2), 1.2, p);
    }
  }
  @override bool shouldRepaint(_) => false;
}
