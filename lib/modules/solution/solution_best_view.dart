import 'package:flutter/material.dart';

/// DESIGN: Problem-Solution Matrix — two-column comparison cards with bridge connector
class SolutionBestView extends StatelessWidget {
  const SolutionBestView({super.key});

  static const _red = Color(0xFFEF4444);
  static const _green = Color(0xFF10B981);
  static const _amber = Color(0xFFF59E0B);
  static const _blue = Color(0xFF2563EB);
  static const _violet = Color(0xFF7C3AED);
  static const _sky = Color(0xFF0EA5E9);
  static const _bg = Color(0xFF020C02);

  @override
  Widget build(BuildContext context) {
    final pairs = [
      _Pair(problem: 'Unstructured thinking leads to incomplete analysis and missed solutions.', solution: 'The 5-Why drill surfaces root causes that symptom-level analysis never reaches.', category: 'Root Cause'),
      _Pair(problem: 'Cognitive bias distorts problem assessment — we see what we expect to see.', solution: 'Structured devil\'s advocate and pre-mortem sessions counteract confirmation bias systematically.', category: 'Bias Correction'),
      _Pair(problem: 'Solutions are implemented before the problem is fully understood.', solution: 'A mandatory problem-definition review gate must be cleared before solution ideation begins.', category: 'Definition First'),
      _Pair(problem: 'Multiple good solutions compete without a clear evaluation framework.', solution: 'Weighted decision matrices score each option across criteria before selection, removing gut-preference bias.', category: 'Decision Framework'),
      _Pair(problem: 'Solutions fail in implementation despite being sound in design.', solution: 'Solution post-mortems distinguish design failures from execution failures — learning targets differ for each.', category: 'Implementation'),
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: const Text('SOLUTION INTELLIGENCE', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 13, color: Colors.white)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 14), child: Icon(Icons.psychology_rounded, color: _green, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        children: [
          // HERO
          Container(
            padding: const EdgeInsets.all(18), decoration: BoxDecoration(
              gradient: LinearGradient(colors: [const Color(0xFF001A00), _green.withOpacity(0.08)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(20), border: Border.all(color: _green.withOpacity(0.28)),
            ),
            child: Row(children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('PROBLEM → SOLUTION MATRIX', style: TextStyle(color: _green, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 2)),
                const SizedBox(height: 8),
                const Text('Every problem has a solution pathway. AIR structures the mapping systematically so no problem stays unsolved from lack of rigorous thinking.', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700, height: 1.35)),
              ])),
              const SizedBox(width: 16),
              Column(children: [
                _StatChip('94%', 'Solve Rate', _green),
                const SizedBox(height: 8),
                _StatChip('2.3d', 'Avg. Time', _sky),
              ]),
            ]),
          ),
          const SizedBox(height: 20),
          // COLUMN HEADERS
          Row(children: [
            Expanded(child: Container(padding: const EdgeInsets.symmetric(vertical: 8), decoration: BoxDecoration(color: _red.withOpacity(0.1), borderRadius: BorderRadius.circular(8), border: Border.all(color: _red.withOpacity(0.25))), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.close_rounded, color: Color(0xFFEF4444), size: 14), const SizedBox(width: 4), Text('PROBLEM', style: TextStyle(color: _red, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1))]))),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward_rounded, color: Colors.white24, size: 18),
            const SizedBox(width: 8),
            Expanded(child: Container(padding: const EdgeInsets.symmetric(vertical: 8), decoration: BoxDecoration(color: _green.withOpacity(0.1), borderRadius: BorderRadius.circular(8), border: Border.all(color: _green.withOpacity(0.25))), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.check_rounded, color: Color(0xFF10B981), size: 14), const SizedBox(width: 4), Text('SOLUTION', style: TextStyle(color: _green, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1))]))),
          ]),
          const SizedBox(height: 12),
          // PROBLEM-SOLUTION PAIRS
          ...pairs.asMap().entries.map((e) => _PairCard(pair: e.value, index: e.key + 1)),
          const SizedBox(height: 20),
          // SOLUTION TOOLS
          Row(children: [Container(width: 3, height: 14, color: _violet), const SizedBox(width: 8), Text('SOLUTION TOOLKIT', style: TextStyle(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2))]),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: _ToolTile(color: _violet, icon: Icons.account_tree_rounded, title: '5-Why Drill', body: 'Iterative root cause analysis that prevents treating symptoms as problems.')),
            const SizedBox(width: 8),
            Expanded(child: _ToolTile(color: _amber, icon: Icons.balance_rounded, title: 'Decision Matrix', body: 'Weighted scoring across criteria for objective solution selection.')),
          ]),
          const SizedBox(height: 8),
          Row(children: [
            Expanded(child: _ToolTile(color: _blue, icon: Icons.loop_rounded, title: 'Pre-Mortem', body: 'Imagining failure before it happens to surface hidden risks in your solution.')),
            const SizedBox(width: 8),
            Expanded(child: _ToolTile(color: _sky, icon: Icons.timeline_rounded, title: 'Solution Log', body: 'Track every solution attempted and its outcome — building a personal playbook.')),
          ]),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [_green.withOpacity(0.08), _blue.withOpacity(0.05)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: _green.withOpacity(0.18))),
            child: Row(children: [
              Icon(Icons.format_quote_rounded, color: _amber, size: 26), const SizedBox(width: 12),
              const Expanded(child: Text('"Every problem has a solution, you just have to be creative enough to find it." — Travis Kalanick', style: TextStyle(color: Colors.white, fontSize: 12, height: 1.4, fontStyle: FontStyle.italic))),
            ]),
          ),
        ],
      ),
    );
  }
}

