import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'obligations_controller.dart';

class ObligationsView extends GetView<ObligationsController> {
  const ObligationsView({super.key});

  static const _law = Color(0xFF1E40AF);
  static const _blue = Color(0xFF3B82F6);
  static const _sky = Color(0xFF0EA5E9);
  static const _teal = Color(0xFF0D9488);
  static const _green = Color(0xFF10B981);
  static const _amber = Color(0xFFF59E0B);
  static const _red = Color(0xFFEF4444);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;
    final bg = isDark ? const Color(0xFF01030E) : const Color(0xFFEFF6FF);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: onSurface,
        title: const Text('OBLIGATIONS', style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold, fontSize: 14)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 16),
          child: Icon(Icons.gavel, color: _law, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          _buildHeroHeader(context, isDark, onSurface),
          const SizedBox(height: 20),
          _buildSectionLabel('OBLIGATION DASHBOARD', Icons.dashboard_outlined, _law, onSurface),
          const SizedBox(height: 12),
          _buildDashboard(context, isDark, onSurface),
          const SizedBox(height: 24),
          _buildSectionLabel('OBLIGATION TOOLS', Icons.build_rounded, _blue, onSurface),
          const SizedBox(height: 12),
          _buildCard(context, isDark, Icons.checklist_rtl, _law, 'Active Commitments',
              'List every obligation currently in force — contracts, promises, regulatory duties, and court orders. '
              'Each entry carries a due date, responsible party, and current status so you always know what is outstanding. '
              'Active commitments are auto-sorted by deadline proximity, with overdue items at the top in red — ensuring the most urgent obligations are never buried under lower-priority but recently-added entries.'),
          const SizedBox(height: 10),
          _buildCard(context, isDark, Icons.handshake_outlined, _sky, 'Counterparty Registry',
              'Record who holds each obligation against you and who you hold obligations against. '
              'Linking counterparties to commitments makes it easy to spot conflicts of interest or overlapping duties. '
              'The registry includes relationship-type tags (legal, personal, professional) and a history of the counterparty\'s adherence to their own obligations — building a complete picture of the relationship\'s reliability over time.'),
          const SizedBox(height: 10),
          _buildCard(context, isDark, Icons.warning_amber_rounded, _amber, 'Breach & Risk Alerts',
              'Set thresholds that trigger warnings before a deadline is missed or a condition is violated. '
              'Early alerts give you time to renegotiate, escalate, or remediate before a breach becomes costly. '
              'Alert lead times are configurable per obligation — a regulatory deadline might warrant a 30-day warning while a delivery promise needs a 48-hour alert — calibrated to the time actually needed to respond effectively.'),
          const SizedBox(height: 10),
          _buildCard(context, isDark, Icons.folder_copy_outlined, _teal, 'Compliance Evidence',
              'Attach documents, receipts, and audit trails that prove each obligation has been met. '
              'Structured evidence chains make regulatory reviews and legal disputes far less stressful. '
              'Evidence is version-controlled and timestamped — making it impossible to retroactively alter the record and ensuring that compliance documentation is as defensible as the compliance itself.'),
          const SizedBox(height: 10),
          _buildCard(context, isDark, Icons.timeline, _blue, 'Obligation Lifecycle',
              'Track how each commitment was created, amended, fulfilled, or discharged over time. '
              'A full lifecycle view prevents disputes about what was agreed and when changes were made. '
              'Lifecycle events are logged with actor, timestamp, and reason — so if a dispute arises about whether a commitment was modified or waived, the record shows exactly who said what and when.'),
          const SizedBox(height: 10),
          _buildCard(context, isDark, Icons.volunteer_activism, _green, 'Moral & Informal Duties',
              'Capture non-legal obligations — personal promises, community commitments, and ethical pledges. '
              'Treating informal duties with the same rigour as contracts builds trust and personal integrity. '
              'Informal obligations are flagged as such in the dashboard — not to make them feel less important, but to enable appropriate handling when they conflict with formal obligations that carry legal consequences.'),
          const SizedBox(height: 10),
          _buildCard(context, isDark, Icons.dashboard_outlined, _red, 'Obligation Dashboard',
              'See all commitments ranked by urgency, risk level, and counterparty importance on a single screen. '
              'The dashboard highlights overdue items in red and upcoming deadlines in amber so nothing is overlooked. '
              'Dashboard views are role-configurable — a compliance officer sees all formal obligations first; a community leader sees informal pledges prominently — so the view reflects what genuinely matters to the user\'s context.'),
          const SizedBox(height: 20),
          _buildObligationsQuote(context, isDark, onSurface),
        ],
      ),
    );
  }

  Widget _buildHeroHeader(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [const Color(0xFF020830), const Color(0xFF010418)],
            begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _law.withOpacity(0.38)),
        boxShadow: [BoxShadow(color: _blue.withOpacity(0.12), blurRadius: 18)],
      ),
      child: Column(children: [
        Row(children: [
          Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(
            color: _law.withOpacity(0.15), borderRadius: BorderRadius.circular(14)),
            child: const Icon(Icons.gavel, color: _sky, size: 28)),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('OBLIGATION REGISTRY', style: TextStyle(fontSize: 9, color: _sky, fontWeight: FontWeight.bold, letterSpacing: 2)),
            const SizedBox(height: 4),
            const Text('Track every legal, moral, and contractual commitment so nothing slips through the cracks. AIR surfaces due dates, counterparties, and breach risks in one accountable view.',
                style: TextStyle(fontSize: 12, height: 1.4, color: Colors.white60)),
          ])),
        ]),
        const SizedBox(height: 16),
        Row(children: [
          _stat('24', 'Active', _sky),
          const SizedBox(width: 16),
          _stat('3', 'Overdue', _red),
          const SizedBox(width: 16),
          _stat('7', 'Due Soon', _amber),
          const SizedBox(width: 16),
          _stat('67', 'Closed', _green),
        ]),
      ]),
    );
  }

  Widget _stat(String v, String l, Color c) => Expanded(child: Column(children: [
    Text(v, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: c)),
    Text(l, textAlign: TextAlign.center, style: TextStyle(fontSize: 8, color: c.withOpacity(0.8), height: 1.2)),
  ]));

  Widget _buildSectionLabel(String title, IconData icon, Color color, Color onSurface) => Row(children: [
    Icon(icon, color: color, size: 16), const SizedBox(width: 8),
    Text(title, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 2, color: color)),
  ]);

  Widget _buildDashboard(BuildContext context, bool isDark, Color onSurface) {
    final items = [
      ('Annual Compliance Report', 'Apr 30', _red, 'OVERDUE'),
      ('Partner NDA Renewal', 'May 22', _amber, 'DUE SOON'),
      ('Community Pledge — Q2', 'Jun 1', _sky, 'ON TRACK'),
      ('Regulatory Audit Prep', 'Jun 15', _green, 'ON TRACK'),
    ];
    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.04) : Colors.black.withOpacity(0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _law.withOpacity(0.14)),
      ),
      child: Column(children: items.asMap().entries.map((e) {
        final item = e.value;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            border: e.key < items.length - 1 ? Border(bottom: BorderSide(color: Colors.white.withOpacity(0.05))) : null,
          ),
          child: Row(children: [
            Icon(item.$4 == 'OVERDUE' ? Icons.error_rounded : item.$4 == 'DUE SOON' ? Icons.schedule_rounded : Icons.check_circle_rounded,
                color: item.$3, size: 18),
            const SizedBox(width: 10),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(item.$1, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: onSurface)),
              Text('Due: ${item.$2}', style: TextStyle(fontSize: 10, color: onSurface.withOpacity(0.55))),
            ])),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(color: item.$3.withOpacity(0.12), borderRadius: BorderRadius.circular(6)),
              child: Text(item.$4, style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: item.$3, letterSpacing: 0.8)),
            ),
          ]),
        );
      }).toList()),
    );
  }

  Widget _buildCard(BuildContext context, bool isDark, IconData icon, Color color, String title, String body) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06), borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.20)),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(
          color: color.withOpacity(0.14), borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: color, size: 18)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface)),
          const SizedBox(height: 6),
          Text(body, style: TextStyle(fontSize: 12, height: 1.5, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.72))),
        ])),
      ]),
    );
  }

  Widget _buildObligationsQuote(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [_law.withOpacity(0.10), _teal.withOpacity(0.07)],
            begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _law.withOpacity(0.20)),
      ),
      child: Row(children: [
        const Icon(Icons.format_quote_rounded, color: _amber, size: 28),
        const SizedBox(width: 12),
        Expanded(child: Text(
          '"The strength of a man\'s virtue should not be measured by his special exertions, but by his habitual acts." — Blaise Pascal',
          style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, height: 1.4, color: onSurface),
        )),
      ]),
    );
  }
}
