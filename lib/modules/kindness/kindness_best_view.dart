import 'package:flutter/material.dart';

/// DESIGN: Radial/Circular Layout — circular rings of kindness acts with ripple effect
class KindnessBestView extends StatelessWidget {
  const KindnessBestView({super.key});

  static const _rose = Color(0xFFF43F5E);
  static const _pink = Color(0xFFEC4899);
  static const _violet = Color(0xFF7C3AED);
  static const _teal = Color(0xFF0D9488);
  static const _amber = Color(0xFFF59E0B);
  static const _green = Color(0xFF10B981);
  static const _sky = Color(0xFF0EA5E9);
  static const _bg = Color(0xFF08000A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: const Text('KINDNESS', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 4, fontSize: 14, color: Colors.white)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 14), child: Icon(Icons.volunteer_activism_rounded, color: _rose, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        children: [
          // RIPPLE RINGS HERO
          SizedBox(height: 220, child: Center(child: Stack(alignment: Alignment.center, children: [
            ...[180.0, 150.0, 120.0, 90.0, 60.0].asMap().entries.map((e) => Container(
              width: e.value, height: e.value,
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: _rose.withOpacity(0.06 + e.key * 0.04), width: 1.5)),
            )),
            Container(width: 56, height: 56, decoration: BoxDecoration(shape: BoxShape.circle, gradient: RadialGradient(colors: [_rose.withOpacity(0.4), _rose.withOpacity(0.1)])), child: const Icon(Icons.volunteer_activism_rounded, color: Colors.white, size: 24)),
            // Labels on rings
            Positioned(top: 18, right: 20, child: _RingLabel('Global', _amber)),
            Positioned(top: 40, left: 14, child: _RingLabel('Community', _violet)),
            Positioned(bottom: 36, right: 14, child: _RingLabel('Friends', _teal)),
            Positioned(bottom: 20, left: 22, child: _RingLabel('Family', _sky)),
            Positioned(top: 24, left: 60, child: _RingLabel('Self', _green)),
          ]))),
          const SizedBox(height: 8),
          Center(child: Text('Kindness ripples outward from self to the world', style: TextStyle(color: _rose.withOpacity(0.7), fontSize: 11, fontStyle: FontStyle.italic))),
          const SizedBox(height: 24),
          // KINDNESS DIMENSIONS
          _SecHead('DIMENSIONS OF KINDNESS', _rose),
          const SizedBox(height: 12),
          _KindCard(color: _rose, icon: Icons.self_improvement_rounded, title: 'Self-Compassion First',
              body: 'You cannot give what you do not have. Self-kindness — treating yourself with the same compassion you extend to people you love — is not selfishness. It is the source from which sustainable kindness toward others is drawn. The most consistently kind people have a robust practice of self-compassion.'),
          const SizedBox(height: 8),
          _KindCard(color: _pink, icon: Icons.people_rounded, title: 'Micro-Acts of Kindness',
              body: 'Grand gestures are memorable but rare. Consistent micro-acts — a genuine compliment, a door held, an unsolicited offer of help, a message that acknowledges someone\'s difficulty — compose the majority of kindness experienced by the people around you. Log one per day.'),
          const SizedBox(height: 8),
          _KindCard(color: _violet, icon: Icons.hearing_rounded, title: 'Listening as Kindness',
              body: 'Full attention is one of the rarest and most valued gifts one person can give another. Being truly listened to — without interruption, without one-upmanship, without the listener composing their response — produces a physiological calming response. It is kindness in its most portable form.'),
          const SizedBox(height: 8),
          _KindCard(color: _teal, icon: Icons.public_rounded, title: 'Structural Kindness',
              body: 'Individual acts of kindness are valuable; structural kindness scales. Designing systems, organisations, and processes that are kind by default — that make the compassionate option the easy option — multiplies kindness beyond what any individual could achieve through personal acts alone.'),
          const SizedBox(height: 8),
          _KindCard(color: _amber, icon: Icons.memory_rounded, title: 'Kindness Under Pressure',
              body: 'Anyone can be kind when it costs nothing. The defining practice is kindness under pressure — when you are stressed, when the other person is difficult, when you have been wronged. This is not sainthood; it is a practised skill that gets easier with deliberate, logged repetition.'),
          const SizedBox(height: 8),
          _KindCard(color: _green, icon: Icons.trending_up_rounded, title: 'The Kindness Compound',
              body: 'Kindness compounds because it changes the environment. People treated kindly are more likely to treat others kindly — the longitudinal research is unambiguous. Every documented act of kindness is a small input into a positive feedback loop whose output is disproportionate to the initial investment.'),
          const SizedBox(height: 20),
          // KINDNESS STATS ROW
          Row(children: [
            _StatBox('34', 'Acts Logged\nThis Month', _rose),
            const SizedBox(width: 8),
            _StatBox('7', 'Days\nStreak', _pink),
            const SizedBox(width: 8),
            _StatBox('94%', 'Self-Compassion\nScore', _violet),
            const SizedBox(width: 8),
            _StatBox('12', 'People\nImpacted', _teal),
          ]),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [_rose.withOpacity(0.10), _violet.withOpacity(0.06)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: _rose.withOpacity(0.2))),
            child: Row(children: [
              Icon(Icons.format_quote_rounded, color: _amber, size: 26), const SizedBox(width: 12),
              const Expanded(child: Text('"No act of kindness, no matter how small, is ever wasted." — Aesop', style: TextStyle(color: Colors.white, fontSize: 13, height: 1.4, fontStyle: FontStyle.italic))),
            ]),
          ),
        ],
      ),
    );
  }
}

class _RingLabel extends StatelessWidget {
  final String text; final Color color;
  const _RingLabel(this.text, this.color);
  @override
  Widget build(BuildContext context) => Text(text, style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.w700));
}

class _SecHead extends StatelessWidget {
  final String text; final Color color;
  const _SecHead(this.text, this.color);
  @override
  Widget build(BuildContext context) => Row(children: [Container(width: 3, height: 14, color: color), const SizedBox(width: 8), Text(text, style: TextStyle(color: color.withOpacity(0.85), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2))]);
}

class _KindCard extends StatelessWidget {
  final Color color; final IconData icon; final String title, body;
  const _KindCard({required this.color, required this.icon, required this.title, required this.body});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: color.withOpacity(0.07), borderRadius: BorderRadius.circular(14), border: Border.all(color: color.withOpacity(0.2))),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(padding: const EdgeInsets.all(7), decoration: BoxDecoration(color: color.withOpacity(0.14), borderRadius: BorderRadius.circular(9)), child: Icon(icon, color: color, size: 16)),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.w700)),
        const SizedBox(height: 5),
        Text(body, style: const TextStyle(color: Colors.white60, fontSize: 11, height: 1.5)),
      ])),
    ]),
  );
}

class _StatBox extends StatelessWidget {
  final String value, label; final Color color;
  const _StatBox(this.value, this.label, this.color);
  @override
  Widget build(BuildContext context) => Expanded(child: Container(
    padding: const EdgeInsets.symmetric(vertical: 12),
    decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withOpacity(0.2))),
    child: Column(children: [
      Text(value, style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.w900)),
      Text(label, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white38, fontSize: 8, height: 1.2)),
    ]),
  ));
}
