import 'package:flutter/material.dart';

/// DESIGN: Habit Tracker Grid — 30-day grid calendar with streak visualization
class SelfDisciplineBestView extends StatelessWidget {
  const SelfDisciplineBestView({super.key});

  static const _steel = Color(0xFF1E293B);
  static const _blue = Color(0xFF2563EB);
  static const _sky = Color(0xFF0EA5E9);
  static const _teal = Color(0xFF0D9488);
  static const _green = Color(0xFF10B981);
  static const _amber = Color(0xFFF59E0B);
  static const _violet = Color(0xFF7C3AED);
  static const _bg = Color(0xFF020610);

  // Sample data — 30 days
  static const _data = [true,true,true,false,true,true,true,true,false,true,true,true,true,true,false,true,true,true,true,true,true,false,true,true,true,true,true,true,true,true];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: const Text('SELF-DISCIPLINE', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 13, color: Colors.white)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 14), child: Icon(Icons.fitness_center_rounded, color: _blue, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        children: [
          // STATS HEADER
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(
              gradient: LinearGradient(colors: [const Color(0xFF030F24), const Color(0xFF010810)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(20), border: Border.all(color: _blue.withOpacity(0.25)),
            ),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                _BigStat('27/30', 'Days\nComplete', _sky),
                _BigStat('90%', 'Consistency\nRate', _green),
                _BigStat('12', 'Active\nHabits', _violet),
                _BigStat('🔥 15', 'Current\nStreak', _amber),
              ]),
            ]),
          ),
          const SizedBox(height: 20),
          _SecHead('MAY 2026 — DISCIPLINE GRID', _sky),
          const SizedBox(height: 12),
          // HABIT CALENDAR GRID
          Container(
            padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: Colors.white.withOpacity(0.03), borderRadius: BorderRadius.circular(16), border: Border.all(color: _blue.withOpacity(0.15))),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: ['M','T','W','T','F','S','S'].map((d) => SizedBox(width: 34, child: Center(child: Text(d, style: const TextStyle(color: Colors.white30, fontSize: 10, fontWeight: FontWeight.w700))))).toList()),
              const SizedBox(height: 8),
              GridView.builder(
                shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7, mainAxisSpacing: 4, crossAxisSpacing: 4, childAspectRatio: 1.0),
                itemCount: 30,
                itemBuilder: (_, i) {
                  final done = _data[i];
                  return Container(
                    decoration: BoxDecoration(
                      color: done ? _sky.withOpacity(0.2) : Colors.white.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: done ? _sky.withOpacity(0.4) : Colors.white.withOpacity(0.06)),
                    ),
                    child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text('${i + 1}', style: TextStyle(color: done ? _sky : Colors.white30, fontSize: 9, fontWeight: FontWeight.w700)),
                      if (done) Icon(Icons.check_rounded, color: _sky, size: 8),
                    ])),
                  );
                },
              ),
              const SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(width: 12, height: 12, decoration: BoxDecoration(color: _sky.withOpacity(0.2), borderRadius: BorderRadius.circular(3), border: Border.all(color: _sky.withOpacity(0.4)))),
                const SizedBox(width: 6), const Text('Completed', style: TextStyle(color: Colors.white54, fontSize: 10)),
                const SizedBox(width: 16),
                Container(width: 12, height: 12, decoration: BoxDecoration(color: Colors.white.withOpacity(0.04), borderRadius: BorderRadius.circular(3), border: Border.all(color: Colors.white.withOpacity(0.06)))),
                const SizedBox(width: 6), const Text('Missed', style: TextStyle(color: Colors.white54, fontSize: 10)),
              ]),
            ]),
          ),
          const SizedBox(height: 20),
          _SecHead('DISCIPLINE PRINCIPLES', _teal),
          const SizedBox(height: 12),
          _DisciplineCard(color: _blue, icon: Icons.architecture_rounded, title: 'Environment Architecture',
              body: 'The most reliable source of discipline is a well-designed environment — one that makes the disciplined choice the default choice and the undisciplined choice effortful. Before relying on willpower, redesign your surroundings so the right action requires less of it.'),
          const SizedBox(height: 8),
          _DisciplineCard(color: _teal, icon: Icons.loop_rounded, title: 'Habit Stacking',
              body: 'New habits are most reliably installed by attaching them to existing ones — the new behaviour follows immediately after the established cue. Stack three habits together and the chain becomes self-reinforcing, with each completed link making the next more likely.'),
          const SizedBox(height: 8),
          _DisciplineCard(color: _green, icon: Icons.access_time_rounded, title: 'Time-Bound Commitments',
              body: 'Open-ended discipline commitments fail at higher rates than time-bound ones. A 30-day challenge with a defined endpoint is easier to start and complete than an indefinite life change. After completion, the behaviour often persists naturally — the hard start created the pattern.'),
          const SizedBox(height: 8),
          _DisciplineCard(color: _violet, icon: Icons.warning_rounded, title: 'Never Miss Twice',
              body: 'Missing once is human; missing twice is starting a new habit of missing. The "never miss twice" rule is the minimum viable commitment that preserves streaks even through genuine life disruptions — one missed day is noise; two consecutive missed days are the beginning of drift.'),
          const SizedBox(height: 8),
          _DisciplineCard(color: _amber, icon: Icons.celebration_rounded, title: 'Reward Architecture',
              body: 'The brain\'s reward system is triggered not by the reward but by the anticipation of it. Designing explicit, reliable rewards — immediately following disciplined behaviour — accelerates habit formation dramatically. Small immediate rewards beat large delayed ones in every neuroscience study.'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [_blue.withOpacity(0.08), _teal.withOpacity(0.05)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: _blue.withOpacity(0.18))),
            child: Row(children: [
              Icon(Icons.format_quote_rounded, color: _amber, size: 26), const SizedBox(width: 12),
              const Expanded(child: Text('"Discipline is the bridge between goals and accomplishment." — Jim Rohn', style: TextStyle(color: Colors.white, fontSize: 13, height: 1.4, fontStyle: FontStyle.italic))),
            ]),
          ),
        ],
      ),
    );
  }
}

class _BigStat extends StatelessWidget {
  final String value, label; final Color color;
  const _BigStat(this.value, this.label, this.color);
  @override
  Widget build(BuildContext context) => Column(children: [
    Text(value, style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.w900)),
    Text(label, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white38, fontSize: 8, height: 1.2)),
  ]);
}

class _SecHead extends StatelessWidget {
  final String text; final Color color;
  const _SecHead(this.text, this.color);
  @override
  Widget build(BuildContext context) => Row(children: [Container(width: 3, height: 14, color: color), const SizedBox(width: 8), Text(text, style: TextStyle(color: color.withOpacity(0.85), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2))]);
}

class _DisciplineCard extends StatelessWidget {
  final Color color; final IconData icon; final String title, body;
  const _DisciplineCard({required this.color, required this.icon, required this.title, required this.body});
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
