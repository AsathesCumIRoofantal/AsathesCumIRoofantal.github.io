import 'package:flutter/material.dart';

/// DESIGN: Legal Document — formal legal filing aesthetic with case docket structure
class CourtCasesBestView extends StatelessWidget {
  const CourtCasesBestView({super.key});

  static const _ink = Color(0xFF1E293B);
  static const _gold = Color(0xFFD4A853);
  static const _red = Color(0xFFB91C1C);
  static const _green = Color(0xFF15803D);
  static const _amber = Color(0xFFF59E0B);
  static const _slate = Color(0xFF64748B);
  static const _bg = Color(0xFF020810);

  @override
  Widget build(BuildContext context) {
    final cases = [
      _Case(id: 'CIV-2026-0441', title: 'Contract Dispute — Vendor Breach', status: 'Active', statusColor: _amber, court: 'District Court', filed: 'Mar 12, 2026', nextDate: 'May 28, 2026'),
      _Case(id: 'LAB-2026-0118', title: 'Labour Complaint — Wrongful Dismissal', status: 'Settled', statusColor: _green, court: 'Labour Tribunal', filed: 'Jan 4, 2026', nextDate: 'Closed'),
      _Case(id: 'CRM-2025-2204', title: 'Criminal — Defamation', status: 'Pending', statusColor: _slate, court: 'Sessions Court', filed: 'Nov 20, 2025', nextDate: 'Jun 10, 2026'),
      _Case(id: 'TAX-2026-0067', title: 'Tax Assessment Challenge', status: 'Hearing', statusColor: _red, court: 'Income Tax Tribunal', filed: 'Feb 8, 2026', nextDate: 'May 22, 2026'),
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: Column(children: [
          Text('IN THE MATTER OF', style: TextStyle(color: _gold.withOpacity(0.7), fontSize: 8, letterSpacing: 3, fontWeight: FontWeight.w700)),
          const Text('COURT CASE INTELLIGENCE', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 12, color: Colors.white)),
        ]),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        children: [
          // COURT SEAL HEADER
          Container(
            padding: const EdgeInsets.all(20), decoration: BoxDecoration(
              gradient: LinearGradient(colors: [const Color(0xFF0D1520), const Color(0xFF060D18)], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(20), border: Border.all(color: _gold.withOpacity(0.3)),
            ),
            child: Column(children: [
              Icon(Icons.balance_rounded, color: _gold, size: 36),
              const SizedBox(height: 12),
              Text('CASE REGISTRY SYSTEM', style: TextStyle(color: _gold, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 3)),
              const SizedBox(height: 8),
              const Text('All active, settled, and pending legal matters in one secured view. Know your position, your dates, and your rights at all times.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white60, fontSize: 12, height: 1.4)),
              const SizedBox(height: 16),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                _Metric('4', 'Cases', _gold),
                Container(width: 1, height: 30, color: Colors.white12),
                _Metric('1', 'Hearing Soon', _amber),
                Container(width: 1, height: 30, color: Colors.white12),
                _Metric('1', 'Settled', _green),
                Container(width: 1, height: 30, color: Colors.white12),
                _Metric('2', 'Pending', _slate),
              ]),
            ]),
          ),
          const SizedBox(height: 20),
          // DOCKET HEADER
          Row(children: [
            Container(width: 3, height: 14, color: _gold), const SizedBox(width: 8),
            Text('CASE DOCKET', style: TextStyle(color: _gold.withOpacity(0.8), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2)),
          ]),
          const SizedBox(height: 12),
          // CASE CARDS — LEGAL DOCUMENT STYLE
          ...cases.map((c) => _CaseCard(cas: c)),
          const SizedBox(height: 20),
          // LEGAL TOOLS
          Row(children: [Container(width: 3, height: 14, color: _red), const SizedBox(width: 8), Text('CASE MANAGEMENT TOOLS', style: TextStyle(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2))]),
          const SizedBox(height: 12),
          _LegalTool(icon: Icons.folder_open_rounded, color: _gold, title: 'Evidence Repository', body: 'Structured file store for every piece of evidence — documents, correspondence, photographs, expert reports — indexed by case, date, and relevance tier. Chain of custody is automatically logged for each item.'),
          const SizedBox(height: 8),
          _LegalTool(icon: Icons.people_rounded, color: _amber, title: 'Witness Registry', body: 'Track witnesses — their relationship to the case, their testimony outline, their contact information, and their preparation status. Witness readiness score is calculated before each hearing date.'),
          const SizedBox(height: 8),
          _LegalTool(icon: Icons.schedule_rounded, color: _red, title: 'Hearing Calendar', body: 'All upcoming court dates, filing deadlines, and statutory limitation periods tracked with automated reminders calibrated to the lead time actually needed to prepare — not just a day before.'),
          const SizedBox(height: 8),
          _LegalTool(icon: Icons.gavel_rounded, color: _green, title: 'Legal Research Hub', body: 'Precedent cases, relevant statutes, and expert legal opinions stored and searchable by area of law, jurisdiction, and outcome. Build your argument on solid legal foundation.'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: _gold.withOpacity(0.07), borderRadius: BorderRadius.circular(14), border: Border.all(color: _gold.withOpacity(0.2))),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('NOTICE', style: TextStyle(color: _red, fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 2)),
              const SizedBox(height: 6),
              const Text('This intelligence module does not constitute legal advice. All information should be verified with qualified legal counsel before any legal proceeding.', style: TextStyle(color: Colors.white38, fontSize: 10, height: 1.5)),
            ]),
          ),
        ],
      ),
    );
  }
}

