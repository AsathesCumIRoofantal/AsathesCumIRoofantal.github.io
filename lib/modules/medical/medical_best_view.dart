import 'package:flutter/material.dart';
import 'dart:math' as math;

/// DESIGN: Dashboard KPI with metric rings + animated-style data visualization
class MedicalBestView extends StatelessWidget {
  const MedicalBestView({super.key});

  static const _teal = Color(0xFF0D9488);
  static const _green = Color(0xFF10B981);
  static const _blue = Color(0xFF2563EB);
  static const _sky = Color(0xFF0EA5E9);
  static const _amber = Color(0xFFF59E0B);
  static const _red = Color(0xFFEF4444);
  static const _violet = Color(0xFF7C3AED);
  static const _bg = Color(0xFF010D0D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: const Text('MEDICAL INTELLIGENCE', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 13, color: Colors.white)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 14), child: Icon(Icons.medical_services_rounded, color: _teal, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        children: [
          // STATUS BANNER
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(color: _green.withOpacity(0.1), borderRadius: BorderRadius.circular(12), border: Border.all(color: _green.withOpacity(0.25))),
            child: Row(children: [
              Container(width: 8, height: 8, decoration: const BoxDecoration(color: _green, shape: BoxShape.circle)),
              const SizedBox(width: 10),
              const Text('HEALTH SYSTEMS ONLINE', style: TextStyle(color: Color(0xFF10B981), fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 2)),
              const Spacer(),
              const Text('Live', style: TextStyle(color: Colors.white38, fontSize: 10)),
            ]),
          ),
          const SizedBox(height: 16),
          // KPI RINGS ROW
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            _Ring(value: 0.94, label: 'Vitals\nScore', color: _green, display: '9.4'),
            _Ring(value: 0.78, label: 'Activity\nIndex', color: _sky, display: '78%'),
            _Ring(value: 0.91, label: 'Sleep\nQuality', color: _violet, display: '91%'),
            _Ring(value: 0.66, label: 'Stress\nLevel', color: _amber, display: '66%'),
          ]),
          const SizedBox(height: 20),
          // SECTION: MODULES
          _SectionHead('CLINICAL MODULES', _teal),
          const SizedBox(height: 10),
          _KpiCard(icon: Icons.monitor_heart_rounded, color: _teal, title: 'Health Monitoring', value: 'Active', detail: 'Real-time vital tracking across 12 biometric parameters. Alerts trigger when readings deviate from your personal baseline — not generic norms — making detection far more accurate.'),
          const SizedBox(height: 8),
          _KpiCard(icon: Icons.medication_rounded, color: _blue, title: 'Medication Manager', value: '3 Active', detail: 'Track prescriptions, dosage schedules, refill dates, and potential interactions. Adherence rate calculated automatically from confirmed-taken logs — currently at 96%.'),
          const SizedBox(height: 8),
          _KpiCard(icon: Icons.calendar_month_rounded, color: _sky, title: 'Appointment Tracker', value: '2 Upcoming', detail: 'Scheduled consultations, required pre-appointment prep, and post-appointment follow-up tasks all tracked in one view. Next: Cardiology, May 22nd.'),
          const SizedBox(height: 8),
          _KpiCard(icon: Icons.biotech_rounded, color: _violet, title: 'Lab Results Hub', value: '14 Filed', detail: 'All lab results stored with trend lines over time. Flags values that are trending toward clinical concern ranges before they breach them, enabling preventive action.'),
          const SizedBox(height: 8),
          _KpiCard(icon: Icons.psychology_rounded, color: _amber, title: 'Mental Wellness', value: 'Good', detail: 'Daily mood and anxiety ratings averaged into a rolling 30-day mental wellness score. Current score: 7.8/10. Correlates with sleep quality and exercise data for root-cause insight.'),
          const SizedBox(height: 8),
          _KpiCard(icon: Icons.emergency_rounded, color: _red, title: 'Emergency Protocols', value: '2 Saved', detail: 'Pre-set emergency contacts, blood type, allergy list, and critical medication information stored in an instantly accessible emergency card — shareable in seconds with first responders.'),
          const SizedBox(height: 20),
          // BOTTOM METRIC GRID
          _SectionHead('HEALTH SCORECARD', _green),
          const SizedBox(height: 10),
          GridView.count(crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), crossAxisSpacing: 8, mainAxisSpacing: 8, childAspectRatio: 2.4,
            children: [
              _MetricTile('BMI', '23.1', 'Normal', _green),
              _MetricTile('Blood Pressure', '118/76', 'Optimal', _sky),
              _MetricTile('Resting HR', '62 bpm', 'Excellent', _teal),
              _MetricTile('VO2 Max', '42.3', 'Above Avg', _violet),
            ]),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(gradient: LinearGradient(colors: [_teal.withOpacity(0.12), _green.withOpacity(0.06)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: _teal.withOpacity(0.2))),
            child: Row(children: [
              Icon(Icons.format_quote_rounded, color: _teal, size: 26),
              const SizedBox(width: 12),
              const Expanded(child: Text('"The greatest wealth is health." — Virgil', style: TextStyle(color: Colors.white, fontSize: 13, fontStyle: FontStyle.italic, height: 1.4))),
            ]),
          ),
        ],
      ),
    );
  }
}

