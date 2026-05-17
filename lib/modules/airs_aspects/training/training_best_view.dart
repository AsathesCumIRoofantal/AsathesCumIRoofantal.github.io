import 'package:flutter/material.dart';

/// DESIGN: Training Program Board — syllabus-style modules with completion tracking
class TrainingBestView extends StatelessWidget {
  const TrainingBestView({super.key});

  static const _blue = Color(0xFF2563EB);
  static const _sky = Color(0xFF0EA5E9);
  static const _teal = Color(0xFF0D9488);
  static const _green = Color(0xFF10B981);
  static const _amber = Color(0xFFF59E0B);
  static const _violet = Color(0xFF7C3AED);
  static const _bg = Color(0xFF020810);

  @override
  Widget build(BuildContext context) {
    final modules = [
      _Module(num: '01', status: 'done', color: _green, title: 'Foundations of Learning', duration: '4h 20m', lessons: 8, score: 94, topics: ['Learning theory', 'Memory consolidation', 'Note-taking systems', 'Retrieval practice']),
      _Module(num: '02', status: 'done', color: _green, title: 'Communication Mastery', duration: '6h 15m', lessons: 12, score: 88, topics: ['Active listening', 'Written clarity', 'Presentation structure', 'Difficult conversations']),
      _Module(num: '03', status: 'active', color: _amber, title: 'Critical Thinking', duration: '5h 45m', lessons: 10, score: 0, topics: ['Logical fallacies', 'Evidence evaluation', 'Argument mapping', 'Decision frameworks']),
      _Module(num: '04', status: 'pending', color: _blue, title: 'Leadership Fundamentals', duration: '7h 30m', lessons: 14, score: 0, topics: ['Influence without authority', 'Delegation', 'Feedback culture', 'Vision communication']),
      _Module(num: '05', status: 'pending', color: _violet, title: 'Strategic Thinking', duration: '8h 00m', lessons: 15, score: 0, topics: ['Systems thinking', 'Scenario planning', 'Competitive analysis', 'Long-term mapping']),
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: const Text('TRAINING PROGRAM', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 13, color: Colors.white)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 14), child: Icon(Icons.school_rounded, color: _blue, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        children: [
          // PROGRAM OVERVIEW
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(
              gradient: LinearGradient(colors: [const Color(0xFF030D20), const Color(0xFF010810)]),
              borderRadius: BorderRadius.circular(20), border: Border.all(color: _blue.withOpacity(0.25)),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('ADVANCED INTELLIGENCE PROGRAM', style: TextStyle(color: _sky, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 2)),
              const SizedBox(height: 6),
              const Text('5 Modules • 31h 50m • 59 Lessons', style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.3)),
              const SizedBox(height: 12),
              // PROGRESS BAR
              Row(children: [
                Expanded(child: Stack(children: [
                  Container(height: 8, decoration: BoxDecoration(color: Colors.white.withOpacity(0.06), borderRadius: BorderRadius.circular(4))),
                  FractionallySizedBox(widthFactor: 0.40, child: Container(height: 8, decoration: BoxDecoration(gradient: LinearGradient(colors: [_green, _sky]), borderRadius: BorderRadius.circular(4)))),
                ])),
                const SizedBox(width: 10),
                Text('40%', style: TextStyle(color: _green, fontSize: 12, fontWeight: FontWeight.w900)),
              ]),
              const SizedBox(height: 4),
              const Text('2 of 5 modules complete • Next: Module 03', style: TextStyle(color: Colors.white38, fontSize: 9)),
              const SizedBox(height: 12),
              Row(children: [
                _Stat('31h', 'Total Time', _sky), const SizedBox(width: 8),
                _Stat('91%', 'Avg Score', _green), const SizedBox(width: 8),
                _Stat('Cert.', 'On Track', _amber), const SizedBox(width: 8),
                _Stat('4.8★', 'Rating', _violet),
              ]),
            ]),
          ),
          const SizedBox(height: 20),
          _SecHead('MODULE SYLLABUS', _blue),
          const SizedBox(height: 12),
          ...modules.map((m) => _ModuleCard(module: m)),
          const SizedBox(height: 20),
          _SecHead('TRAINING PHILOSOPHY', _teal),
          const SizedBox(height: 12),
          _PhiloCard(color: _teal, icon: Icons.loop_rounded, title: 'Deliberate Practice Architecture',
              body: 'AIR training modules are structured around deliberate practice — each lesson introduces a concept, demonstrates application, requires practice with feedback, and schedules a spaced review. This architecture produces retention rates 3–4x higher than conventional instruction.'),
          const SizedBox(height: 8),
          _PhiloCard(color: _amber, icon: Icons.people_rounded, title: 'Cohort Learning',
              body: 'Learning alongside others increases completion rates by 60% and produces better outcomes through peer discussion, challenge, and accountability. AIR matches you to cohorts at similar stages with complementary backgrounds.'),
          const SizedBox(height: 8),
          _PhiloCard(color: _violet, icon: Icons.trending_up_rounded, title: 'Applied Learning Protocol',
              body: 'Every module concludes with a real-world application project — a documented attempt to use the module content in your actual context. The application project is more important than the assessment for long-term capability development.'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [_blue.withOpacity(0.08), _teal.withOpacity(0.05)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: _blue.withOpacity(0.18))),
            child: Row(children: [
              Icon(Icons.format_quote_rounded, color: _amber, size: 26), const SizedBox(width: 12),
              const Expanded(child: Text('"Education is not the filling of a pail, but the lighting of a fire." — W.B. Yeats', style: TextStyle(color: Colors.white, fontSize: 13, height: 1.4, fontStyle: FontStyle.italic))),
            ]),
          ),
        ],
      ),
    );
  }
}

