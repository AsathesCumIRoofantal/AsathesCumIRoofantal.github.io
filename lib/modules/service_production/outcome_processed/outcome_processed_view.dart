import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'outcome_processed_controller.dart';

class OutcomeProcessedView extends GetView<OutcomeProcessedController> {
  final bool isEmbedded;
  const OutcomeProcessedView({super.key, this.isEmbedded = false});

  static const _emerald = Color(0xFF059669);
  static const _mint = Color(0xFF10B981);
  static const _sage = Color(0xFF34D399);
  static const _teal = Color(0xFF0D9488);
  static const _amber = Color(0xFFF59E0B);
  static const _red = Color(0xFFEF4444);
  static const _blue = Color(0xFF3B82F6);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF020F08) : const Color(0xFFF0FDF4);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: theme.colorScheme.onSurface,
        title: const Text(
          'OUTCOME PROCESSED',
          style: TextStyle(
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _emerald.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.circle, size: 6, color: _sage),
                  SizedBox(width: 4),
                  Text(
                    'LIVE',
                    style: TextStyle(
                      fontSize: 9,
                      color: _sage,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        shrinkWrap: isEmbedded,
        physics: isEmbedded ? const NeverScrollableScrollPhysics() : null,
        children: [
          _buildSummaryDashboard(context, isDark),
          const SizedBox(height: 20),
          _buildQualityGates(context, isDark),
          const SizedBox(height: 24),
          _buildSectionLabel(
            'ARTEFACT LIBRARY',
            Icons.folder_special_rounded,
            _emerald,
            context,
          ),
          const SizedBox(height: 12),
          ..._artefacts.map((a) => _buildArtefactCard(context, isDark, a)),
          const SizedBox(height: 24),
          _buildSectionLabel(
            'DELIVERY STATUS',
            Icons.mark_email_read_rounded,
            _teal,
            context,
          ),
          const SizedBox(height: 12),
          _buildDeliveryList(context, isDark),
          const SizedBox(height: 24),
          _buildSectionLabel(
            'OUTCOME ANALYTICS',
            Icons.bar_chart_rounded,
            _blue,
            context,
          ),
          const SizedBox(height: 12),
          _buildAnalyticsPanel(context, isDark),
          const SizedBox(height: 24),
          _buildSectionLabel(
            'EXPORT CENTRE',
            Icons.download_for_offline_rounded,
            _amber,
            context,
          ),
          const SizedBox(height: 12),
          _buildExportOptions(context, isDark),
          const SizedBox(height: 20),
          _buildInfoBanner(context, isDark),
        ],
      ),
    );
  }

  Widget _buildSummaryDashboard(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF003822), const Color(0xFF001A0E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _emerald.withValues(alpha: 0.35)),
        boxShadow: [
          BoxShadow(
            color: _emerald.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.task_alt_rounded, color: _sage, size: 16),
              const SizedBox(width: 8),
              const Text(
                'PROCESSING OVERVIEW',
                style: TextStyle(
                  fontSize: 10,
                  color: _sage,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const Spacer(),
              const Text(
                '30-day window',
                style: TextStyle(fontSize: 9, color: Colors.white38),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDashStat('2,847', 'Total Processed', _emerald),
              _buildDashDivider(),
              _buildDashStat('98.3%', 'Quality Pass Rate', _sage),
              _buildDashDivider(),
              _buildDashStat('1.4h', 'Avg Turn-around', _teal),
              _buildDashDivider(),
              _buildDashStat('12', 'Pending Review', _amber),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'THROUGHPUT (LAST 7 DAYS)',
            style: TextStyle(
              fontSize: 8,
              color: Colors.white38,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildBar(0.55, 'M', _emerald),
              _buildBar(0.72, 'T', _emerald),
              _buildBar(0.90, 'W', _mint),
              _buildBar(0.65, 'T', _emerald),
              _buildBar(0.80, 'F', _mint),
              _buildBar(0.45, 'S', _emerald),
              _buildBar(0.30, 'S', _teal),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDashStat(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: color,
            height: 1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 9,
            color: Colors.white54,
            height: 1.3,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildDashDivider() => Container(
    height: 40,
    width: 1,
    color: Colors.white.withValues(alpha: 0.08),
  );

  Widget _buildBar(double fraction, String day, Color color) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FractionallySizedBox(
                  heightFactor: fraction,
                  child: Container(
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.65),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(3),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              day,
              style: const TextStyle(fontSize: 8, color: Colors.white38),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQualityGates(BuildContext context, bool isDark) {
    final gates = [
      ('Completeness Check', 0.99, _emerald, '99%'),
      ('Timestamp Integrity', 1.0, _sage, '100%'),
      ('Tamper-Evidence Seal', 0.98, _mint, '98%'),
      ('Format Compliance', 0.96, _teal, '96%'),
    ];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.04)
            : Colors.black.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _emerald.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.verified_rounded, color: _emerald, size: 14),
              SizedBox(width: 6),
              Text(
                'QUALITY GATE RESULTS',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: _emerald,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...gates.map(
            (g) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        g.$1,
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        g.$4,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: g.$3,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  LinearProgressIndicator(
                    value: g.$2,
                    backgroundColor: Colors.white.withValues(alpha: 0.08),
                    valueColor: AlwaysStoppedAnimation(g.$3),
                    borderRadius: BorderRadius.circular(3),
                    minHeight: 5,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(
    String title,
    IconData icon,
    Color color,
    BuildContext context,
  ) {
    return Row(
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
  }

  Widget _buildArtefactCard(BuildContext context, bool isDark, _Artefact a) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: a.color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: a.color.withValues(alpha: 0.20)),
      ),
      child: Row(
        children: [
          Icon(a.icon, color: a.color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  a.name,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Text(
                  a.description,
                  style: TextStyle(
                    fontSize: 11,
                    height: 1.3,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.60),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _emerald.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  a.format,
                  style: const TextStyle(
                    fontSize: 9,
                    color: _emerald,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                a.count,
                style: TextStyle(
                  fontSize: 10,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.45),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryList(BuildContext context, bool isDark) {
    final deliveries = [
      (
        'Final Report Q1-2025',
        'Confirmed',
        _emerald,
        Icons.check_circle_rounded,
      ),
      (
        'Entity Atlas Export',
        'Confirmed',
        _emerald,
        Icons.check_circle_rounded,
      ),
      (
        'Knowledge Batch 24-C',
        'Pending Acknowledgment',
        _amber,
        Icons.schedule_rounded,
      ),
      (
        'Identity Audit Output',
        'Under Review',
        _teal,
        Icons.rate_review_rounded,
      ),
      (
        'Community Metrics Report',
        'Flagged for Re-Review',
        _red,
        Icons.flag_rounded,
      ),
    ];
    return Column(
      children: deliveries
          .map(
            (d) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.03)
                    : Colors.black.withValues(alpha: 0.02),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: d.$3.withValues(alpha: 0.18)),
              ),
              child: Row(
                children: [
                  Icon(d.$4, color: d.$3, size: 16),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      d.$1,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                  Text(
                    d.$2,
                    style: TextStyle(
                      fontSize: 10,
                      color: d.$3,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildAnalyticsPanel(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _blue.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _blue.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildAnalyticPill('Total Volume', '2,847', _blue),
              _buildAnalyticPill('Avg Turnaround', '1.4h', _teal),
              _buildAnalyticPill('Pass Rate', '98.3%', _emerald),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'Trend charts reveal whether output quality is improving or degrading across '
            'successive processing cycles. The 30-day rolling pass rate has improved from '
            '96.1% to 98.3% — a 2.2% uplift driven primarily by the new completeness '
            'validation layer introduced in February 2025.',
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
    );
  }

  Widget _buildAnalyticPill(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 9,
            color: color.withValues(alpha: 0.75),
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildExportOptions(BuildContext context, bool isDark) {
    final formats = [
      (Icons.picture_as_pdf_rounded, 'PDF', _red),
      (Icons.table_chart_rounded, 'CSV', _emerald),
      (Icons.data_object_rounded, 'JSON', _blue),
      (Icons.code_rounded, 'XML', _amber),
    ];
    return Row(
      children: formats
          .map(
            (f) => Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: f.$3.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: f.$3.withValues(alpha: 0.22)),
                ),
                child: Column(
                  children: [
                    Icon(f.$1, color: f.$3, size: 22),
                    const SizedBox(height: 6),
                    Text(
                      f.$2,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: f.$3,
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

  Widget _buildInfoBanner(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _emerald.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _emerald.withValues(alpha: 0.18)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline_rounded, color: _emerald, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Every outcome is signed, timestamped, and stored so stakeholders can retrieve '
              'proof of completion at any time. Items below threshold are flagged for human review '
              'rather than silently passed downstream.',
              style: TextStyle(
                fontSize: 11,
                height: 1.4,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.70),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Artefact {
  final String name, description, format, count;
  final IconData icon;
  final Color color;
  const _Artefact(
    this.name,
    this.description,
    this.format,
    this.count,
    this.icon,
    this.color,
  );
}

final _artefacts = [
  _Artefact(
    'Reports Archive',
    'Processed analytical and performance reports, signed and timestamped.',
    'PDF · CSV',
    '1,240 items',
    Icons.description_rounded,
    Color(0xFF059669),
  ),
  _Artefact(
    'Dataset Outputs',
    'Structured data exports from processing cycles with full lineage.',
    'CSV · JSON',
    '486 items',
    Icons.storage_rounded,
    Color(0xFF0D9488),
  ),
  _Artefact(
    'Certificates',
    'Completion and achievement certificates issued across all modules.',
    'PDF',
    '312 items',
    Icons.workspace_premium_rounded,
    Color(0xFFF59E0B),
  ),
  _Artefact(
    'Knowledge Documents',
    'Processed and peer-verified knowledge submissions.',
    'JSON · XML',
    '809 items',
    Icons.article_rounded,
    Color(0xFF3B82F6),
  ),
];
