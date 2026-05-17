import 'package:flutter/material.dart';

/// DESIGN: Step-by-Step Wizard — numbered obligation lifecycle with status tracking
class ObligationsBestView extends StatelessWidget {
  const ObligationsBestView({super.key});

  static const _blue = Color(0xFF2563EB);
  static const _sky = Color(0xFF0EA5E9);
  static const _teal = Color(0xFF0D9488);
  static const _green = Color(0xFF10B981);
  static const _amber = Color(0xFFF59E0B);
  static const _red = Color(0xFFEF4444);
  static const _violet = Color(0xFF7C3AED);
  static const _bg = Color(0xFF020810);

  @override
  Widget build(BuildContext context) {
    final obligations = [
      _Obl(status: 'done', title: 'Tax Filing — Q4', dueDate: 'Filed Mar 31', priority: 'High', color: _green, desc: 'Annual income tax return submitted on time. All deductions documented. Acknowledgement received.'),
      _Obl(status: 'done', title: 'Insurance Renewals', dueDate: 'Filed Apr 15', priority: 'High', color: _green, desc: 'Health and vehicle insurance policies renewed. Premium confirmed. Nominee details updated.'),
      _Obl(status: 'active', title: 'Contract Review — Vendor A', dueDate: 'Due May 22', priority: 'Medium', color: _amber, desc: 'Annual vendor agreement renewal. Legal review in progress. Key clauses under negotiation.'),
      _Obl(status: 'active', title: 'Board Report — Q1', dueDate: 'Due May 28', priority: 'High', color: _amber, desc: 'Quarterly performance report for the board of directors. Data compilation complete; narrative in draft.'),
      _Obl(status: 'pending', title: 'Property Tax — FY26', dueDate: 'Due Jun 30', priority: 'Medium', color: _blue, desc: 'Annual property tax assessment and payment. Previous year reference: PT-2025-0447.'),
      _Obl(status: 'overdue', title: 'Compliance Certificate', dueDate: 'Was due Apr 30', priority: 'Critical', color: _red, desc: 'Environmental compliance certificate expired. Immediate renewal required to avoid regulatory penalty.'),
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: const Text('OBLIGATIONS', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 14, color: Colors.white)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 14), child: Icon(Icons.assignment_rounded, color: _blue, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        children: [
          // OBLIGATION SUMMARY
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(
              gradient: LinearGradient(colors: [const Color(0xFF030D20), const Color(0xFF01060E)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(20), border: Border.all(color: _blue.withOpacity(0.25)),
            ),
            child: Row(children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('OBLIGATION REGISTRY', style: TextStyle(color: _sky, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 2)),
                const SizedBox(height: 6),
                const Text('All commitments, legal, professional, and personal — tracked to closure so nothing falls through a gap.', style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.4)),
              ])),
              const SizedBox(width: 16),
              Column(children: [
                _Counter('2', 'Done', _green),
                const SizedBox(height: 6),
                _Counter('2', 'Active', _amber),
                const SizedBox(height: 6),
                _Counter('1', 'Overdue', _red),
              ]),
            ]),
          ),
          const SizedBox(height: 20),
          // STEP-STYLE OBLIGATION LIST
          _SecHead('OBLIGATION LIFECYCLE', _blue),
          const SizedBox(height: 12),
          ...obligations.asMap().entries.map((e) => _OblStep(obl: e.value, index: e.key, isLast: e.key == obligations.length - 1)),
          const SizedBox(height: 20),
          _SecHead('OBLIGATION PRINCIPLES', _teal),
          const SizedBox(height: 12),
          _PrinCard(color: _blue, icon: Icons.track_changes_rounded, title: 'Total Obligation Inventory',
              body: 'Most missed obligations are not forgotten because they were unimportant — they are forgotten because they were never written down. A complete obligation inventory converts the vague anxiety of "things I might have forgotten" into a specific, manageable list.'),
          const SizedBox(height: 8),
          _PrinCard(color: _teal, icon: Icons.notifications_active_rounded, title: 'Lead-Time Alerts',
              body: 'Obligation alerts set only for the due date are too late for all but trivial tasks. AIR\'s obligation system calculates the lead time actually needed to complete the obligation and sets the alert at the start of that lead time — not at the deadline.'),
          const SizedBox(height: 8),
          _PrinCard(color: _violet, icon: Icons.people_rounded, title: 'Delegation Tracking',
              body: 'Delegating an obligation transfers the action but not the accountability. AIR\'s delegation log maintains visibility over who owns each delegated obligation, their completion date, and the verification steps required before the obligation is considered discharged.'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [_blue.withOpacity(0.08), _teal.withOpacity(0.05)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: _blue.withOpacity(0.18))),
            child: Row(children: [
              Icon(Icons.format_quote_rounded, color: _amber, size: 26), const SizedBox(width: 12),
              const Expanded(child: Text('"The best time to plant a tree was 20 years ago. The second best time is now." — Chinese Proverb', style: TextStyle(color: Colors.white, fontSize: 12, height: 1.4, fontStyle: FontStyle.italic))),
            ]),
          ),
        ],
      ),
    );
  }
}