class _Pair {
  final String problem, solution, category;
  const _Pair({required this.problem, required this.solution, required this.category});
}

class _PairCard extends StatelessWidget {
  final _Pair pair; final int index;
  const _PairCard({required this.pair, required this.index});
  static const _red = Color(0xFFEF4444);
  static const _green = Color(0xFF10B981);
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.white.withOpacity(0.06))),
    child: Column(children: [
      Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), decoration: BoxDecoration(color: Colors.white.withOpacity(0.04), borderRadius: const BorderRadius.vertical(top: Radius.circular(13))),
        child: Row(children: [
          Container(width: 20, height: 20, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(0.08)), child: Center(child: Text('$index', style: const TextStyle(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.w700)))),
          const SizedBox(width: 8),
          Text(pair.category.toUpperCase(), style: const TextStyle(color: Colors.white38, fontSize: 9, fontWeight: FontWeight.w700, letterSpacing: 1)),
        ]),
      ),
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(child: Container(padding: const EdgeInsets.all(12), color: _red.withOpacity(0.05), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [Icon(Icons.warning_rounded, color: _red.withOpacity(0.6), size: 12), const SizedBox(width: 4), Text('PROBLEM', style: TextStyle(color: _red.withOpacity(0.6), fontSize: 8, fontWeight: FontWeight.w800, letterSpacing: 1))]),
          const SizedBox(height: 6),
          Text(pair.problem, style: const TextStyle(color: Colors.white70, fontSize: 11, height: 1.45)),
        ]))),
        Container(width: 1, color: Colors.white.withOpacity(0.05)),
        Expanded(child: Container(padding: const EdgeInsets.all(12), color: _green.withOpacity(0.05), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [Icon(Icons.check_circle_rounded, color: _green.withOpacity(0.6), size: 12), const SizedBox(width: 4), Text('SOLUTION', style: TextStyle(color: _green.withOpacity(0.6), fontSize: 8, fontWeight: FontWeight.w800, letterSpacing: 1))]),
          const SizedBox(height: 6),
          Text(pair.solution, style: const TextStyle(color: Colors.white70, fontSize: 11, height: 1.45)),
        ]))),
      ]),
    ]),
  );
}

class _StatChip extends StatelessWidget {
  final String v, l; final Color c;
  const _StatChip(this.v, this.l, this.c);
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: c.withOpacity(0.1), borderRadius: BorderRadius.circular(8), border: Border.all(color: c.withOpacity(0.2))), child: Column(children: [Text(v, style: TextStyle(color: c, fontSize: 13, fontWeight: FontWeight.w900)), Text(l, style: const TextStyle(color: Colors.white38, fontSize: 8))]));
}

class _ToolTile extends StatelessWidget {
  final Color color; final IconData icon; final String title, body;
  const _ToolTile({required this.color, required this.icon, required this.title, required this.body});
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: color.withOpacity(0.07), borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withOpacity(0.18))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Icon(icon, color: color, size: 18), const SizedBox(height: 6),
    Text(title, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w800)), const SizedBox(height: 4),
    Text(body, style: const TextStyle(color: Colors.white54, fontSize: 10, height: 1.4)),
  ]));
}
