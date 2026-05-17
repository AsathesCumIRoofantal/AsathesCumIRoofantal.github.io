import 'package:flutter/material.dart';

/// DESIGN: Achievement Board — trophy hall with win/loss analytics and milestone cards
class SuccessFailureBestView extends StatelessWidget {
  const SuccessFailureBestView({super.key});

  static const _gold = Color(0xFFD4A853);
  static const _silver = Color(0xFF94A3B8);
  static const _bronze = Color(0xFFB45309);
  static const _green = Color(0xFF10B981);
  static const _red = Color(0xFFEF4444);
  static const _violet = Color(0xFF7C3AED);
  static const _sky = Color(0xFF0EA5E9);
  static const _bg = Color(0xFF050300);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: const Text('SUCCESS & FAILURE', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 13, color: Colors.white)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 14), child: Icon(Icons.emoji_events_rounded, color: _gold, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        children: [
          // TROPHY DISPLAY
          Container(
            padding: const EdgeInsets.all(20), decoration: BoxDecoration(
              gradient: LinearGradient(colors: [const Color(0xFF1C1200), const Color(0xFF0A0800)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(22), border: Border.all(color: _gold.withOpacity(0.3)),
            ),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                _Trophy(icon: Icons.emoji_events_rounded, color: _silver, label: 'Silver', count: '12'),
                _Trophy(icon: Icons.emoji_events_rounded, color: _gold, label: '★ Gold', count: '7', isMain: true),
                _Trophy(icon: Icons.emoji_events_rounded, color: _bronze, label: 'Bronze', count: '18'),
              ]),
              const SizedBox(height: 16),
              Row(children: [
                Expanded(child: _StatPill('Win Rate', '74%', _green)),
                const SizedBox(width: 8),
                Expanded(child: _StatPill('Lessons', '34', _violet)),
                const SizedBox(width: 8),
                Expanded(child: _StatPill('Comeback Rate', '91%', _sky)),
              ]),
            ]),
          ),
          const SizedBox(height: 24),
          // WIN/LOSS RATIO VISUAL
          _SecHead('PERFORMANCE SPECTRUM', _gold),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white.withOpacity(0.04), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white.withOpacity(0.08))),
            child: Column(children: [
              Row(children: [
                const Text('Wins', style: TextStyle(color: Colors.white60, fontSize: 10)),
                const Spacer(),
                const Text('Failures', style: TextStyle(color: Colors.white60, fontSize: 10)),
              ]),
              const SizedBox(height: 8),
              Stack(children: [
                Container(height: 20, decoration: BoxDecoration(color: _red.withOpacity(0.2), borderRadius: BorderRadius.circular(10))),
                FractionallySizedBox(widthFactor: 0.74, child: Container(height: 20, decoration: BoxDecoration(gradient: LinearGradient(colors: [_green, _gold]), borderRadius: BorderRadius.circular(10)))),
                const Padding(padding: EdgeInsets.all(4), child: Row(children: [SizedBox(width: 8), Text('74%', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900))])),
              ]),
              const SizedBox(height: 8),
              Text('74% of measured attempts resulted in the defined success outcome. The 26% failures generated 34 documented lessons — a positive return on every failure.', style: TextStyle(color: Colors.white54, fontSize: 11, height: 1.4)),
            ]),
          ),
          const SizedBox(height: 20),
          _SecHead('SUCCESS PRINCIPLES', _green),
          const SizedBox(height: 12),
          _PrincipleCard(num: '01', color: _gold, title: 'Success Is Defined Before It Is Pursued',
              body: 'Without a clear, written definition of success for each goal, achievement is impossible to confirm and failure is impossible to learn from. AIR requires a success definition before any goal is tracked — specificity is not bureaucracy, it is the foundation of learning.',
              icon: Icons.flag_rounded),
          const SizedBox(height: 8),
          _PrincipleCard(num: '02', color: _green, title: 'Failures Are Data, Not Verdicts',
              body: 'A failure is a data point about your approach, your assumptions, or your preparation — not about your worth as a person. The failure log in AIR captures what you tried, what result you got, and what the result reveals about what needs to change.',
              icon: Icons.school_rounded),
          const SizedBox(height: 8),
          _PrincipleCard(num: '03', color: _sky, title: 'The Comeback Rate Is the Real Metric',
              body: 'The ability to recover after failure — and recover faster each time — is the most durable predictor of long-term success. Track your comeback rate: time from failure to re-engagement with a revised approach. Shorten that window deliberately.',
              icon: Icons.loop_rounded),
          const SizedBox(height: 8),
          _PrincipleCard(num: '04', color: _violet, title: 'Success Must Be Internalised',
              body: 'Uncelebrated success is wasted. The brain needs explicit, recognised moments of achievement to consolidate learning and maintain motivational momentum. AIR\'s achievement log is not vanity — it is the neurological maintenance of the drive to keep going.',
              icon: Icons.celebration_rounded),
          const SizedBox(height: 8),
          _PrincipleCard(num: '05', color: _red, title: 'The Long Run Favours the Consistent',
              body: 'In virtually every domain, the person who consistently shows up — even imperfectly — outperforms the intermittently brilliant over any period longer than a year. Consistency is not dramatic. That\'s the point. It compounds quietly while talent fluctuates noisily.',
              icon: Icons.trending_up_rounded),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [_gold.withOpacity(0.10), _bronze.withOpacity(0.06)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: _gold.withOpacity(0.2))),
            child: Row(children: [
              Icon(Icons.format_quote_rounded, color: _gold, size: 26), const SizedBox(width: 12),
              const Expanded(child: Text('"Success is not final; failure is not fatal: it is the courage to continue that counts." — Winston Churchill', style: TextStyle(color: Colors.white, fontSize: 12, height: 1.4, fontStyle: FontStyle.italic))),
            ]),
          ),
        ],
      ),
    );
  }
}

