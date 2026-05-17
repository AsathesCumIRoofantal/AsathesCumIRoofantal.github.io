import 'package:flutter/material.dart';

/// DESIGN: Game/Quiz UI — gamified learning with XP, levels, and achievement badges
class LearnFunBestView extends StatelessWidget {
  const LearnFunBestView({super.key});

  static const _lime = Color(0xFF84CC16);
  static const _green = Color(0xFF10B981);
  static const _amber = Color(0xFFF59E0B);
  static const _violet = Color(0xFF7C3AED);
  static const _sky = Color(0xFF0EA5E9);
  static const _rose = Color(0xFFF43F5E);
  static const _orange = Color(0xFFF97316);
  static const _bg = Color(0xFF040A04);

  @override
  Widget build(BuildContext context) {
    final quests = [
      _Quest(icon: Icons.psychology_rounded, color: _violet, title: 'Master of Mental Models', xp: 500, progress: 0.65, level: 'Level 4', challenge: '12 models remaining'),
      _Quest(icon: Icons.language_rounded, color: _sky, title: 'Polyglot Pioneer', xp: 300, progress: 0.42, level: 'Level 2', challenge: '58 words to go'),
      _Quest(icon: Icons.science_rounded, color: _lime, title: 'Science Synthesist', xp: 450, progress: 0.78, level: 'Level 5', challenge: '8 topics left'),
      _Quest(icon: Icons.history_edu_rounded, color: _amber, title: 'History Historian', xp: 200, progress: 0.30, level: 'Level 1', challenge: '14 eras to explore'),
    ];

    final badges = [
      _Badge(icon: Icons.emoji_events_rounded, color: _amber, label: 'Gold\nLearner'),
      _Badge(icon: Icons.local_fire_department_rounded, color: _rose, label: '30-Day\nStreak'),
      _Badge(icon: Icons.bolt_rounded, color: _lime, label: 'Speed\nReader'),
      _Badge(icon: Icons.hub_rounded, color: _sky, label: 'Connector'),
      _Badge(icon: Icons.star_rounded, color: _violet, label: 'Top 1%'),
      _Badge(icon: Icons.all_inclusive_rounded, color: _orange, label: 'Curious\nMind'),
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.games_rounded, color: _lime, size: 18),
          const SizedBox(width: 8),
          const Text('LEARN & FUN', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 13, color: Colors.white)),
        ]),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 14), child: Row(children: [Icon(Icons.bolt_rounded, color: _amber, size: 16), const SizedBox(width: 2), const Text('4,280 XP', style: TextStyle(color: Color(0xFFF59E0B), fontSize: 11, fontWeight: FontWeight.w800))]))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        children: [
          // PLAYER PROFILE
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(
              gradient: LinearGradient(colors: [const Color(0xFF0A1400), const Color(0xFF050A02)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(20), border: Border.all(color: _lime.withOpacity(0.3)),
            ),
            child: Row(children: [
              Stack(children: [
                Container(width: 56, height: 56, decoration: BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [_lime.withOpacity(0.3), _green.withOpacity(0.2)]))),
                Positioned(bottom: 0, right: 0, child: Container(width: 20, height: 20, decoration: BoxDecoration(color: _amber, shape: BoxShape.circle, border: Border.all(color: _bg, width: 2)), child: const Center(child: Text('🔥', style: TextStyle(fontSize: 10))))),
              ]),
              const SizedBox(width: 14),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Knowledge Seeker', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w900)),
                Text('Level 7 — Expert Learner', style: TextStyle(color: _lime, fontSize: 10, fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                Stack(children: [
                  Container(height: 8, decoration: BoxDecoration(color: Colors.white.withOpacity(0.06), borderRadius: BorderRadius.circular(4))),
                  FractionallySizedBox(widthFactor: 0.73, child: Container(height: 8, decoration: BoxDecoration(gradient: LinearGradient(colors: [_lime, _green]), borderRadius: BorderRadius.circular(4)))),
                ]),
                const SizedBox(height: 3),
                Text('4,280 / 6,000 XP to Level 8', style: TextStyle(color: Colors.white38, fontSize: 9)),
              ])),
            ]),
          ),
          const SizedBox(height: 20),
          // BADGES
          _SecHead('ACHIEVEMENTS', _amber),
          const SizedBox(height: 12),
          SizedBox(height: 80, child: ListView.separated(scrollDirection: Axis.horizontal, itemCount: badges.length, separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (_, i) => Column(children: [
              Container(width: 48, height: 48, decoration: BoxDecoration(shape: BoxShape.circle, color: badges[i].color.withOpacity(0.12), border: Border.all(color: badges[i].color.withOpacity(0.3))), child: Center(child: Icon(badges[i].icon, color: badges[i].color, size: 22))),
              const SizedBox(height: 4),
              Text(badges[i].label, textAlign: TextAlign.center, style: TextStyle(color: badges[i].color, fontSize: 7, height: 1.2, fontWeight: FontWeight.w700)),
            ]),
          )),
          const SizedBox(height: 20),
          // ACTIVE QUESTS
          _SecHead('ACTIVE QUESTS', _lime),
          const SizedBox(height: 12),
          ...quests.map((q) => _QuestCard(quest: q)),
          const SizedBox(height: 20),
          // DAILY CHALLENGE
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [_rose.withOpacity(0.12), _orange.withOpacity(0.08)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: _rose.withOpacity(0.3))),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Icon(Icons.local_fire_department_rounded, color: _rose, size: 20), const SizedBox(width: 8),
                Text('DAILY CHALLENGE', style: TextStyle(color: _rose, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2)),
                const Spacer(),
                Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: _amber.withOpacity(0.12), borderRadius: BorderRadius.circular(6)), child: Text('+150 XP', style: TextStyle(color: _amber, fontSize: 10, fontWeight: FontWeight.w700))),
              ]),
              const SizedBox(height: 8),
              const Text('Today\'s challenge: Read one Wikipedia article about a topic completely new to you and summarise it in 3 sentences. Then connect it to something you already know.', style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.45)),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: _rose.withOpacity(0.15), borderRadius: BorderRadius.circular(8), border: Border.all(color: _rose.withOpacity(0.3))),
                child: const Center(child: Text('ACCEPT CHALLENGE', style: TextStyle(color: Color(0xFFF43F5E), fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 2))),
              ),
            ]),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [_lime.withOpacity(0.08), _green.withOpacity(0.05)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: _lime.withOpacity(0.18))),
            child: Row(children: [
              Icon(Icons.format_quote_rounded, color: _amber, size: 26), const SizedBox(width: 12),
              const Expanded(child: Text('"Play is the highest form of research." — Albert Einstein', style: TextStyle(color: Colors.white, fontSize: 13, height: 1.4, fontStyle: FontStyle.italic))),
            ]),
          ),
        ],
      ),
    );
  }
}

