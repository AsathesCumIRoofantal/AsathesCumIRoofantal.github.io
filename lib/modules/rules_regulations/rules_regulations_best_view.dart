import 'package:flutter/material.dart';

/// DESIGN: Regulatory Codex — structured law-book styling with hierarchy navigation
class RulesRegulationsBestView extends StatelessWidget {
  const RulesRegulationsBestView({super.key});

  static const _navy = Color(0xFF1E3A5F);
  static const _blue = Color(0xFF1D4ED8);
  static const _sky = Color(0xFF0EA5E9);
  static const _gold = Color(0xFFD4A853);
  static const _green = Color(0xFF10B981);
  static const _amber = Color(0xFFF59E0B);
  static const _red = Color(0xFFDC2626);
  static const _bg = Color(0xFF020610);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: const Text('RULES & REGULATIONS', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1, fontSize: 12, color: Colors.white)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 14), child: Icon(Icons.gavel_rounded, color: _gold, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        children: [
          Container(
            padding: const EdgeInsets.all(18), decoration: BoxDecoration(
              gradient: LinearGradient(colors: [const Color(0xFF0A1228), const Color(0xFF050A14)]),
              borderRadius: BorderRadius.circular(20), border: Border.all(color: _gold.withOpacity(0.28)),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Icon(Icons.gavel_rounded, color: _gold, size: 26),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('REGULATORY INTELLIGENCE', style: TextStyle(color: _gold, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 2)),
                  const SizedBox(height: 4),
                  const Text('Know the rules that govern your domain. Compliance protects; knowledge empowers.', style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.3)),
                ])),
              ]),
              const SizedBox(height: 14),
              Row(children: [_Badge('34', 'Active Rules', _blue), const SizedBox(width: 8), _Badge('3', 'Expiring Soon', _amber), const SizedBox(width: 8), _Badge('100%', 'Compliance', _green)]),
            ]),
          ),
          const SizedBox(height: 20),
          _SecHead('THE REGULATORY HIERARCHY', _blue),
          const SizedBox(height: 12),
          _CodexEntry(article: 'Art. I', level: 'Constitutional', color: _gold, icon: Icons.account_balance_rounded, title: 'Foundational Principles',
              body: 'All rules and regulations derive their authority from foundational constitutional principles. Understanding the source of regulatory authority — and its limits — is the starting point of sophisticated legal and regulatory intelligence.'),
          _CodexEntry(article: 'Art. II', level: 'Statutory', color: _blue, icon: Icons.library_books_rounded, title: 'Legislative Framework',
              body: 'Laws passed by legislative bodies establish the primary regulatory framework. Statutory interpretation — understanding what the legislature intended — is the foundation of compliance. AIR tracks all relevant statutes with plain-language summaries and compliance checklists.'),
          _CodexEntry(article: 'Art. III', level: 'Regulatory', color: _sky, icon: Icons.corporate_fare_rounded, title: 'Executive Rules',
              body: 'Regulatory agencies translate broad statutory mandates into specific operational rules. These regulations have the force of law and are often where the practical compliance burden lives. Regulatory changes are tracked in real time in AIR\'s compliance monitor.'),
          _CodexEntry(article: 'Art. IV', level: 'Contractual', color: _green, icon: Icons.handshake_rounded, title: 'Private Agreements',
              body: 'Contracts create binding rules between private parties. Within their scope, contractual obligations have regulatory force equal to statute. AIR\'s contract tracker ensures all contractual obligations are visible, dated, and monitored for compliance.'),
          _CodexEntry(article: 'Art. V', level: 'Internal', color: _amber, icon: Icons.business_rounded, title: 'Organisational Policy',
              body: 'Internal policies, procedures, and standards form the operational layer of rules that govern daily conduct. They should be consistent with external requirements but can and should be more specific. Policy gaps are flagged by AIR\'s internal audit module.'),
          const SizedBox(height: 20),
          _SecHead('COMPLIANCE TOOLS', _green),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: _CompTool(color: _green, icon: Icons.checklist_rounded, title: 'Compliance Checker', body: 'Automated audit of your activities against applicable regulatory requirements.')),
            const SizedBox(width: 10),
            Expanded(child: _CompTool(color: _red, icon: Icons.warning_rounded, title: 'Risk Alerts', body: 'Real-time alerts when regulatory changes create new compliance obligations.')),
          ]),
          const SizedBox(height: 10),
          Row(children: [
            Expanded(child: _CompTool(color: _blue, icon: Icons.timeline_rounded, title: 'Regulatory Calendar', body: 'Filing deadlines, renewal dates, and reporting windows tracked with lead-time alerts.')),
            const SizedBox(width: 10),
            Expanded(child: _CompTool(color: _amber, icon: Icons.school_rounded, title: 'Compliance Training', body: 'Structured training modules for all regulatory areas relevant to your activities.')),
          ]),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [_blue.withOpacity(0.08), _gold.withOpacity(0.05)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: _blue.withOpacity(0.18))),
            child: Row(children: [
              Icon(Icons.format_quote_rounded, color: _amber, size: 26), const SizedBox(width: 12),
              const Expanded(child: Text('"Rules are for the guidance of wise men and the obedience of fools." — Harry Day', style: TextStyle(color: Colors.white, fontSize: 13, height: 1.4, fontStyle: FontStyle.italic))),
            ]),
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String value, label; final Color color;
  const _Badge(this.value, this.label, this.color);
  @override
  Widget build(BuildContext context) => Expanded(child: Container(
    padding: const EdgeInsets.symmetric(vertical: 7),
    decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8), border: Border.all(color: color.withOpacity(0.2))),
    child: Column(children: [Text(value, style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.w900)), Text(label, style: const TextStyle(color: Colors.white38, fontSize: 8))]),
  ));
}

class _SecHead extends StatelessWidget {
  final String text; final Color color;
  const _SecHead(this.text, this.color);
  @override
  Widget build(BuildContext context) => Row(children: [Container(width: 3, height: 14, color: color), const SizedBox(width: 8), Text(text, style: TextStyle(color: color.withOpacity(0.85), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2))]);
}

class _CodexEntry extends StatelessWidget {
  final String article, level, title, body; final Color color; final IconData icon;
  const _CodexEntry({required this.article, required this.level, required this.color, required this.icon, required this.title, required this.body});
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: color.withOpacity(0.06), borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withOpacity(0.18))),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text(article, style: TextStyle(color: color.withOpacity(0.5), fontSize: 8, fontWeight: FontWeight.w900, letterSpacing: 1)),
        const SizedBox(height: 4),
        Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: color.withOpacity(0.14), borderRadius: BorderRadius.circular(8)), child: Icon(icon, color: color, size: 14)),
        const SizedBox(height: 4),
        Container(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(4)), child: Text(level, style: TextStyle(color: color, fontSize: 6, fontWeight: FontWeight.w900, letterSpacing: 0.5))),
      ]),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w800)),
        const SizedBox(height: 5),
        Text(body, style: const TextStyle(color: Colors.white54, fontSize: 11, height: 1.45)),
      ])),
    ]),
  );
}

class _CompTool extends StatelessWidget {
  final Color color; final IconData icon; final String title, body;
  const _CompTool({required this.color, required this.icon, required this.title, required this.body});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: color.withOpacity(0.07), borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withOpacity(0.18))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(icon, color: color, size: 18), const SizedBox(height: 6),
      Text(title, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w800)), const SizedBox(height: 4),
      Text(body, style: const TextStyle(color: Colors.white54, fontSize: 10, height: 1.4)),
    ]),
  );
}
