import 'package:flutter/material.dart';

/// DESIGN: Accordion/Expandable Process — numbered expandable sections with progress indicators
class ResearchDevelopmentBestView extends StatefulWidget {
  const ResearchDevelopmentBestView({super.key});
  @override
  State<ResearchDevelopmentBestView> createState() => _ResearchDevelopmentBestViewState();
}

class _ResearchDevelopmentBestViewState extends State<ResearchDevelopmentBestView> {
  final Set<int> _open = {0};

  static const _violet = Color(0xFF7C3AED);
  static const _indigo = Color(0xFF4F46E5);
  static const _sky = Color(0xFF0EA5E9);
  static const _teal = Color(0xFF0D9488);
  static const _green = Color(0xFF10B981);
  static const _amber = Color(0xFFF59E0B);
  static const _bg = Color(0xFF04020E);

  final _stages = [
    _Stage(num: '01', color: const Color(0xFF7C3AED), title: 'Problem Definition', status: 'COMPLETE', icon: Icons.search_rounded,
        body: 'The quality of a research question determines the value ceiling of all subsequent work. A well-formed problem definition specifies: what is unknown, what would constitute an answer, who would be changed by the answer, and what it would cost to not know. Most research fails before it begins because this stage is rushed.',
        outputs: ['Problem statement document', 'Stakeholder map', 'Success criteria matrix']),
    _Stage(num: '02', color: const Color(0xFF4F46E5), title: 'Literature Review', status: 'COMPLETE', icon: Icons.library_books_rounded,
        body: 'A rigorous literature review distinguishes genuine knowledge gaps from apparent ones. It prevents reinventing what is already known, positions your work in the broader discourse, and surfaces methodologies that have succeeded or failed on similar problems. AIR structures this as a living document updated throughout the research lifecycle.',
        outputs: ['Annotated bibliography', 'Gap analysis matrix', 'Methodology shortlist']),
    _Stage(num: '03', color: const Color(0xFF0EA5E9), title: 'Hypothesis Formation', status: 'ACTIVE', icon: Icons.lightbulb_rounded,
        body: 'A hypothesis must be falsifiable, specific, and connected directly to the problem statement. The most common hypothesis failure is unfalsifiability — a statement so vague it cannot be disproven, making it uninformative regardless of outcome. AIR\'s hypothesis builder forces precision through a structured template.',
        outputs: ['Primary hypothesis', 'Alternative hypotheses', 'Falsification criteria']),
    _Stage(num: '04', color: const Color(0xFF0D9488), title: 'Methodology Design', status: 'PENDING', icon: Icons.science_rounded,
        body: 'Methodology choices determine what conclusions you can legitimately draw. Quantitative methods generate generalisable statistics; qualitative methods generate contextual depth; mixed methods attempt both. Each requires a different rigour standard, and each has different vulnerability to specific biases.',
        outputs: ['Research design document', 'Data collection protocol', 'Bias mitigation plan']),
    _Stage(num: '05', color: const Color(0xFF10B981), title: 'Data Collection', status: 'PENDING', icon: Icons.data_exploration_rounded,
        body: 'Data collection quality determines the ceiling of analytical value downstream. Garbage in, sophisticated analysis out still produces garbage conclusions. AIR\'s collection protocols include validation checkpoints, inter-rater reliability measures for qualitative data, and automated anomaly flagging for quantitative streams.',
        outputs: ['Raw dataset', 'Collection audit trail', 'Quality validation report']),
    _Stage(num: '06', color: const Color(0xFFF59E0B), title: 'Analysis & Findings', status: 'PENDING', icon: Icons.insights_rounded,
        body: 'Analysis transforms data into meaning. The most critical discipline at this stage is distinguishing correlation from causation, statistical significance from practical significance, and finding from conclusion. AIR\'s analysis framework includes a "so what?" layer that forces each finding to be connected to its actionable implication.',
        outputs: ['Statistical analysis report', 'Key findings summary', 'Implication mapping']),
    _Stage(num: '07', color: const Color(0xFFE11D48), title: 'Dissemination', status: 'PENDING', icon: Icons.share_rounded,
        body: 'Research that is not communicated is research that does not exist — its value is zero regardless of quality. Dissemination strategy should be designed before data collection begins, not after analysis is complete. Different audiences require radically different communication formats, levels of technical detail, and calls to action.',
        outputs: ['Executive summary', 'Technical report', 'Stakeholder presentations']),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: const Text('R&D PIPELINE', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 3, fontSize: 13, color: Colors.white)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 14), child: Icon(Icons.biotech_rounded, color: _violet, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        children: [
          // HERO
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(gradient: LinearGradient(colors: [const Color(0xFF1A0A40), const Color(0xFF0C0520)], begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(20), border: Border.all(color: _violet.withOpacity(0.3))),
            child: Row(children: [
              const SizedBox(width: 4),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('RESEARCH PIPELINE', style: TextStyle(color: _violet, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 2)),
                const SizedBox(height: 6),
                const Text('7-Stage Research\nDevelopment System', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900, height: 1.2)),
                const SizedBox(height: 10),
                Row(children: [
                  _Chip('2 Complete', _green), const SizedBox(width: 8),
                  _Chip('1 Active', _amber), const SizedBox(width: 8),
                  _Chip('4 Pending', Colors.white38),
                ]),
              ])),
              const SizedBox(width: 16),
              SizedBox(width: 60, height: 60, child: Stack(alignment: Alignment.center, children: [
                CircularProgressIndicator(value: 2/7, backgroundColor: Colors.white12, color: _violet, strokeWidth: 5),
                const Text('29%', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w900)),
              ])),
            ]),
          ),
          const SizedBox(height: 20),
          // ACCORDION
          ..._stages.asMap().entries.map((e) {
            final i = e.key; final s = e.value; final isOpen = _open.contains(i);
            return Column(children: [
              GestureDetector(
                onTap: () => setState(() { if (isOpen) _open.remove(i); else _open.add(i); }),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: isOpen ? s.color.withOpacity(0.10) : s.color.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: s.color.withOpacity(isOpen ? 0.35 : 0.15)),
                  ),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(children: [
                        Container(width: 30, height: 30, decoration: BoxDecoration(shape: BoxShape.circle, color: s.color.withOpacity(0.15), border: Border.all(color: s.color.withOpacity(0.4))), child: Center(child: Text(s.num, style: TextStyle(color: s.color, fontSize: 10, fontWeight: FontWeight.w900)))),
                        const SizedBox(width: 10),
                        Icon(s.icon, color: s.color, size: 18),
                        const SizedBox(width: 8),
                        Expanded(child: Text(s.title, style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700))),
                        Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: _statusColor(s.status).withOpacity(0.12), borderRadius: BorderRadius.circular(6)), child: Text(s.status, style: TextStyle(color: _statusColor(s.status), fontSize: 8, fontWeight: FontWeight.w800, letterSpacing: 1))),
                        const SizedBox(width: 8),
                        Icon(isOpen ? Icons.expand_less_rounded : Icons.expand_more_rounded, color: Colors.white38, size: 18),
                      ]),
                    ),
                    if (isOpen) Padding(
                      padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Container(height: 1, color: s.color.withOpacity(0.15), margin: const EdgeInsets.only(bottom: 12)),
                        Text(s.body, style: const TextStyle(color: Colors.white70, fontSize: 12, height: 1.55)),
                        const SizedBox(height: 12),
                        Text('OUTPUTS', style: TextStyle(color: s.color.withOpacity(0.8), fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 2)),
                        const SizedBox(height: 6),
                        ...s.outputs.map((o) => Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(children: [
                            Icon(Icons.check_circle_rounded, color: s.color, size: 12),
                            const SizedBox(width: 6),
                            Text(o, style: const TextStyle(color: Colors.white60, fontSize: 11)),
                          ]),
                        )),
                      ]),
                    ),
                  ]),
                ),
              ),
            ]);
          }),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(gradient: LinearGradient(colors: [_violet.withOpacity(0.10), _indigo.withOpacity(0.06)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: _violet.withOpacity(0.2))),
            child: Row(children: [
              Icon(Icons.format_quote_rounded, color: _amber, size: 26),
              const SizedBox(width: 12),
              const Expanded(child: Text('"Research is creating new knowledge." — Neil Armstrong', style: TextStyle(color: Colors.white, fontSize: 13, height: 1.4, fontStyle: FontStyle.italic))),
            ]),
          ),
        ],
      ),
    );
  }

  Color _statusColor(String s) => s == 'COMPLETE' ? _green : s == 'ACTIVE' ? _amber : Colors.white38;
}

class _Stage {
  final String num, title, status, body; final Color color; final IconData icon; final List<String> outputs;
  const _Stage({required this.num, required this.color, required this.title, required this.status, required this.icon, required this.body, required this.outputs});
}

class _Chip extends StatelessWidget {
  final String label; final Color color;
  const _Chip(this.label, this.color);
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(6)), child: Text(label, style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.w700)));
}
