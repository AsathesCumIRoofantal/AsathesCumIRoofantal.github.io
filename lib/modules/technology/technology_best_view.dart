import 'package:flutter/material.dart';

/// DESIGN: Terminal/Hacker Aesthetic — dark terminal with code-like text and glowing accents
class TechnologyBestView extends StatelessWidget {
  const TechnologyBestView({super.key});

  static const _green = Color(0xFF00FF88);
  static const _cyan = Color(0xFF00FFFF);
  static const _purple = Color(0xFFBB86FC);
  static const _yellow = Color(0xFFFFD700);
  static const _red = Color(0xFFFF4444);
  static const _bg = Color(0xFF0A0A0A);
  static const _bg2 = Color(0xFF111111);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg2,
        foregroundColor: _green,
        title: Row(mainAxisSize: MainAxisSize.min, children: [
          Container(width: 8, height: 8, decoration: const BoxDecoration(color: _red, shape: BoxShape.circle)),
          const SizedBox(width: 6),
          Container(width: 8, height: 8, decoration: const BoxDecoration(color: _yellow, shape: BoxShape.circle)),
          const SizedBox(width: 6),
          Container(width: 8, height: 8, decoration: const BoxDecoration(color: _green, shape: BoxShape.circle)),
          const SizedBox(width: 16),
          const Text('air_technology.exe', style: TextStyle(fontFamily: 'monospace', fontSize: 13, color: Colors.white70, fontWeight: FontWeight.w400)),
        ]),
        centerTitle: false,
        elevation: 0,
        bottom: PreferredSize(preferredSize: const Size.fromHeight(1), child: Container(height: 1, color: _green.withOpacity(0.2))),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // SYSTEM BOOT HEADER
          _TermBlock(children: [
            _tLine('$ air --module technology --init', _green),
            _tLine('> Scanning system capabilities...', _cyan),
            _tLine('> Module loaded: TECHNOLOGY INTELLIGENCE', _purple),
            _tLine('> Status: ACTIVE', _green),
            _tLine('> Build: 2026.05.16 | Nodes: 2,847', Colors.white54),
          ]),
          const SizedBox(height: 12),
          // FEATURE BLOCKS AS TERMINAL SECTIONS
          _TermSection(
            prompt: '~/air/tech \$', command: 'cat emerging_tech.md',
            title: '## EMERGING TECHNOLOGY TRACKER',
            color: _cyan,
            body: 'Track breakthrough technologies before they reach mainstream adoption:\n'
                '  - Artificial General Intelligence milestones\n'
                '  - Quantum computing error correction thresholds\n'
                '  - Next-gen energy storage (solid-state batteries)\n'
                '  - Neuromorphic chip deployments\n\nEach entry includes: maturity_level, time_to_market, impact_score',
          ),
          const SizedBox(height: 10),
          _TermSection(
            prompt: '~/air/tech \$', command: 'run tech_audit --scope full',
            title: '## TECHNOLOGY AUDIT',
            color: _purple,
            body: 'Auditing your current technology stack:\n'
                '  [OK]  Core infrastructure: resilient\n'
                '  [OK]  Security posture: patched\n'
                '  [!!]  Legacy dependencies: 3 flagged\n'
                '  [OK]  API integrations: functional\n\nAudit cadence: quarterly | Last run: 14 days ago',
          ),
          const SizedBox(height: 10),
          _TermSection(
            prompt: '~/air/tech \$', command: 'monitor --live disruption_signals',
            title: '## DISRUPTION SIGNALS',
            color: _green,
            body: 'Live monitoring for signals that precede major tech shifts:\n'
                '  SIGNAL_001: Patent filings in [EDGE_AI] ↑ 340%\n'
                '  SIGNAL_002: Regulatory movement in [CRYPTO] ↑ 89%\n'
                '  SIGNAL_003: VC investment in [BIOTECH] ↑ 220%\n\nAlert threshold: 100% | Notifications: enabled',
          ),
          const SizedBox(height: 10),
          _TermSection(
            prompt: '~/air/tech \$', command: 'build roadmap --horizon 5y',
            title: '## TECHNOLOGY ROADMAP',
            color: _yellow,
            body: 'Mapping your technology adoption curve:\n'
                '  NOW:    Deploy AI-assisted workflows\n'
                '  +6mo:   Integrate edge computing layer\n'
                '  +18mo:  Pilot quantum-resistant encryption\n'
                '  +3yr:   Full neuromorphic processing stack\n\nRoadmap owner: you | Review: quarterly',
          ),
          const SizedBox(height: 10),
          _TermSection(
            prompt: '~/air/tech \$', command: 'analyze --mode deep vendor_landscape',
            title: '## VENDOR INTELLIGENCE',
            color: _purple,
            body: 'Profiling technology vendors by strategic importance:\n'
                '  TIER_1: Mission-critical (high lock-in risk)\n'
                '  TIER_2: High-value (moderate substitutability)\n'
                '  TIER_3: Commodity (easily replaced)\n\nVendors tracked: 34 | At-risk: 2',
          ),
          const SizedBox(height: 10),
          // METRICS GRID
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: _bg2, borderRadius: BorderRadius.circular(12), border: Border.all(color: _green.withOpacity(0.2))),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Text('> ', style: TextStyle(color: _green, fontFamily: 'monospace', fontWeight: FontWeight.w700)),
                Text('system_metrics --output table', style: const TextStyle(color: Colors.white70, fontFamily: 'monospace', fontSize: 12)),
              ]),
              const SizedBox(height: 12),
              _MetricRow('Tech Adoption Rate', '73%', _cyan),
              _MetricRow('Security Score', '91/100', _green),
              _MetricRow('Innovation Index', '8.4/10', _purple),
              _MetricRow('Stack Modernity', '82%', _yellow),
              _MetricRow('Vendor Risk', 'LOW', _green),
            ]),
          ),
          const SizedBox(height: 12),
          _TermBlock(children: [
            _tLine('> All systems nominal.', _green),
            _tLine('> Next scheduled scan: 2026-06-16 00:00 UTC', Colors.white38),
            _tLine('\$ _', _green),
          ]),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  static Widget _tLine(String text, Color color) => Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Text(text, style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 12, height: 1.4)),
  );
}

