import 'package:flutter/material.dart';

/// DESIGN: Status Alert Dashboard — traffic-light system with live status indicators
class SafetyBestView extends StatelessWidget {
  const SafetyBestView({super.key});

  static const _green = Color(0xFF10B981);
  static const _amber = Color(0xFFF59E0B);
  static const _red = Color(0xFFEF4444);
  static const _blue = Color(0xFF2563EB);
  static const _sky = Color(0xFF0EA5E9);
  static const _violet = Color(0xFF7C3AED);
  static const _bg = Color(0xFF020810);

  @override
  Widget build(BuildContext context) {
    final zones = [
      _Zone(name: 'Physical Safety', level: 'SECURE', color: _green, risk: 0.08, icon: Icons.shield_rounded, details: 'All physical access controls nominal. CCTV coverage: 98%. Incident rate: 0 in 30 days.'),
      _Zone(name: 'Cyber Security', level: 'ELEVATED', color: _amber, risk: 0.42, icon: Icons.security_rounded, details: 'Phishing attempt detected 3 days ago — contained. Password audit: 2 weak credentials flagged. Patch status: 94%.'),
      _Zone(name: 'Environmental', level: 'SECURE', color: _green, risk: 0.12, icon: Icons.eco_rounded, details: 'Air quality: Good. Emergency exits: Clear. Fire suppression: Tested 8 days ago. Structural: No concerns.'),
      _Zone(name: 'Legal Compliance', level: 'REVIEW', color: _amber, risk: 0.38, icon: Icons.gavel_rounded, details: 'Data privacy policy: Update due in 14 days. Labour compliance: Current. Tax filing: Due in 22 days.'),
      _Zone(name: 'Health & Wellbeing', level: 'SECURE', color: _green, risk: 0.15, icon: Icons.medical_services_rounded, details: 'Team wellbeing score: 7.8/10. Sick day rate: Normal. Mental health resources: Fully available.'),
      _Zone(name: 'Financial Risk', level: 'HIGH RISK', color: _red, risk: 0.72, icon: Icons.account_balance_rounded, details: 'Cash runway: 4.2 months. 2 major receivables overdue. Reserve fund: Below 3-month threshold. Action required.'),
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: const Text('SAFETY CONTROL', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 14, color: Colors.white)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 14), child: Icon(Icons.security_rounded, color: _green, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        children: [
          // SYSTEM STATUS HEADER
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: _amber.withOpacity(0.08), borderRadius: BorderRadius.circular(16), border: Border.all(color: _amber.withOpacity(0.25))),
            child: Row(children: [
              Container(width: 10, height: 10, decoration: const BoxDecoration(color: _amber, shape: BoxShape.circle)),
              const SizedBox(width: 10),
              const Expanded(child: Text('SYSTEM STATUS: ELEVATED ALERT — 2 zones require attention', style: TextStyle(color: Color(0xFFF59E0B), fontSize: 12, fontWeight: FontWeight.w700))),
              const Text('Live', style: TextStyle(color: Colors.white38, fontSize: 10)),
            ]),
          ),
          const SizedBox(height: 16),
          // OVERALL METRICS
          Row(children: [
            _MetricBlock('4/6', 'Zones Secure', _green),
            const SizedBox(width: 10),
            _MetricBlock('2', 'Need Attention', _amber),
            const SizedBox(width: 10),
            _MetricBlock('1', 'High Risk', _red),
            const SizedBox(width: 10),
            _MetricBlock('96%', 'Overall Score', _sky),
          ]),
          const SizedBox(height: 20),
          Row(children: [Container(width: 3, height: 14, color: _blue), const SizedBox(width: 8), Text('ZONE STATUS OVERVIEW', style: TextStyle(color: Colors.white60, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2))]),
          const SizedBox(height: 12),
          // ZONE CARDS
          ...zones.map((z) => _ZoneCard(zone: z)),
          const SizedBox(height: 20),
          Row(children: [Container(width: 3, height: 14, color: _violet), const SizedBox(width: 8), Text('SAFETY PROTOCOLS', style: TextStyle(color: Colors.white60, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2))]),
          const SizedBox(height: 12),
          _ProtocolCard(color: _sky, icon: Icons.notifications_active_rounded, title: 'Early Warning System', body: 'Monitors 47 leading indicators across all safety zones. Alerts are triggered before threshold breaches, giving 24–72 hours of response time for most risk types. Configured to escalate automatically if no acknowledgment is received within 2 hours.'),
          const SizedBox(height: 8),
          _ProtocolCard(color: _green, icon: Icons.assignment_turned_in_rounded, title: 'Safety Audit Schedule', body: 'Quarterly comprehensive audits across all six safety zones. Monthly spot checks on the two highest-risk zones. All findings are logged with corrective action plans, owners, and completion deadlines tracked to closure.'),
          const SizedBox(height: 8),
          _ProtocolCard(color: _amber, icon: Icons.emergency_rounded, title: 'Incident Response Protocol', body: 'Tiered response protocol with pre-assigned incident commanders for each zone. Response playbooks are stored offline and rehearsed semi-annually. Post-incident reviews are mandatory within 72 hours of containment.'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [_green.withOpacity(0.08), _blue.withOpacity(0.05)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: _green.withOpacity(0.18))),
            child: Row(children: [
              Icon(Icons.format_quote_rounded, color: _amber, size: 26), const SizedBox(width: 12),
              const Expanded(child: Text('"Safety is not a gadget but a state of mind." — Eleanor Everet', style: TextStyle(color: Colors.white, fontSize: 13, height: 1.4, fontStyle: FontStyle.italic))),
            ]),
          ),
        ],
      ),
    );
  }
}