class _Case {
  final String id, title, status, court, filed, nextDate; final Color statusColor;
  const _Case({required this.id, required this.title, required this.status, required this.statusColor, required this.court, required this.filed, required this.nextDate});
}

class _CaseCard extends StatelessWidget {
  final _Case cas;
  const _CaseCard({required this.cas});
  static const _gold = Color(0xFFD4A853);
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: cas.statusColor.withOpacity(0.06), borderRadius: BorderRadius.circular(12), border: Border.all(color: cas.statusColor.withOpacity(0.2))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Text(cas.id, style: TextStyle(color: _gold.withOpacity(0.6), fontSize: 9, fontFamily: 'monospace', fontWeight: FontWeight.w700, letterSpacing: 1)),
        const Spacer(),
        Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: cas.statusColor.withOpacity(0.12), borderRadius: BorderRadius.circular(5)), child: Text(cas.status.toUpperCase(), style: TextStyle(color: cas.statusColor, fontSize: 8, fontWeight: FontWeight.w900, letterSpacing: 1))),
      ]),
      const SizedBox(height: 6),
      Text(cas.title, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700)),
      const SizedBox(height: 8),
      Container(height: 1, color: Colors.white.withOpacity(0.06)),
      const SizedBox(height: 8),
      Row(children: [
        _Detail('Court', cas.court),
        _Detail('Filed', cas.filed),
        _Detail('Next Date', cas.nextDate),
      ]),
    ]),
  );
}

class _Detail extends StatelessWidget {
  final String label, value;
  const _Detail(this.label, this.value);
  @override
  Widget build(BuildContext context) => Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(label, style: const TextStyle(color: Colors.white30, fontSize: 8, fontWeight: FontWeight.w700, letterSpacing: 1)),
    const SizedBox(height: 2),
    Text(value, style: const TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.w600)),
  ]));
}

class _Metric extends StatelessWidget {
  final String value, label; final Color color;
  const _Metric(this.value, this.label, this.color);
  @override
  Widget build(BuildContext context) => Column(children: [
    Text(value, style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.w900)),
    Text(label, style: const TextStyle(color: Colors.white38, fontSize: 9)),
  ]);
}

class _LegalTool extends StatelessWidget {
  final IconData icon; final Color color; final String title, body;
  const _LegalTool({required this.icon, required this.color, required this.title, required this.body});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(13), decoration: BoxDecoration(color: color.withOpacity(0.06), borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withOpacity(0.18))),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: color.withOpacity(0.14), borderRadius: BorderRadius.circular(8)), child: Icon(icon, color: color, size: 15)),
      const SizedBox(width: 10),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w800)),
        const SizedBox(height: 4),
        Text(body, style: const TextStyle(color: Colors.white54, fontSize: 11, height: 1.4)),
      ])),
    ]),
  );
}
