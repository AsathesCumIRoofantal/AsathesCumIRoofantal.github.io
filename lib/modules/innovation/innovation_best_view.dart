import 'package:flutter/material.dart';

/// DESIGN: Blueprint/Schematic — technical drawing aesthetic with innovation framework
class InnovationBestView extends StatelessWidget {
  const InnovationBestView({super.key});

  static const _cyan = Color(0xFF06B6D4);
  static const _blue = Color(0xFF1D4ED8);
  static const _sky = Color(0xFF0EA5E9);
  static const _amber = Color(0xFFF59E0B);
  static const _green = Color(0xFF10B981);
  static const _violet = Color(0xFF7C3AED);
  static const _bg = Color(0xFF020B10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.architecture_rounded, color: _cyan, size: 18),
          const SizedBox(width: 8),
          const Text('INNOVATION BLUEPRINT', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 12, color: Colors.white)),
        ]),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 8, 14, 40),
        children: [
          // BLUEPRINT HEADER
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF04101A),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _cyan.withOpacity(0.3)),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Text('DRAWING NO: AIR-INNO-2026', style: TextStyle(color: _cyan.withOpacity(0.6), fontSize: 8, fontFamily: 'monospace', letterSpacing: 1)),
                const Spacer(),
                Text('REV: 5.2', style: TextStyle(color: _cyan.withOpacity(0.6), fontSize: 8, fontFamily: 'monospace')),
              ]),
              Container(height: 1, margin: const EdgeInsets.symmetric(vertical: 8), color: _cyan.withOpacity(0.2)),
              Text('INNOVATION FRAMEWORK', style: TextStyle(color: _cyan, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 3)),
              const SizedBox(height: 6),
              const Text('TITLE: SYSTEMATIC INNOVATION DEVELOPMENT PROCESS', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
              Container(height: 1, margin: const EdgeInsets.symmetric(vertical: 8), color: _cyan.withOpacity(0.2)),
              Row(children: [
                _Spec('STATUS', 'APPROVED', _green),
                const SizedBox(width: 16),
                _Spec('CLASS', 'PROCESS', _sky),
                const SizedBox(width: 16),
                _Spec('STAGE', 'PRODUCTION', _amber),
              ]),
            ]),
          ),
          const SizedBox(height: 16),
          // INNOVATION PROCESS BLUEPRINT CARDS
          _BlueprintSection(
            label: 'SECTION A', color: _violet, title: 'Insight Generation',
            spec: 'MAX CONSTRAINTS: None | MIN DIVERSITY: High | OUTPUT: Problem Statements',
            body: 'Insight generation is the intelligence-gathering phase. It requires deliberate exposure to diverse information sources — customer conversations, failure analyses, cross-domain literature, and leading indicator data. Output: a prioritised set of problems worth solving.'),
          _BlueprintSection(
            label: 'SECTION B', color: _blue, title: 'Concept Development',
            spec: 'TOOL: SCAMPER + First Principles | DURATION: 48-72 hrs | OUTPUT: Concept Set',
            body: 'Concept development transforms insights into potential solutions. Divergent phase generates as many solutions as possible without evaluation; convergent phase applies feasibility, desirability, and viability filters to select the highest-potential concepts for prototyping.'),
          _BlueprintSection(
            label: 'SECTION C', color: _cyan, title: 'Rapid Prototyping',
            spec: 'FIDELITY: Low → High | CYCLE TIME: <72 hrs | OUTPUT: Learning Evidence',
            body: 'Prototypes are learning instruments, not product previews. The lowest-fidelity prototype that can test the most critical assumption is always the right prototype to build first. Each cycle produces evidence that informs the next iteration rather than confirming the current design.'),
          _BlueprintSection(
            label: 'SECTION D', color: _amber, title: 'Validation Testing',
            spec: 'METHOD: A/B + User Testing | SAMPLE: Min 30 users | OUTPUT: Go/No-Go Decision',
            body: 'Validation separates product-market fit from founder enthusiasm. Defined success metrics must be established before testing begins. A validation result is only valid if the failure outcome was genuinely accepted as a real possibility before the test was designed.'),
          _BlueprintSection(
            label: 'SECTION E', color: _green, title: 'Scale & Deployment',
            spec: 'ROLLOUT: Staged | MONITORING: Continuous | OUTPUT: Live Innovation',
            body: 'Scale requires systems, not just solutions. The processes, metrics, and feedback loops that sustain the innovation at scale must be designed before scaling begins. Most innovations that fail at scale fail because their operational requirements were not designed in — they were expected to emerge.'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: const Color(0xFF04101A), borderRadius: BorderRadius.circular(14), border: Border.all(color: _cyan.withOpacity(0.2))),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('DESIGN NOTES', style: TextStyle(color: _cyan.withOpacity(0.6), fontSize: 8, fontFamily: 'monospace', letterSpacing: 2)),
              const SizedBox(height: 6),
              const Text('"Innovation is seeing what everybody has seen and thinking what nobody has thought." — Albert Szent-Györgyi', style: TextStyle(color: Colors.white60, fontSize: 12, height: 1.4, fontStyle: FontStyle.italic)),
            ]),
          ),
        ],
      ),
    );
  }
}

class _Spec extends StatelessWidget {
  final String label, value; final Color color;
  const _Spec(this.label, this.value, this.color);
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(label, style: const TextStyle(color: Colors.white30, fontSize: 7, fontFamily: 'monospace', letterSpacing: 1)),
    Text(value, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w700, fontFamily: 'monospace')),
  ]);
}

class _BlueprintSection extends StatelessWidget {
  final String label, title, spec, body; final Color color;
  const _BlueprintSection({required this.label, required this.color, required this.title, required this.spec, required this.body});
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withOpacity(0.25))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7), decoration: BoxDecoration(color: color.withOpacity(0.10), borderRadius: const BorderRadius.vertical(top: Radius.circular(11))),
        child: Row(children: [
          Text(label, style: TextStyle(color: color.withOpacity(0.7), fontSize: 8, fontFamily: 'monospace', fontWeight: FontWeight.w700, letterSpacing: 2)),
          const SizedBox(width: 12),
          Text(title, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w800)),
        ])),
      Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5), color: const Color(0xFF03080D), child: Text(spec, style: TextStyle(color: Colors.white24, fontSize: 9, fontFamily: 'monospace'))),
      Padding(padding: const EdgeInsets.all(12), child: Text(body, style: const TextStyle(color: Colors.white60, fontSize: 11, height: 1.5))),
    ]),
  );
}
