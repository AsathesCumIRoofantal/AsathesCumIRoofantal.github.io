import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'process_controller.dart';

class ProcessView extends GetView<ProcessController> {
  const ProcessView({super.key});

  static const _orange = Color(0xFFEA580C);
  static const _amber = Color(0xFFF59E0B);
  static const _yellow = Color(0xFFEAB308);
  static const _red = Color(0xFFEF4444);
  static const _green = Color(0xFF10B981);
  static const _blue = Color(0xFF3B82F6);
  static const _violet = Color(0xFF7C3AED);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;
    final bg = isDark ? const Color(0xFF0A0500) : const Color(0xFFFFF7ED);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: onSurface,
        title: const Text(
          'PROCESS',
          style: TextStyle(
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(
              Icons.settings_suggest_rounded,
              color: _orange,
              size: 22,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          _buildHeroHeader(context, isDark, onSurface),
          const SizedBox(height: 20),
          _buildSectionLabel(
            'PIPELINE STATUS',
            Icons.dashboard_rounded,
            _orange,
            onSurface,
          ),
          const SizedBox(height: 12),
          _buildPipelineKanban(context, isDark, onSurface),
          const SizedBox(height: 24),
          _buildSectionLabel(
            'SLA TRACKER',
            Icons.timer_rounded,
            _red,
            onSurface,
          ),
          const SizedBox(height: 12),
          _buildSLAPanel(context, isDark, onSurface),
          const SizedBox(height: 24),
          _buildSectionLabel(
            'PROCESS CAPABILITIES',
            Icons.tune_rounded,
            _amber,
            onSurface,
          ),
          const SizedBox(height: 12),
          _buildCapCard(
            context,
            isDark,
            Icons.dashboard_rounded,
            _orange,
            'Active Job Dashboard',
            'See every work item currently in flight, with real-time progress bars, assigned owners, and elapsed time. '
                'Colour-coded urgency bands make it instantly clear which jobs need attention before their SLA expires. '
                'Dashboard views can be filtered by team, priority tier, or workstream so every stakeholder sees the slice most relevant to their role.',
          ),
          const SizedBox(height: 10),
          _buildCapCard(
            context,
            isDark,
            Icons.account_tree_rounded,
            _amber,
            'Process Rules Engine',
            'Define the conditional logic that governs how items move through each stage — approvals, escalations, and auto-routing. '
                'Rules are version-controlled so changes are auditable and rollbacks are one click away. '
                'The rules engine supports complex branching logic, parallel tracks, and conditional gate-keeping without requiring technical expertise to configure.',
          ),
          const SizedBox(height: 10),
          _buildCapCard(
            context,
            isDark,
            Icons.person_pin_rounded,
            _blue,
            'Owner Assignment',
            'Allocate each in-flight item to a responsible individual or team with a clear mandate and deadline. '
                'Workload balancing suggestions surface automatically when any owner is approaching capacity. '
                'Re-assignment triggers an automated handover brief sent to the new owner, ensuring nothing is lost in the transition.',
          ),
          const SizedBox(height: 10),
          _buildCapCard(
            context,
            isDark,
            Icons.tune_rounded,
            _green,
            'Throughput Optimiser',
            'Analyse bottlenecks across the current process stage and surface recommendations to redistribute load. '
                'One-tap optimisation rebalances queues without interrupting jobs already in progress. '
                'Historical throughput data allows you to model the impact of process changes before deploying them, reducing the risk of optimisation-induced disruption.',
          ),
          const SizedBox(height: 10),
          _buildCapCard(
            context,
            isDark,
            Icons.escalator_warning_rounded,
            _red,
            'Escalation Pathways',
            'Configure multi-tier escalation chains so stalled or high-risk items automatically reach the right decision-maker. '
                'Each escalation is logged with reason, timestamp, and resolution outcome for future process improvement. '
                'Escalation frequency metrics are surfaced in the monthly process review to identify recurring failure points in the pipeline design.',
          ),
          const SizedBox(height: 10),
          _buildCapCard(
            context,
            isDark,
            Icons.speed_rounded,
            _violet,
            'Process Health Metrics',
            'Track cycle times, error rates, first-pass yield, and throughput consistency to assess the overall health of your process. '
                'Process health metrics are benchmarked against AIR community standards so you know whether your performance is ahead of or behind comparable operations. '
                'Monthly trend summaries are automatically generated and shared with process owners without requiring any manual reporting effort.',
          ),
          const SizedBox(height: 20),
          _buildTipBanner(context, isDark, onSurface),
        ],
      ),
    );
  }

  Widget _buildHeroHeader(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF3D1500), const Color(0xFF1A0A00)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _orange.withValues(alpha: 0.35)),
        boxShadow: [
          BoxShadow(
            color: _orange.withValues(alpha: 0.12),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _orange.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.settings_suggest_rounded,
                  color: _orange,
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'PROCESS CONTROL CENTRE',
                      style: TextStyle(
                        fontSize: 10,
                        color: _orange,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Govern the middle state of every AIR work item — defining rules, assigning owners, and enforcing SLAs while work is actively underway.',
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.4,
                        color: Colors.white60,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildDarkStat('47', 'Active Jobs', _orange),
              const SizedBox(width: 16),
              _buildDarkStat('94%', 'SLA Compliance', _green),
              const SizedBox(width: 16),
              _buildDarkStat('3', 'At Risk', _red),
              const SizedBox(width: 16),
              _buildDarkStat('1.3h', 'Avg Cycle', _amber),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDarkStat(String v, String l, Color c) => Expanded(
    child: Column(
      children: [
        Text(
          v,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: c),
        ),
        Text(
          l,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 8,
            color: c.withValues(alpha: 0.75),
            height: 1.2,
            letterSpacing: 0.3,
          ),
        ),
      ],
    ),
  );

  Widget _buildSectionLabel(
    String title,
    IconData icon,
    Color color,
    Color onSurface,
  ) => Row(
    children: [
      Icon(icon, color: color, size: 16),
      const SizedBox(width: 8),
      Text(
        title,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
          color: color,
        ),
      ),
    ],
  );

  Widget _buildPipelineKanban(
    BuildContext context,
    bool isDark,
    Color onSurface,
  ) {
    final stages = [
      ('Input
Queue', '12', _blue),
      ('In
Process', '47', _orange),
      ('Review', '8', _amber),
      ('Done', '182', _green),
    ];
    return Row(
      children: stages
          .map(
            (s) => Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 8,
                ),
                decoration: BoxDecoration(
                  color: s.$3.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: s.$3.withValues(alpha: 0.22)),
                ),
                child: Column(
                  children: [
                    Text(
                      s.$2,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: s.$3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      s.$1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 9,
                        color: s.$3.withValues(alpha: 0.85),
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildSLAPanel(BuildContext context, bool isDark, Color onSurface) {
    final slas = [
      ('Identity Processing', '98.6%', 0.986, _green),
      ('Knowledge Review', '95.2%', 0.952, _green),
      ('Reward Validation', '91.0%', 0.91, _amber),
      ('Escalated Cases', '78.4%', 0.784, _red),
    ];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.04)
            : Colors.black.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _red.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SLA breach prediction fires 20% before each deadline — act before a miss is recorded.',
            style: TextStyle(
              fontSize: 11,
              color: onSurface.withValues(alpha: 0.60),
              height: 1.3,
            ),
          ),
          const SizedBox(height: 12),
          ...slas.map(
            (s) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        s.$1,
                        style: TextStyle(fontSize: 12, color: onSurface),
                      ),
                      Text(
                        s.$2,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: s.$4,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Stack(
                    children: [
                      Container(
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.07),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: s.$3,
                        child: Container(
                          height: 5,
                          decoration: BoxDecoration(
                            color: s.$4,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCapCard(
    BuildContext context,
    bool isDark,
    IconData icon,
    Color color,
    String title,
    String body,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.20)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  body,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.5,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.72),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipBanner(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _orange.withValues(alpha: 0.10),
            _amber.withValues(alpha: 0.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _orange.withValues(alpha: 0.20)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline_rounded, color: _amber, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'A well-managed process stage is the difference between predictable delivery and chaotic firefighting. '
              'Keep rules updated, owners assigned, and SLA alerts active for maximum throughput.',
              style: TextStyle(
                fontSize: 11,
                height: 1.4,
                color: onSurface.withValues(alpha: 0.72),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



