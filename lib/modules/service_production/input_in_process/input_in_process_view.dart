import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'input_in_process_controller.dart';

class InputInProcessView extends GetView<InputInProcessController> {
  const InputInProcessView({Key? key}) : super(key: key);

  static const _electric = Color(0xFF2563EB);
  static const _sky = Color(0xFF0EA5E9);
  static const _cyan = Color(0xFF06B6D4);
  static const _teal = Color(0xFF0D9488);
  static const _green = Color(0xFF10B981);
  static const _amber = Color(0xFFF59E0B);
  static const _red = Color(0xFFEF4444);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;
    final bg = isDark ? const Color(0xFF010810) : const Color(0xFFEFF6FF);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: onSurface,
        title: const Text('INPUT IN PROCESS', style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold, fontSize: 13)),
        centerTitle: true,
        actions: [Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Icon(Icons.input_rounded, color: _electric, size: 22),
        )],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          _buildHeroHeader(context, isDark, onSurface),
          const SizedBox(height: 20),
          _buildFunnelVisualizer(context, isDark, onSurface),
          const SizedBox(height: 24),
          _buildSectionLabel('SOURCE REGISTRY', Icons.device_hub_rounded, _electric, onSurface),
          const SizedBox(height: 12),
          ..._sources.map((s) => _buildSourceRow(context, isDark, onSurface, s)),
          const SizedBox(height: 24),
          _buildSectionLabel('INPUT CAPABILITIES', Icons.settings_input_component_rounded, _cyan, onSurface),
          const SizedBox(height: 12),
          _buildCapCard(context, isDark, Icons.rule_rounded, _electric, 'Pre-Processing Validation',
              'Run schema checks, range guards, and duplicate filters on raw inputs before they advance to the process stage. '
              'Rejected records are quarantined with a clear reason code so they can be corrected and resubmitted without being lost. '
              'Validation rules are configurable per source, allowing different tolerance thresholds for high-trust versus low-trust input streams.'),
          const SizedBox(height: 10),
          _buildCapCard(context, isDark, Icons.queue_rounded, _sky, 'Ingestion Queue Monitor',
              'View the live queue of items waiting to enter the pipeline, including volume, lag, and priority tier. '
              'Alerts fire automatically when queue depth exceeds the configured threshold for any source. '
              'Priority override lets authorised operators fast-track items without disrupting the overall queue order or triggering SLA anomalies.'),
          const SizedBox(height: 10),
          _buildCapCard(context, isDark, Icons.label_important_outline_rounded, _cyan, 'Input Classification',
              'Assign each incoming item a category, urgency level, and routing tag as it arrives. '
              'Classification rules can be automated via keyword matching or manually overridden by authorised operators. '
              'Machine-learning-assisted classification improves accuracy over time by learning from operator correction patterns.'),
          const SizedBox(height: 10),
          _buildCapCard(context, isDark, Icons.speed_rounded, _teal, 'Load & Throughput Metrics',
              'Monitor real-time ingestion rates, peak-load windows, and error percentages across all active streams. '
              'Historical trend charts help capacity planners anticipate surges before they cause bottlenecks. '
              'Automated capacity scaling recommendations are generated when throughput trends suggest that current resources will be insufficient within 48 hours.'),
          const SizedBox(height: 10),
          _buildCapCard(context, isDark, Icons.history_edu_rounded, _green, 'Intake Audit Log',
              'Every input event is stamped with timestamp, source identity, and operator action for full traceability. '
              'The audit log is immutable and exportable for compliance reviews or incident investigations. '
              'Log entries include the full record payload at the time of ingestion, enabling precise reconstruction of any input event regardless of downstream transformations.'),
          const SizedBox(height: 10),
          _buildCapCard(context, isDark, Icons.add_to_photos_outlined, _amber, 'Initialise New Input Stream',
              'Register a brand-new data source by defining its schema, delivery method, and SLA expectations. '
              'Once registered, the stream is live-monitored and included in all downstream pipeline reports. '
              'New stream onboarding includes a test-run phase during which data is ingested but not processed, allowing validation of schema compliance before going live.'),
          const SizedBox(height: 20),
          _buildStatusBanner(context, isDark, onSurface),
        ],
      ),
    );
  }

  Widget _buildHeroHeader(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF001A4D), const Color(0xFF000D26)],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: _electric.withOpacity(0.40)),
        boxShadow: [BoxShadow(color: _electric.withOpacity(0.15), blurRadius: 18, offset: const Offset(0, 6))],
      ),
      child: Column(children: [
        Row(children: [
          Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(
            color: _electric.withOpacity(0.15), borderRadius: BorderRadius.circular(14)),
            child: const Icon(Icons.input_rounded, color: _sky, size: 28)),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('INTAKE PIPELINE', style: TextStyle(fontSize: 10, color: _sky, fontWeight: FontWeight.bold, letterSpacing: 2)),
            const SizedBox(height: 4),
            const Text('Track and validate everything that enters the AIR pipeline before any transformation begins — capturing inputs accurately at the source prevents errors compounding downstream.',
                style: TextStyle(fontSize: 12, height: 1.4, color: Colors.white60)),
          ])),
        ]),
        const SizedBox(height: 16),
        Row(children: [
          _buildStat('6', 'Live Sources', _sky),
          const SizedBox(width: 16),
          _buildStat('1,240', 'Items Today', _cyan),
          const SizedBox(width: 16),
          _buildStat('99.1%', 'Valid Rate', _green),
          const SizedBox(width: 16),
          _buildStat('11', 'Quarantined', _amber),
        ]),
      ]),
    );
  }

  Widget _buildStat(String v, String l, Color c) => Expanded(child: Column(children: [
    Text(v, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: c)),
    Text(l, textAlign: TextAlign.center, style: TextStyle(fontSize: 8, color: c.withOpacity(0.8), height: 1.2, letterSpacing: 0.3)),
  ]));

  Widget _buildFunnelVisualizer(BuildContext context, bool isDark, Color onSurface) {
    final stages = [
      ('RAW INTAKE', '1,240', 1.0, _sky),
      ('VALIDATED', '1,189', 0.96, _cyan),
      ('CLASSIFIED', '1,171', 0.945, _teal),
      ('QUEUED FOR PROCESS', '1,145', 0.924, _green),
    ];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.04) : Colors.black.withOpacity(0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _electric.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const Icon(Icons.filter_alt_rounded, color: _cyan, size: 14),
            const SizedBox(width: 6),
            const Text('TODAY\'S INTAKE FUNNEL', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 2, color: _cyan)),
          ]),
          const SizedBox(height: 14),
          ...stages.map((s) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(s.$1, style: TextStyle(fontSize: 9, letterSpacing: 1, color: s.$4, fontWeight: FontWeight.w600)),
                Text(s.$2, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: s.$4)),
              ]),
              const SizedBox(height: 4),
              Stack(children: [
                Container(height: 6, decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.07), borderRadius: BorderRadius.circular(3))),
                FractionallySizedBox(widthFactor: s.$3, child: Container(height: 6, decoration: BoxDecoration(
                  color: s.$4.withOpacity(0.80), borderRadius: BorderRadius.circular(3),
                  boxShadow: [BoxShadow(color: s.$4.withOpacity(0.3), blurRadius: 4)],
                ))),
              ]),
            ]),
          )),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String title, IconData icon, Color color, Color onSurface) => Row(children: [
    Icon(icon, color: color, size: 16), const SizedBox(width: 8),
    Text(title, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 2, color: color)),
  ]);

  Widget _buildSourceRow(BuildContext context, bool isDark, Color onSurface, _Source s) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      decoration: BoxDecoration(
        color: s.color.withOpacity(0.06), borderRadius: BorderRadius.circular(12),
        border: Border.all(color: s.color.withOpacity(0.18)),
      ),
      child: Row(children: [
        Icon(s.icon, color: s.color, size: 18),
        const SizedBox(width: 10),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(s.name, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: onSurface)),
          Text('${s.format} · ${s.freq}', style: TextStyle(fontSize: 10, color: onSurface.withOpacity(0.55))),
        ])),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(color: _green.withOpacity(0.12), borderRadius: BorderRadius.circular(6)),
          child: Text('LIVE', style: const TextStyle(fontSize: 8, color: _green, fontWeight: FontWeight.bold, letterSpacing: 1)),
        ),
      ]),
    );
  }

  Widget _buildCapCard(BuildContext context, bool isDark, IconData icon, Color color, String title, String body) {
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
          Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface)),
          const SizedBox(height: 6),
          Text(body, style: TextStyle(fontSize: 12, height: 1.5,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.72))),
        ])),
      ]),
    );
  }

  Widget _buildStatusBanner(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [_electric.withOpacity(0.10), _cyan.withOpacity(0.07)],
            begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _electric.withOpacity(0.20)),
      ),
      child: Row(children: [
        const Icon(Icons.verified_rounded, color: _green, size: 18),
        const SizedBox(width: 10),
        Expanded(child: Text(
          'All 6 input streams are live and healthy. 99.1% of today\'s intake has passed validation. 11 items are quarantined pending manual review.',
          style: TextStyle(fontSize: 11, height: 1.4, color: onSurface.withOpacity(0.72)),
        )),
      ]),
    );
  }
}

class _Source {
  final String name, format, freq;
  final IconData icon;
  final Color color;
  const _Source(this.name, this.format, this.freq, this.icon, this.color);
}

final _sources = [
  _Source('Manual Entry Portal', 'Structured Form', 'On-demand', Icons.edit_rounded, Color(0xFF2563EB)),
  _Source('API Feed v2', 'JSON / REST', 'Every 5 min', Icons.code_rounded, Color(0xFF0EA5E9)),
  _Source('File Upload Channel', 'CSV / XLSX', 'Batch daily', Icons.upload_file_rounded, Color(0xFF0D9488)),
  _Source('Community Submissions', 'Multi-format', 'Continuous', Icons.group_add_rounded, Color(0xFF7C3AED)),
  _Source('R&D Data Export', 'JSON / XML', 'Weekly', Icons.science_rounded, Color(0xFF06B6D4)),
  _Source('Partner Integration', 'JSON / REST', 'Hourly', Icons.handshake_rounded, Color(0xFF10B981)),
];
