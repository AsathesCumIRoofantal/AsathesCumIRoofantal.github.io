import 'package:flutter/material.dart';

/// DESIGN: Bento Grid — iOS-style bento layout with asymmetric card sizes
class SkillsTalentsBestView extends StatelessWidget {
  const SkillsTalentsBestView({super.key});

  static const _c1 = Color(0xFF6366F1);
  static const _c2 = Color(0xFF8B5CF6);
  static const _c3 = Color(0xFF06B6D4);
  static const _c4 = Color(0xFF10B981);
  static const _c5 = Color(0xFFF59E0B);
  static const _bg = Color(0xFF0D0D0D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: _bg,
            foregroundColor: Colors.white,
            title: const Text('SKILLS & TALENTS', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 3, fontSize: 13, color: Colors.white)),
            centerTitle: true,
            actions: [Padding(padding: const EdgeInsets.only(right: 14), child: Icon(Icons.psychology_rounded, color: _c1, size: 22))],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(14),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // BIG HERO BENTO
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Color(0xFF1E1B4B), Color(0xFF312E81)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: _c1.withOpacity(0.3)),
                  ),
                  child: Stack(children: [
                    Positioned(right: -20, bottom: -20, child: Icon(Icons.psychology_rounded, size: 160, color: _c1.withOpacity(0.08))),
                    Padding(padding: const EdgeInsets.all(24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.end, children: [
                      Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: _c1.withOpacity(0.2), borderRadius: BorderRadius.circular(6)), child: const Text('MASTERY LAB', style: TextStyle(color: _c1, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 2))),
                      const SizedBox(height: 10),
                      const Text('Build skills with\ndeliberate precision.', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900, height: 1.2)),
                    ])),
                  ]),
                ),
                const SizedBox(height: 10),
                // ROW 1: 2 equal cells
                Row(children: [
                  Expanded(child: _BentoCell(color: _c3, icon: Icons.layers_rounded, title: 'Skill Taxonomy', body: 'Organise every skill into learnable, measurable layers — from foundational to expert-level execution.', height: 140)),
                  const SizedBox(width: 10),
                  Expanded(child: _BentoCell(color: _c4, icon: Icons.track_changes_rounded, title: 'Progress Map', body: 'Visual progress rings for each skill category, updated as you log practice sessions.', height: 140)),
                ]),
                const SizedBox(height: 10),
                // WIDE CELL
                _BentoCellWide(color: _c2, icon: Icons.bolt_rounded, title: 'Deliberate Practice Protocol', body: 'True skill mastery requires deliberate practice: focused repetition at the edge of your current capability. AIR structures each session with target difficulty, duration, and reflection prompts so every hour of practice compounds efficiently.'),
                const SizedBox(height: 10),
                // ROW 2: 1/3 + 2/3
                Row(children: [
                  Expanded(flex: 1, child: _BentoStat(color: _c5, value: '10,000', label: 'Hours to\nMastery', icon: Icons.timer_rounded)),
                  const SizedBox(width: 10),
                  Expanded(flex: 2, child: _BentoCell(color: _c1, icon: Icons.school_rounded, title: 'Learning Velocity', body: 'Track how fast you acquire each skill relative to your baseline — and whether your learning rate is accelerating.', height: 120)),
                ]),
                const SizedBox(height: 10),
                // WIDE CELL 2
                _BentoCellWide(color: _c4, icon: Icons.emoji_events_rounded, title: 'Talent vs. Skill', body: 'Talent sets your ceiling; deliberate skill-building determines how close to that ceiling you actually reach. Most people never test their ceiling because they confuse discomfort with incapacity. AIR\'s mastery tracker pushes you into discomfort systematically.'),
                const SizedBox(height: 10),
                // ROW 3: 3 equal stats
                Row(children: [
                  Expanded(child: _BentoStat(color: _c3, value: '23', label: 'Skills\nTracked', icon: Icons.psychology_rounded)),
                  const SizedBox(width: 10),
                  Expanded(child: _BentoStat(color: _c2, value: '4', label: 'Mastery\nLevel', icon: Icons.stars_rounded)),
                  const SizedBox(width: 10),
                  Expanded(child: _BentoStat(color: _c5, value: '87%', label: 'Practice\nRate', icon: Icons.trending_up_rounded)),
                ]),
                const SizedBox(height: 10),
                // QUOTE CELL
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [_c1.withOpacity(0.15), _c2.withOpacity(0.08)]),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: _c1.withOpacity(0.2)),
                  ),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Icon(Icons.format_quote_rounded, color: _c5, size: 30),
                    const SizedBox(height: 8),
                    const Text('"An expert is a person who has made all the mistakes that can be made in a very narrow field." — Niels Bohr', style: TextStyle(color: Colors.white, fontSize: 14, height: 1.5, fontStyle: FontStyle.italic)),
                  ]),
                ),
                const SizedBox(height: 30),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _BentoCell extends StatelessWidget {
  final Color color; final IconData icon; final String title, body; final double height;
  const _BentoCell({required this.color, required this.icon, required this.title, required this.body, required this.height});
  @override
  Widget build(BuildContext context) => Container(
    height: height, padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(18), border: Border.all(color: color.withOpacity(0.22))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(icon, color: color, size: 22),
      const SizedBox(height: 8),
      Text(title, style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.w800)),
      const SizedBox(height: 6),
      Text(body, style: const TextStyle(color: Colors.white60, fontSize: 11, height: 1.4)),
    ]),
  );
}

class _BentoCellWide extends StatelessWidget {
  final Color color; final IconData icon; final String title, body;
  const _BentoCellWide({required this.color, required this.icon, required this.title, required this.body});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(18), border: Border.all(color: color.withOpacity(0.22))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [Icon(icon, color: color, size: 20), const SizedBox(width: 8), Text(title, style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w800))]),
      const SizedBox(height: 10),
      Text(body, style: const TextStyle(color: Colors.white70, fontSize: 12, height: 1.5)),
    ]),
  );
}

class _BentoStat extends StatelessWidget {
  final Color color; final String value, label; final IconData icon;
  const _BentoStat({required this.color, required this.value, required this.label, required this.icon});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: color.withOpacity(0.10), borderRadius: BorderRadius.circular(18), border: Border.all(color: color.withOpacity(0.22))),
    child: Column(children: [
      Icon(icon, color: color, size: 18),
      const SizedBox(height: 6),
      Text(value, style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.w900)),
      const SizedBox(height: 2),
      Text(label, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white54, fontSize: 9, height: 1.3)),
    ]),
  );
}
