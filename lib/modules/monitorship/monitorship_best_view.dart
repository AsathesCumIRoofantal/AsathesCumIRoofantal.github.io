import 'package:flutter/material.dart';

/// DESIGN: Control Room — multi-panel surveillance dashboard with live metrics
class MonitorshipBestView extends StatelessWidget {
  const MonitorshipBestView({super.key});

  static const _green = Color(0xFF10B981);
  static const _amber = Color(0xFFF59E0B);
  static const _red = Color(0xFFEF4444);
  static const _blue = Color(0xFF2563EB);
  static const _sky = Color(0xFF0EA5E9);
  static const _teal = Color(0xFF0D9488);
  static const _violet = Color(0xFF7C3AED);
  static const _bg = Color(0xFF030810);

  @override
  Widget build(BuildContext context) {
    final panels = [
      _Panel(id: 'CAM-01', status: 'online', color: _green, area: 'Main Entrance', activity: 'Normal', lastEvent: '09:12 — 3 persons entered'),
      _Panel(id: 'CAM-02', status: 'online', color: _green, area: 'Operations Floor', activity: 'Normal', lastEvent: '09:14 — Routine activity'),
      _Panel(id: 'CAM-03', status: 'alert', color: _amber, area: 'Server Room', activity: 'Elevated', lastEvent: '09:08 — Temp spike: 32°C'),
      _Panel(id: 'CAM-04', status: 'online', color: _green, area: 'Perimeter East', activity: 'Normal', lastEvent: '08:50 — Scheduled patrol'),
      _Panel(id: 'CAM-05', status: 'offline', color: _red, area: 'Loading Bay', activity: 'No Signal', lastEvent: '08:22 — Signal lost'),
      _Panel(id: 'CAM-06', status: 'online', color: _green, area: 'Executive Floor', activity: 'Normal', lastEvent: '09:10 — Access card used'),
    ];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: const Color(0xFF05080E),
        foregroundColor: Colors.white,
        title: Row(mainAxisSize: MainAxisSize.min, children: [
          Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF10B981), shape: BoxShape.circle)),
          const SizedBox(width: 8),
          const Text('MONITORSHIP CONTROL', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 12, color: Colors.white)),
        ]),
        centerTitle: true,
        bottom: PreferredSize(preferredSize: const Size.fromHeight(1), child: Container(height: 1, color: _green.withOpacity(0.2))),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 10, 14, 40),
        children: [
          // SYSTEM STATUS BAR
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(color: _green.withOpacity(0.08), borderRadius: BorderRadius.circular(12), border: Border.all(color: _green.withOpacity(0.22))),
            child: Row(children: [
              Row(children: [Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF10B981), shape: BoxShape.circle)), const SizedBox(width: 8), const Text('SYSTEM OPERATIONAL', style: TextStyle(color: Color(0xFF10B981), fontSize: 11, fontWeight: FontWeight.w700))]),
              const Spacer(),
              Row(children: [_StatusDot('4 Online', _green), const SizedBox(width: 10), _StatusDot('1 Alert', _amber), const SizedBox(width: 10), _StatusDot('1 Offline', _red)]),
            ]),
          ),
          const SizedBox(height: 14),
          // CAMERA GRID
          _SecHead('LIVE CAMERA FEEDS', _sky),
          const SizedBox(height: 10),
          GridView.count(crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisSpacing: 8, mainAxisSpacing: 8, childAspectRatio: 1.5,
            children: panels.map((p) => _CameraPanel(panel: p)).toList()),
          const SizedBox(height: 20),
          // MONITORING METRICS
          _SecHead('MONITORING METRICS', _teal),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: _MetCard('98.4%', 'Uptime', _green, Icons.check_circle_rounded)),
            const SizedBox(width: 8),
            Expanded(child: _MetCard('12ms', 'Latency', _sky, Icons.speed_rounded)),
            const SizedBox(width: 8),
            Expanded(child: _MetCard('2.4TB', 'Archived', _violet, Icons.storage_rounded)),
          ]),
          const SizedBox(height: 20),
          // MONITORING TOOLS
          _SecHead('MONITORING INTELLIGENCE', _blue),
          const SizedBox(height: 12),
          _MonCard(color: _blue, icon: Icons.analytics_rounded, title: 'Anomaly Detection AI',
              body: 'Machine learning models trained on 30 days of baseline footage identify anomalous patterns — unusual movement, gathering crowds, access outside normal hours — with a false positive rate below 0.3%.'),
          const SizedBox(height: 8),
          _MonCard(color: _amber, icon: Icons.notifications_active_rounded, title: 'Intelligent Alerting',
              body: 'Context-aware alerts that understand what is normal for each location and time of day. A server room at 32°C triggers an alert; the same temperature in an outdoor area does not. Alerts are calibrated to reduce fatigue.'),
          const SizedBox(height: 8),
          _MonCard(color: _teal, icon: Icons.history_rounded, title: 'Event Timeline',
              body: 'Every monitored event — access, movement, environmental reading, or system change — logged with timestamp, camera reference, and contextual data. Searchable and filterable for rapid incident reconstruction.'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [_blue.withOpacity(0.08), _green.withOpacity(0.05)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: _blue.withOpacity(0.18))),
            child: Row(children: [
              Icon(Icons.format_quote_rounded, color: _amber, size: 26), const SizedBox(width: 12),
              const Expanded(child: Text('"What gets monitored gets managed." — Adapted from Peter Drucker', style: TextStyle(color: Colors.white, fontSize: 13, height: 1.4, fontStyle: FontStyle.italic))),
            ]),
          ),
        ],
      ),
    );
  }
}

