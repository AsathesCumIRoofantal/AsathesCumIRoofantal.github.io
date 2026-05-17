import 'package:flutter/material.dart';

/// DESIGN: Vertical Timeline Journey — milestone nodes with connectors
class WisdomBestView extends StatelessWidget {
  const WisdomBestView({super.key});

  static const _gold = Color(0xFFF59E0B);
  static const _amber = Color(0xFFD97706);
  static const _teal = Color(0xFF0D9488);
  static const _violet = Color(0xFF7C3AED);
  static const _rose = Color(0xFFF43F5E);
  static const _bg = Color(0xFF080604);

  @override
  Widget build(BuildContext context) {
    final milestones = [
      _Milestone(step: '01', color: _gold, icon: Icons.self_improvement_rounded, title: 'Observe Deeply', subtitle: 'The First Gate', body: 'Wisdom begins not with knowing but with watching. The wise person sees patterns invisible to the hurried mind — the second-order effects, the hidden costs, the long arcs of consequence. Develop the habit of observation before conclusion.'),
      _Milestone(step: '02', color: _teal, icon: Icons.history_edu_rounded, title: 'Learn from Failure', subtitle: 'The Second Gate', body: 'Every failure is a compressed lesson. The unwise person avoids failure; the wise person extracts its full educational value. Catalogue your mistakes with the same rigour you would apply to successes — the lessons are often more durable.'),
      _Milestone(step: '03', color: _violet, icon: Icons.people_alt_rounded, title: 'Borrow from Masters', subtitle: 'The Third Gate', body: 'A lifetime of reading great thinkers compresses millennia of experimentation into transferable insight. The wise person curates a canon — thinkers whose frameworks remain useful under new conditions — and returns to them repeatedly.'),
      _Milestone(step: '04', color: _rose, icon: Icons.balance_rounded, title: 'Hold Paradox', subtitle: 'The Fourth Gate', body: 'Wisdom requires comfort with contradiction. The brave and the cautious are both sometimes right. The wise person holds opposing truths simultaneously without forcing premature resolution — tolerating ambiguity long enough for clarity to emerge naturally.'),
      _Milestone(step: '05', color: _gold, icon: Icons.timer_outlined, title: 'Think Long', subtitle: 'The Fifth Gate', body: 'The primary differentiator between wise and clever is time horizon. The clever optimise for this quarter; the wise for the next decade. Extend your planning horizon deliberately and watch different decisions emerge from identical information.'),
      _Milestone(step: '06', color: _teal, icon: Icons.record_voice_over_rounded, title: 'Speak Slowly', subtitle: 'The Sixth Gate', body: 'The wise person speaks less than they know. Restraint in speech signals mastery of knowledge — the ability to select the most useful truth from many available ones. Silence is often the wisest contribution in a room full of noise.'),
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: const Text('WISDOM', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 4, fontSize: 14, color: Colors.white)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 14), child: Icon(Icons.auto_stories_rounded, color: _gold, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
        children: [
          // HERO
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [const Color(0xFF1C1400), _amber.withOpacity(0.12)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: _gold.withOpacity(0.3)),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('THE SIX GATES', style: TextStyle(color: _gold, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 3)),
              const SizedBox(height: 8),
              const Text('Wisdom is not a destination;\nit is a practice of passage.', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900, height: 1.2)),
              const SizedBox(height: 12),
              Text('Each gate you pass through opens a deeper dimension of understanding that no amount of information alone can provide.', style: TextStyle(color: Colors.white60, fontSize: 13, height: 1.5)),
            ]),
          ),
          const SizedBox(height: 28),
          Text('THE PATH OF WISDOM', style: TextStyle(color: _gold.withOpacity(0.7), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 3)),
          const SizedBox(height: 20),
          // TIMELINE
          ...milestones.asMap().entries.map((e) {
            final m = e.value;
            final isLast = e.key == milestones.length - 1;
            return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Left: step + connector
              Column(children: [
                Container(width: 44, height: 44, decoration: BoxDecoration(shape: BoxShape.circle, color: m.color.withOpacity(0.15), border: Border.all(color: m.color, width: 2)),
                  child: Center(child: Text(m.step, style: TextStyle(color: m.color, fontSize: 12, fontWeight: FontWeight.w900)))),
                if (!isLast) Container(width: 2, height: 120, color: m.color.withOpacity(0.2)),
              ]),
              const SizedBox(width: 16),
              // Right: content
              Expanded(child: Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(m.subtitle, style: TextStyle(color: m.color.withOpacity(0.7), fontSize: 9, fontWeight: FontWeight.w700, letterSpacing: 2)),
                  const SizedBox(height: 4),
                  Row(children: [
                    Icon(m.icon, color: m.color, size: 18),
                    const SizedBox(width: 8),
                    Text(m.title, style: TextStyle(color: m.color, fontSize: 16, fontWeight: FontWeight.w900)),
                  ]),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: m.color.withOpacity(0.06), borderRadius: BorderRadius.circular(14), border: Border.all(color: m.color.withOpacity(0.15))),
                    child: Text(m.body, style: const TextStyle(color: Colors.white70, fontSize: 12, height: 1.55)),
                  ),
                ]),
              )),
            ]);
          }),
          // CLOSING QUOTE
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(gradient: LinearGradient(colors: [_amber.withOpacity(0.12), _violet.withOpacity(0.08)]), borderRadius: BorderRadius.circular(18), border: Border.all(color: _gold.withOpacity(0.2))),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Icon(Icons.format_quote_rounded, color: _gold, size: 28),
              const SizedBox(height: 8),
              const Text('"The invariable mark of wisdom is to see the miraculous in the common." — Ralph Waldo Emerson', style: TextStyle(color: Colors.white, fontSize: 13, height: 1.5, fontStyle: FontStyle.italic)),
            ]),
          ),
        ],
      ),
    );
  }
}

class _Milestone {
  final String step, title, subtitle, body;
  final Color color;
  final IconData icon;
  const _Milestone({required this.step, required this.color, required this.icon, required this.title, required this.subtitle, required this.body});
}