class _Trophy extends StatelessWidget {
  final IconData icon; final Color color; final String label, count; final bool isMain;
  const _Trophy({required this.icon, required this.color, required this.label, required this.count, this.isMain = false});
  @override
  Widget build(BuildContext context) => Column(children: [
    Icon(icon, color: color, size: isMain ? 48 : 36),
    const SizedBox(height: 4),
    Text(count, style: TextStyle(color: color, fontSize: isMain ? 22 : 16, fontWeight: FontWeight.w900)),
    Text(label, style: TextStyle(color: color.withOpacity(0.7), fontSize: 9, fontWeight: FontWeight.w600)),
  ]);
}

class _StatPill extends StatelessWidget {
  final String label, value; final Color color;
  const _StatPill(this.label, this.value, this.color);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10), border: Border.all(color: color.withOpacity(0.2))),
    child: Column(children: [
      Text(value, style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w900)),
      Text(label, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white38, fontSize: 8, height: 1.2)),
    ]),
  );
}

class _SecHead extends StatelessWidget {
  final String text; final Color color;
  const _SecHead(this.text, this.color);
  @override
  Widget build(BuildContext context) => Row(children: [Container(width: 3, height: 14, color: color), const SizedBox(width: 8), Text(text, style: TextStyle(color: color.withOpacity(0.85), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2))]);
}

class _PrincipleCard extends StatelessWidget {
  final String num, title, body; final Color color; final IconData icon;
  const _PrincipleCard({required this.num, required this.color, required this.title, required this.body, required this.icon});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: color.withOpacity(0.07), borderRadius: BorderRadius.circular(14), border: Border.all(color: color.withOpacity(0.2))),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Column(children: [
        Container(width: 28, height: 28, decoration: BoxDecoration(shape: BoxShape.circle, color: color.withOpacity(0.15), border: Border.all(color: color.withOpacity(0.4))), child: Center(child: Text(num, style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.w900)))),
        const SizedBox(height: 6),
        Icon(icon, color: color, size: 16),
      ]),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w800)),
        const SizedBox(height: 6),
        Text(body, style: const TextStyle(color: Colors.white70, fontSize: 11, height: 1.5)),
      ])),
    ]),
  );
}