class _Quest { final IconData icon; final Color color; final String title, level, challenge; final int xp; final double progress; const _Quest({required this.icon, required this.color, required this.title, required this.xp, required this.progress, required this.level, required this.challenge}); }
class _Badge { final IconData icon; final Color color; final String label; const _Badge({required this.icon, required this.color, required this.label}); }

class _QuestCard extends StatelessWidget {
  final _Quest quest;
  const _QuestCard({required this.quest});
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: quest.color.withOpacity(0.07), borderRadius: BorderRadius.circular(14), border: Border.all(color: quest.color.withOpacity(0.2))),
    child: Row(children: [
      Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: quest.color.withOpacity(0.15), borderRadius: BorderRadius.circular(10)), child: Icon(quest.icon, color: quest.color, size: 18)),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(quest.title, style: TextStyle(color: quest.color, fontSize: 12, fontWeight: FontWeight.w700)),
        const SizedBox(height: 2),
        Text('${quest.level} • ${quest.challenge}', style: const TextStyle(color: Colors.white38, fontSize: 9)),
        const SizedBox(height: 6),
        Stack(children: [
          Container(height: 5, decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(3))),
          FractionallySizedBox(widthFactor: quest.progress, child: Container(height: 5, decoration: BoxDecoration(color: quest.color, borderRadius: BorderRadius.circular(3)))),
        ]),
      ])),
      const SizedBox(width: 10),
      Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Text('${quest.xp}', style: TextStyle(color: quest.color, fontSize: 14, fontWeight: FontWeight.w900)),
        const Text('XP', style: TextStyle(color: Colors.white30, fontSize: 8)),
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