class _Zone {
  final String name, level, details; final Color color; final double risk; final IconData icon;
  const _Zone({required this.name, required this.level, required this.color, required this.risk, required this.icon, required this.details});
}

class _ZoneCard extends StatelessWidget {
  final _Zone zone;
  const _ZoneCard({required this.zone});
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: zone.color.withOpacity(0.07), borderRadius: BorderRadius.circular(14), border: Border.all(color: zone.color.withOpacity(0.22))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: zone.color.withOpacity(0.14), borderRadius: BorderRadius.circular(8)), child: Icon(zone.icon, color: zone.color, size: 16)),
        const SizedBox(width: 10),
        Expanded(child: Text(zone.name, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700))),
        Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: zone.color.withOpacity(0.14), borderRadius: BorderRadius.circular(6)), child: Text(zone.level, style: TextStyle(color: zone.color, fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 1))),
      ]),
      const SizedBox(height: 10),
      Stack(children: [
        Container(height: 4, decoration: BoxDecoration(color: Colors.white.withOpacity(0.07), borderRadius: BorderRadius.circular(2))),
        FractionallySizedBox(widthFactor: zone.risk, child: Container(height: 4, decoration: BoxDecoration(color: zone.color, borderRadius: BorderRadius.circular(2)))),
      ]),
      const SizedBox(height: 8),
      Text(zone.details, style: const TextStyle(color: Colors.white54, fontSize: 11, height: 1.4)),
    ]),
  );
}

class _MetricBlock extends StatelessWidget {
  final String value, label; final Color color;
  const _MetricBlock(this.value, this.label, this.color);
  @override
  Widget build(BuildContext context) => Expanded(child: Container(
    padding: const EdgeInsets.symmetric(vertical: 10), decoration: BoxDecoration(color: color.withOpacity(0.07), borderRadius: BorderRadius.circular(10), border: Border.all(color: color.withOpacity(0.18))),
    child: Column(children: [
      Text(value, style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w900)),
      Text(label, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white38, fontSize: 8, height: 1.2)),
    ]),
  ));
}

class _ProtocolCard extends StatelessWidget {
  final Color color; final IconData icon; final String title, body;
  const _ProtocolCard({required this.color, required this.icon, required this.title, required this.body});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: color.withOpacity(0.07), borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withOpacity(0.18))),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(padding: const EdgeInsets.all(7), decoration: BoxDecoration(color: color.withOpacity(0.14), borderRadius: BorderRadius.circular(8)), child: Icon(icon, color: color, size: 16)),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.w700)),
        const SizedBox(height: 5),
        Text(body, style: const TextStyle(color: Colors.white54, fontSize: 11, height: 1.45)),
      ])),
    ]),
  );
}