class _Module { final String num, status, title, duration; final Color color; final int lessons, score; final List<String> topics; const _Module({required this.num, required this.status, required this.color, required this.title, required this.duration, required this.lessons, required this.score, required this.topics}); }

class _ModuleCard extends StatelessWidget {
  final _Module module;
  const _ModuleCard({required this.module});
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: module.color.withOpacity(0.07), borderRadius: BorderRadius.circular(14), border: Border.all(color: module.color.withOpacity(0.22))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Container(width: 28, height: 28, decoration: BoxDecoration(shape: BoxShape.circle, color: module.color.withOpacity(0.15), border: Border.all(color: module.color.withOpacity(0.4))),
          child: Center(child: module.status == 'done' ? Icon(Icons.check_rounded, color: module.color, size: 14) : Text(module.num, style: TextStyle(color: module.color, fontSize: 9, fontWeight: FontWeight.w900)))),
        const SizedBox(width: 10),
        Expanded(child: Text(module.title, style: TextStyle(color: module.color, fontSize: 13, fontWeight: FontWeight.w700))),
        Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: module.color.withOpacity(0.12), borderRadius: BorderRadius.circular(6)), child: Text(module.status.toUpperCase(), style: TextStyle(color: module.color, fontSize: 8, fontWeight: FontWeight.w900, letterSpacing: 1))),
      ]),
      const SizedBox(height: 8),
      Row(children: [
        Icon(Icons.timer_rounded, color: Colors.white30, size: 12), const SizedBox(width: 4),
        Text(module.duration, style: const TextStyle(color: Colors.white38, fontSize: 10)),
        const SizedBox(width: 12),
        Icon(Icons.book_rounded, color: Colors.white30, size: 12), const SizedBox(width: 4),
        Text('${module.lessons} lessons', style: const TextStyle(color: Colors.white38, fontSize: 10)),
        if (module.score > 0) ...[const SizedBox(width: 12), Icon(Icons.star_rounded, color: const Color(0xFFF59E0B), size: 12), Text(' ${module.score}%', style: const TextStyle(color: Color(0xFFF59E0B), fontSize: 10, fontWeight: FontWeight.w700))],
      ]),
      const SizedBox(height: 6),
      Wrap(spacing: 5, runSpacing: 3, children: module.topics.map((t) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.04), borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.white.withOpacity(0.07))),
        child: Text(t, style: const TextStyle(color: Colors.white38, fontSize: 9)),
      )).toList()),
    ]),
  );
}

class _Stat extends StatelessWidget {
  final String v, l; final Color c;
  const _Stat(this.v, this.l, this.c);
  @override
  Widget build(BuildContext context) => Expanded(child: Container(padding: const EdgeInsets.symmetric(vertical: 7), decoration: BoxDecoration(color: c.withOpacity(0.08), borderRadius: BorderRadius.circular(8), border: Border.all(color: c.withOpacity(0.18))), child: Column(children: [Text(v, style: TextStyle(color: c, fontSize: 12, fontWeight: FontWeight.w900)), Text(l, style: const TextStyle(color: Colors.white30, fontSize: 8))])));
}

class _SecHead extends StatelessWidget {
  final String text; final Color color;
  const _SecHead(this.text, this.color);
  @override
  Widget build(BuildContext context) => Row(children: [Container(width: 3, height: 14, color: color), const SizedBox(width: 8), Text(text, style: TextStyle(color: color.withOpacity(0.85), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2))]);
}

class _PhiloCard extends StatelessWidget {
  final Color color; final IconData icon; final String title, body;
  const _PhiloCard({required this.color, required this.icon, required this.title, required this.body});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(13), decoration: BoxDecoration(color: color.withOpacity(0.07), borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withOpacity(0.18))),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(padding: const EdgeInsets.all(7), decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(9)), child: Icon(icon, color: color, size: 15)),
      const SizedBox(width: 10),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w800)),
        const SizedBox(height: 4),
        Text(body, style: const TextStyle(color: Colors.white54, fontSize: 11, height: 1.4)),
      ])),
    ]),
  );
}
