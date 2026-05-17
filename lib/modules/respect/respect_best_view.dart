import 'package:flutter/material.dart';

/// DESIGN: Two-Column Split Screen — dual-panel comparative deep-dive
class RespectBestView extends StatelessWidget {
  const RespectBestView({super.key});

  static const _gold = Color(0xFFD4A853);
  static const _amber = Color(0xFFF59E0B);
  static const _blue = Color(0xFF1D4ED8);
  static const _teal = Color(0xFF0D9488);
  static const _violet = Color(0xFF7C3AED);
  static const _red = Color(0xFFDC2626);
  static const _bg = Color(0xFF060400);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: const Text('RESPECT', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 4, fontSize: 14, color: Colors.white)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 14), child: Icon(Icons.handshake_rounded, color: _gold, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        children: [
          // HERO
          Container(
            padding: const EdgeInsets.all(20), decoration: BoxDecoration(
              gradient: LinearGradient(colors: [const Color(0xFF1C1200), const Color(0xFF0A0800)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(22), border: Border.all(color: _gold.withOpacity(0.3)),
            ),
            child: Column(children: [
              Icon(Icons.handshake_rounded, color: _gold, size: 38),
              const SizedBox(height: 14),
              Text('RESPECT INTELLIGENCE', style: TextStyle(color: _gold, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 3)),
              const SizedBox(height: 8),
              const Text('Respect is the foundation on which every productive relationship — professional, civic, or personal — is built and sustained.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.45)),
            ]),
          ),
          const SizedBox(height: 20),
          // SPLIT COLUMNS: Earned vs Demanded
          _SecHead('EARNED VS. DEMANDED', _gold),
          const SizedBox(height: 12),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(child: _Panel(color: _gold, title: 'EARNED RESPECT', items: [
              'Consistent behaviour across contexts',
              'Keeping commitments without reminders',
              'Treating people fairly regardless of status',
              'Taking responsibility for mistakes',
              'Competence demonstrated over time',
              'Honouring others\' time and contributions',
            ])),
            const SizedBox(width: 10),
            Expanded(child: _Panel(color: _red, title: 'DEMANDED RESPECT', items: [
              'Threats for non-deference',
              'Status symbols as a substitute for substance',
              'Disrespecting others while demanding respect',
              'Claiming respect based on title alone',
              'Expecting loyalty without offering trust',
              'Silencing criticism as "disrespect"',
            ])),
          ]),
          const SizedBox(height: 20),
          _SecHead('RESPECT PRACTICES', _teal),
          const SizedBox(height: 12),
          _RespCard(color: _blue, icon: Icons.access_time_rounded, title: 'Temporal Respect',
              body: 'Respecting someone\'s time is one of the most concrete forms of regard. Arriving on time, not over-scheduling, delivering on deadline, and communicating early when plans change are all enacted statements that the other person\'s time has value equal to your own.'),
          const SizedBox(height: 8),
          _RespCard(color: _teal, icon: Icons.record_voice_over_rounded, title: 'Epistemic Respect',
              body: 'Respecting someone\'s perspective — their right to hold views, to be wrong in their own way, to change their mind at their own pace — is the foundation of productive disagreement. You can disagree strongly with someone\'s conclusions while respecting their reasoning process.'),
          const SizedBox(height: 8),
          _RespCard(color: _violet, icon: Icons.shield_outlined, title: 'Dignity Respect',
              body: 'Every person has unconditional worth that exists independently of their performance, status, or behaviour. Dignity respect does not have to be earned — it is the baseline from which all interaction begins. Treating someone disrespectfully is not a statement about their worth; it is a statement about yours.'),
          const SizedBox(height: 8),
          _RespCard(color: _amber, icon: Icons.psychology_rounded, title: 'Intellectual Respect',
              body: 'Credit the source of ideas — acknowledge when someone changed your thinking, when their work preceded yours, when their contribution enabled your achievement. Intellectual generosity is a form of respect that distinguishes people of genuine substance from those who merely pursue credit.'),
          const SizedBox(height: 8),
          _RespCard(color: _gold, icon: Icons.diversity_2_rounded, title: 'Cross-Cultural Respect',
              body: 'Respect is expressed differently across cultures — directness can be disrespectful in one context and essential in another; formality signals respect in some relationships and distance in others. Cultural intelligence is the practice of learning which expressions of respect land in which contexts.'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [_gold.withOpacity(0.10), _teal.withOpacity(0.06)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: _gold.withOpacity(0.2))),
            child: Row(children: [
              Icon(Icons.format_quote_rounded, color: _amber, size: 26), const SizedBox(width: 12),
              const Expanded(child: Text('"Respect is earned, honesty is appreciated, trust is gained, and loyalty is returned." — Unknown', style: TextStyle(color: Colors.white, fontSize: 12, height: 1.4, fontStyle: FontStyle.italic))),
            ]),
          ),
        ],
      ),
    );
  }
}

class _Panel extends StatelessWidget {
  final Color color; final String title; final List<String> items;
  const _Panel({required this.color, required this.title, required this.items});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(14), border: Border.all(color: color.withOpacity(0.22))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1)),
      const SizedBox(height: 10),
      ...items.map((i) => Padding(padding: const EdgeInsets.only(bottom: 7), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(Icons.circle, color: color.withOpacity(0.6), size: 6),
        const SizedBox(width: 6),
        Expanded(child: Text(i, style: const TextStyle(color: Colors.white70, fontSize: 10, height: 1.4))),
      ]))),
    ]),
  );
}

class _SecHead extends StatelessWidget {
  final String text; final Color color;
  const _SecHead(this.text, this.color);
  @override
  Widget build(BuildContext context) => Row(children: [Container(width: 3, height: 14, color: color), const SizedBox(width: 8), Text(text, style: TextStyle(color: color.withOpacity(0.85), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2))]);
}

class _RespCard extends StatelessWidget {
  final Color color; final IconData icon; final String title, body;
  const _RespCard({required this.color, required this.icon, required this.title, required this.body});
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
