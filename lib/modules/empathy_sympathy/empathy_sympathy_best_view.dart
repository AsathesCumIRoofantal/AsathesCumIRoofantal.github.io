import 'package:flutter/material.dart';

/// DESIGN: Sticky Notes Board — colorful sticky notes on cork board aesthetic
class EmpathySympathyBestView extends StatelessWidget {
  const EmpathySympathyBestView({super.key});

  static const _cork = Color(0xFF8B6914);
  static const _bg = Color(0xFF1A1200);
  static const _yellow = Color(0xFFFDE68A);
  static const _pink = Color(0xFFFCE7F3);
  static const _blue = Color(0xFFDBEAFE);
  static const _green = Color(0xFFD1FAE5);
  static const _violet = Color(0xFFEDE9FE);
  static const _orange = Color(0xFFFED7AA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: const Text('EMPATHY & SYMPATHY', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 13, color: Colors.white)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 14), child: Icon(Icons.favorite_rounded, color: _cork, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 40),
        children: [
          // DISTINCTION CARD
          Container(
            padding: const EdgeInsets.all(18), margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(color: _cork.withOpacity(0.12), borderRadius: BorderRadius.circular(16), border: Border.all(color: _cork.withOpacity(0.3))),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('KEY DISTINCTION', style: TextStyle(color: _cork, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 2)),
              const SizedBox(height: 10),
              Row(children: [
                Expanded(child: _DistBox(color: const Color(0xFFF43F5E), label: 'EMPATHY', defn: 'I feel WITH you\n— shared experience, no distance')),
                const SizedBox(width: 10),
                Expanded(child: _DistBox(color: const Color(0xFF2563EB), label: 'SYMPATHY', defn: 'I feel FOR you\n— compassion from the outside')),
              ]),
              const SizedBox(height: 10),
              const Text('Neither is superior — each is appropriate in different contexts. The skilled practitioner knows which mode serves the other person right now.', style: TextStyle(color: Colors.white60, fontSize: 11, height: 1.45)),
            ]),
          ),
          // STICKY NOTES GRID — CORK BOARD AESTHETIC
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: _cork.withOpacity(0.08), borderRadius: BorderRadius.circular(18), border: Border.all(color: _cork.withOpacity(0.2))),
            child: Column(children: [
              Row(children: [
                Expanded(child: _Sticky(color: _yellow, title: '🎯 Empathy Vs Sympathy', body: 'Sympathy says "I\'m sorry for your loss." Empathy says "I can imagine how hard this must feel." One creates distance, one closes it.', rotate: -1.5)),
                const SizedBox(width: 10),
                Expanded(child: _Sticky(color: _pink, title: '💡 Active Listening', body: 'Listen to understand, not to respond. Resist the urge to offer solutions — most people first need to feel heard before they want advice.', rotate: 1.0)),
              ]),
              const SizedBox(height: 10),
              Row(children: [
                Expanded(child: _Sticky(color: _blue, title: '🌊 Emotional Resonance', body: 'When someone cries, don\'t panic. Sit with the emotion. Your discomfort with their pain is about you, not about helping them.', rotate: 0.8)),
                const SizedBox(width: 10),
                Expanded(child: _Sticky(color: _green, title: '🤝 Perspective Taking', body: 'Before reacting to anyone\'s behaviour, ask: what would I have to believe about the world to act the way they\'re acting? Answers are always humanising.', rotate: -0.5)),
              ]),
              const SizedBox(height: 10),
              Row(children: [
                Expanded(child: _Sticky(color: _violet, title: '⚡ Empathy Fatigue', body: 'Empathy has a cost — absorbing others\' pain depletes your reserves. Boundaries in empathy aren\'t cruelty; they\'re sustainability planning.', rotate: -1.2)),
                const SizedBox(width: 10),
                Expanded(child: _Sticky(color: _orange, title: '📊 The Empathy Map', body: 'What are they saying? Thinking? Feeling? Doing? The Empathy Map tool surfaces the full experiential picture behind any behaviour.', rotate: 1.8)),
              ]),
              const SizedBox(height: 10),
              Row(children: [
                Expanded(child: _Sticky(color: _yellow, title: '🔬 Cognitive Empathy', body: 'Understanding someone\'s perspective intellectually — without necessarily feeling it emotionally. Essential for negotiation, leadership, and conflict resolution.', rotate: 0.5)),
                const SizedBox(width: 10),
                Expanded(child: _Sticky(color: _pink, title: '❤️ Affective Empathy', body: 'Genuinely feeling what another feels. Most powerful in intimate relationships; most dangerous in high-stakes decisions where emotional distance matters.', rotate: -0.9)),
              ]),
            ]),
          ),
          const SizedBox(height: 16),
          // PRACTICE CARDS
          _PracticeRow(color: const Color(0xFF0EA5E9), icon: Icons.mic_rounded, title: 'The Listening Protocol', body: 'For 5 minutes: no solutions, no relating back to yourself, no silver linings. Just reflect what you hear: "It sounds like you\'re feeling..." This alone transforms most conversations.'),
          const SizedBox(height: 8),
          _PracticeRow(color: const Color(0xFF10B981), icon: Icons.psychology_rounded, title: 'The Perspective Interview', body: 'Spend 15 minutes asking someone about their experience from their point of view with genuine curiosity. No agenda, no counter-argument. Note three things you did not know before.'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: _cork.withOpacity(0.10), borderRadius: BorderRadius.circular(16), border: Border.all(color: _cork.withOpacity(0.22))),
            child: Row(children: [
              Icon(Icons.format_quote_rounded, color: const Color(0xFFF59E0B), size: 26), const SizedBox(width: 12),
              const Expanded(child: Text('"Empathy is seeing with the eyes of another, listening with the ears of another, and feeling with the heart of another." — Alfred Adler', style: TextStyle(color: Colors.white, fontSize: 12, height: 1.4, fontStyle: FontStyle.italic))),
            ]),
          ),
        ],
      ),
    );
  }
}

class _Sticky extends StatelessWidget {
  final Color color; final String title, body; final double rotate;
  const _Sticky({required this.color, required this.title, required this.body, required this.rotate});
  @override
  Widget build(BuildContext context) => Transform.rotate(
    angle: rotate * 3.14159 / 180,
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
        boxShadow: const [BoxShadow(color: Colors.black45, blurRadius: 8, offset: Offset(2, 4))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(color: Color(0xFF1A1A1A), fontSize: 11, fontWeight: FontWeight.w900, height: 1.2)),
        const SizedBox(height: 6),
        Text(body, style: const TextStyle(color: Color(0xFF333333), fontSize: 10, height: 1.4)),
      ]),
    ),
  );
}

class _DistBox extends StatelessWidget {
  final Color color; final String label, defn;
  const _DistBox({required this.color, required this.label, required this.defn});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withOpacity(0.3))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1)),
      const SizedBox(height: 5),
      Text(defn, style: const TextStyle(color: Colors.white70, fontSize: 11, height: 1.4)),
    ]),
  );
}

class _PracticeRow extends StatelessWidget {
  final Color color; final IconData icon; final String title, body;
  const _PracticeRow({required this.color, required this.icon, required this.title, required this.body});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: color.withOpacity(0.07), borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withOpacity(0.18))),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(8)), child: Icon(icon, color: color, size: 16)),
      const SizedBox(width: 10),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w800)),
        const SizedBox(height: 5),
        Text(body, style: const TextStyle(color: Colors.white54, fontSize: 11, height: 1.45)),
      ])),
    ]),
  );
}