class _Ring extends StatelessWidget {
  final double value; final String label, display; final Color color;
  const _Ring({required this.value, required this.label, required this.color, required this.display});
  @override
  Widget build(BuildContext context) => Column(children: [
    SizedBox(width: 70, height: 70, child: CustomPaint(painter: _RingPainter(value: value, color: color),
      child: Center(child: Text(display, style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.w900))))),
    const SizedBox(height: 6),
    Text(label, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white54, fontSize: 9, height: 1.3)),
  ]);
}

class _RingPainter extends CustomPainter {
  final double value; final Color color;
  _RingPainter({required this.value, required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2; final cy = size.height / 2; final r = (size.width - 8) / 2;
    final bg = Paint()..color = color.withOpacity(0.12)..strokeWidth = 6..style = PaintingStyle.stroke..strokeCap = StrokeCap.round;
    final fg = Paint()..color = color..strokeWidth = 6..style = PaintingStyle.stroke..strokeCap = StrokeCap.round;
    canvas.drawCircle(Offset(cx, cy), r, bg);
    canvas.drawArc(Rect.fromCircle(center: Offset(cx, cy), radius: r), -math.pi / 2, 2 * math.pi * value, false, fg);
  }
  @override bool shouldRepaint(_) => false;
}

class _SectionHead extends StatelessWidget {
  final String text; final Color color;
  const _SectionHead(this.text, this.color);
  @override
  Widget build(BuildContext context) => Row(children: [
    Container(width: 3, height: 14, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
    const SizedBox(width: 8),
    Text(text, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2)),
  ]);
}

class _KpiCard extends StatelessWidget {
  final IconData icon; final Color color; final String title, value, detail;
  const _KpiCard({required this.icon, required this.color, required this.title, required this.value, required this.detail});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: color.withOpacity(0.07), borderRadius: BorderRadius.circular(14), border: Border.all(color: color.withOpacity(0.18))),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: color.withOpacity(0.14), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: color, size: 18)),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700)),
          Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(6)), child: Text(value, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w700))),
        ]),
        const SizedBox(height: 6),
        Text(detail, style: const TextStyle(color: Colors.white54, fontSize: 11, height: 1.45)),
      ])),
    ]),
  );
}

class _MetricTile extends StatelessWidget {
  final String label, value, status; final Color color;
  const _MetricTile(this.label, this.value, this.status, this.color);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(color: color.withOpacity(0.07), borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withOpacity(0.18))),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(color: Colors.white54, fontSize: 9)),
      Text(value, style: TextStyle(color: color, fontSize: 15, fontWeight: FontWeight.w900)),
      Text(status, style: TextStyle(color: color.withOpacity(0.7), fontSize: 9, fontWeight: FontWeight.w600)),
    ]),
  );
}