class _TermBlock extends StatelessWidget {
  final List<Widget> children;
  const _TermBlock({required this.children});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: const Color(0xFF111111), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFF00FF88).withOpacity(0.15))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
  );
}

class _TermSection extends StatelessWidget {
  final String prompt, command, title, body;
  final Color color;
  const _TermSection({required this.prompt, required this.command, required this.title, required this.body, required this.color});
  static const _green = Color(0xFF00FF88);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: const Color(0xFF0F0F0F), borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withOpacity(0.2))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Text('$prompt ', style: TextStyle(color: _green, fontFamily: 'monospace', fontSize: 11, fontWeight: FontWeight.w700)),
        Text(command, style: const TextStyle(color: Colors.white70, fontFamily: 'monospace', fontSize: 11)),
      ]),
      const SizedBox(height: 10),
      Text(title, style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 13, fontWeight: FontWeight.w700)),
      const SizedBox(height: 8),
      Text(body, style: const TextStyle(color: Colors.white54, fontFamily: 'monospace', fontSize: 11, height: 1.6)),
    ]),
  );
}

class _MetricRow extends StatelessWidget {
  final String label, value;
  final Color color;
  const _MetricRow(this.label, this.value, this.color);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 7),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: const TextStyle(color: Colors.white54, fontFamily: 'monospace', fontSize: 11)),
      Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(4)),
        child: Text(value, style: TextStyle(color: color, fontFamily: 'monospace', fontSize: 11, fontWeight: FontWeight.w700))),
    ]),
  );
}
