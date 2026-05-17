import 'package:flutter/material.dart';

/// DESIGN: Process Flow Diagram — swimlane-style process cards with flow connectors
class ProcessBestView extends StatelessWidget {
  const ProcessBestView({super.key});

  static const _blue = Color(0xFF2563EB);
  static const _sky = Color(0xFF0EA5E9);
  static const _teal = Color(0xFF0D9488);
  static const _green = Color(0xFF10B981);
  static const _amber = Color(0xFFF59E0B);
  static const _violet = Color(0xFF7C3AED);
  static const _bg = Color(0xFF020810);

  @override
  Widget build(BuildContext context) {
    final stages = [
      _Stage(label: 'INPUT', color: _blue, icon: Icons.input_rounded, title: 'Receive & Define', steps: ['Capture requirement', 'Clarify scope', 'Define success criteria', 'Assign ownership']),
      _Stage(label: 'PROCESS', color: _violet, icon: Icons.settings_rounded, title: 'Transform & Build', steps: ['Design solution', 'Execute primary steps', 'Apply quality checks', 'Iterate on feedback']),
      _Stage(label: 'VALIDATE', color: _amber, icon: Icons.fact_check_rounded, title: 'Test & Verify', steps: ['Test against criteria', 'Peer review', 'Stakeholder sign-off', 'Document outcomes']),
      _Stage(label: 'OUTPUT', color: _green, icon: Icons.output_rounded, title: 'Deliver & Close', steps: ['Release to recipient', 'Confirm receipt', 'Gather outcome data', 'Archive learnings']),
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: const Text('PROCESS INTELLIGENCE', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 13, color: Colors.white)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 14), child: Icon(Icons.account_tree_rounded, color: _blue, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        children: [
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(
              gradient: LinearGradient(colors: [const Color(0xFF030D20), const Color(0xFF010810)]),
              borderRadius: BorderRadius.circular(20), border: Border.all(color: _blue.withOpacity(0.25)),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('PROCESS INTELLIGENCE', style: TextStyle(color: _sky, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 2)),
              const SizedBox(height: 8),
              const Text('Every output is the result of a process. Improving the process systematically improves the output reliably — without requiring heroic effort or exceptional talent.', style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.4)),
              const SizedBox(height: 12),
              Row(children: [_Stat('12', 'Active\nProcesses', _blue), const SizedBox(width: 8), _Stat('94%', 'Completion\nRate', _green), const SizedBox(width: 8), _Stat('2.3d', 'Avg Cycle\nTime', _amber), const SizedBox(width: 8), _Stat('4.7★', 'Quality\nScore', _violet)]),
            ]),
          ),
          const SizedBox(height: 20),
          _SecHead('PROCESS FLOW', _blue),
          const SizedBox(height: 12),
          // SWIMLANE FLOW
          ...stages.asMap().entries.map((e) {
            final s = e.value; final isLast = e.key == stages.length - 1;
            return Column(children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: s.color.withOpacity(0.07), borderRadius: BorderRadius.circular(14), border: Border.all(color: s.color.withOpacity(0.25))),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: s.color.withOpacity(0.15), borderRadius: BorderRadius.circular(4)), child: Text(s.label, style: TextStyle(color: s.color, fontSize: 8, fontWeight: FontWeight.w900, letterSpacing: 1))),
                    const SizedBox(width: 10),
                    Icon(s.icon, color: s.color, size: 16),
                    const SizedBox(width: 6),
                    Text(s.title, style: TextStyle(color: s.color, fontSize: 13, fontWeight: FontWeight.w800)),
                  ]),
                  const SizedBox(height: 10),
                  Wrap(spacing: 6, runSpacing: 4, children: s.steps.asMap().entries.map((step) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.04), borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.white.withOpacity(0.07))),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Container(width: 16, height: 16, decoration: BoxDecoration(shape: BoxShape.circle, color: s.color.withOpacity(0.15)), child: Center(child: Text('${step.key + 1}', style: TextStyle(color: s.color, fontSize: 8, fontWeight: FontWeight.w900)))),
                      const SizedBox(width: 5),
                      Text(step.value, style: const TextStyle(color: Colors.white60, fontSize: 10)),
                    ]),
                  )).toList()),
                ]),
              ),
              if (!isLast) Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(width: 2, height: 20, color: s.color.withOpacity(0.3)),
                  const SizedBox(width: 4),
                  Icon(Icons.arrow_downward_rounded, color: s.color.withOpacity(0.5), size: 16),
                ]),
              ),
            ]);
          }),
          const SizedBox(height: 20),
          _SecHead('PROCESS DESIGN PRINCIPLES', _teal),
          const SizedBox(height: 12),
          _ProcCard(color: _sky, icon: Icons.track_changes_rounded, title: 'Document to Improve',
              body: 'A process that exists only in someone\'s head is not a process — it is a single person\'s habit. Documenting processes reveals variation, creates training material, and enables systematic improvement. The act of documentation itself often surfaces improvement opportunities.'),
          const SizedBox(height: 8),
          _ProcCard(color: _teal, icon: Icons.trending_up_rounded, title: 'Measure What Matters',
              body: 'The right process metrics measure outcomes (quality, time, error rate) not just activities (steps completed). Activity metrics generate the illusion of process health; outcome metrics reveal the truth. Measure both, but weight outcomes more heavily in process improvement decisions.'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [_blue.withOpacity(0.08), _teal.withOpacity(0.05)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: _blue.withOpacity(0.18))),
            child: Row(children: [
              Icon(Icons.format_quote_rounded, color: _amber, size: 26), const SizedBox(width: 12),
              const Expanded(child: Text('"If you can\'t describe what you are doing as a process, you don\'t know what you\'re doing." — W. Edwards Deming', style: TextStyle(color: Colors.white, fontSize: 12, height: 1.4, fontStyle: FontStyle.italic))),
            ]),
          ),
        ],
      ),
    );
  }
}

class _Stage { final String label, title; final Color color; final IconData icon; final List<String> steps; const _Stage({required this.label, required this.color, required this.icon, required this.title, required this.steps}); }

class _Stat extends StatelessWidget {
  final String v, l; final Color c;
  const _Stat(this.v, this.l, this.c);
  @override
  Widget build(BuildContext context) => Expanded(child: Container(padding: const EdgeInsets.symmetric(vertical: 7), decoration: BoxDecoration(color: c.withOpacity(0.08), borderRadius: BorderRadius.circular(8), border: Border.all(color: c.withOpacity(0.18))), child: Column(children: [Text(v, style: TextStyle(color: c, fontSize: 12, fontWeight: FontWeight.w900)), Text(l, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white30, fontSize: 8, height: 1.2))])));
}

class _SecHead extends StatelessWidget {
  final String text; final Color color;
  const _SecHead(this.text, this.color);
  @override
  Widget build(BuildContext context) => Row(children: [Container(width: 3, required: color), const SizedBox(width: 8), Text(text, style: TextStyle(color: color.withOpacity(0.85), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2))]);
}

class _ProcCard extends StatelessWidget {
  final Color color; final IconData icon; final String title, body;
  const _ProcCard({required this.color, required this.icon, required this.title, required this.body});
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