class _Panel { final String id, status, color2 = '', area, activity, lastEvent; final Color color; const _Panel({required this.id, required this.status, required this.color, required this.area, required this.activity, required this.lastEvent}); }

class _CameraPanel extends StatelessWidget {
  final _Panel panel;
  const _CameraPanel({required this.panel});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(color: const Color(0xFF080C14), borderRadius: BorderRadius.circular(10), border: Border.all(color: panel.color.withOpacity(0.3))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Container(width: 6, height: 6, decoration: BoxDecoration(color: panel.color, shape: BoxShape.circle)),
        const SizedBox(width: 5),
        Text(panel.id, style: const TextStyle(color: Colors.white70, fontSize: 9, fontWeight: FontWeight.w700, fontFamily: 'monospace')),
        const Spacer(),
        Container(padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1), decoration: BoxDecoration(color: panel.color.withOpacity(0.1), borderRadius: BorderRadius.circular(3)), child: Text(panel.status.toUpperCase(), style: TextStyle(color: panel.color, fontSize: 7, fontWeight: FontWeight.w900))),
      ]),
      const SizedBox(height: 6),
      Container(height: 40, decoration: BoxDecoration(color: const Color(0xFF04060A), borderRadius: BorderRadius.circular(6)), child: Center(child: Icon(Icons.videocam_rounded, color: panel.color.withOpacity(0.4), size: 20))),
      const SizedBox(height: 6),
      Text(panel.area, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700)),
      Text(panel.lastEvent, style: const TextStyle(color: Colors.white30, fontSize: 8, height: 1.3), overflow: TextOverflow.ellipsis),
    ]),
  );
}

class _StatusDot extends StatelessWidget {
  final String label; final Color color;
  const _StatusDot(this.label, this.color);
  @override
  Widget build(BuildContext context) => Row(mainAxisSize: MainAxisSize.min, children: [Container(width: 6, height: 6, decoration: BoxDecoration(color: color, shape: BoxShape.circle)), const SizedBox(width: 4), Text(label, style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.w600))]);
}

class _MetCard extends StatelessWidget {
  final String value, label; final Color color; final IconData icon;
  const _MetCard(this.value, this.label, this.color, this.icon);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(vertical: 12), decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withOpacity(0.2))),
    child: Column(children: [Icon(icon, color: color, size: 16), const SizedBox(height: 4), Text(value, style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w900)), Text(label, style: const TextStyle(color: Colors.white38, fontSize: 8))]),
  );
}

class _SecHead extends StatelessWidget {
  final String text; final Color color;
  const _SecHead(this.text, this.color);
  @override
  Widget build(BuildContext context) => Row(children: [Container(width: 3, height: 14, color: color), const SizedBox(width: 8), Text(text, style: TextStyle(color: color.withOpacity(0.85), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2))]);
}

class _MonCard extends StatelessWidget {
  final Color color; final IconData icon; final String title, body;
  const _MonCard({required this.color, required this.icon, required this.title, required this.body});
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