class _Obl {
  final String status, title, dueDate, priority, desc; final Color color;
  const _Obl({required this.status, required this.title, required this.dueDate, required this.priority, required this.color, required this.desc});
}

class _OblStep extends StatelessWidget {
  final _Obl obl; final int index; final bool isLast;
  const _OblStep({required this.obl, required this.index, required this.isLast});
  @override
  Widget build(BuildContext context) => Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Column(children: [
      Container(width: 32, height: 32, decoration: BoxDecoration(shape: BoxShape.circle, color: obl.color.withOpacity(0.15), border: Border.all(color: obl.color, width: 1.5)),
        child: Center(child: Icon(_statusIcon(obl.status), color: obl.color, size: 14))),
      if (!isLast) Container(width: 2, height: 70, color: obl.color.withOpacity(0.15)),
    ]),
    const SizedBox(width: 12),
    Expanded(child: Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(color: obl.color.withOpacity(0.06), borderRadius: BorderRadius.circular(12), border: Border.all(color: obl.color.withOpacity(0.18))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Expanded(child: Text(obl.title, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700))),
          Container(padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2), decoration: BoxDecoration(color: obl.color.withOpacity(0.12), borderRadius: BorderRadius.circular(5)), child: Text(obl.priority, style: TextStyle(color: obl.color, fontSize: 8, fontWeight: FontWeight.w900))),
        ]),
        const SizedBox(height: 3),
        Text(obl.dueDate, style: TextStyle(color: obl.color.withOpacity(0.7), fontSize: 10)),
        const SizedBox(height: 5),
        Text(obl.desc, style: const TextStyle(color: Colors.white50, fontSize: 10, height: 1.4)),
      ]),
    )),
  ]);
  IconData _statusIcon(String s) => s == 'done' ? Icons.check_circle_rounded : s == 'active' ? Icons.timelapse_rounded : s == 'overdue' ? Icons.warning_rounded : Icons.radio_button_unchecked_rounded;
}

class _Counter extends StatelessWidget {
  final String value, label; final Color color;
  const _Counter(this.value, this.label, this.color);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(6), border: Border.all(color: color.withOpacity(0.2))),
    child: Row(children: [Text(value, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w900)), const SizedBox(width: 4), Text(label, style: TextStyle(color: color.withOpacity(0.7), fontSize: 9))]),
  );
}

class _SecHead extends StatelessWidget {
  final String text; final Color color;
  const _SecHead(this.text, this.color);
  @override
  Widget build(BuildContext context) => Row(children: [Container(width: 3, height: 14, color: color), const SizedBox(width: 8), Text(text, style: TextStyle(color: color.withOpacity(0.85), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2))]);
}

class _PrinCard extends StatelessWidget {
  final Color color; final IconData icon; final String title, body;
  const _PrinCard({required this.color, required this.icon, required this.title, required this.body});
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
