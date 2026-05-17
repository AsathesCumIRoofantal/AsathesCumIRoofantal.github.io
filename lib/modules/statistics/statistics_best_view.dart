import 'package:flutter/material.dart';
import 'dart:math' as math;

/// DESIGN: Data Visualization Dashboard — charts, sparklines, and data-rich panels
class StatisticsBestView extends StatelessWidget {
  const StatisticsBestView({super.key});

  static const _blue = Color(0xFF2563EB);
  static const _sky = Color(0xFF0EA5E9);
  static const _teal = Color(0xFF0D9488);
  static const _green = Color(0xFF10B981);
  static const _amber = Color(0xFFF59E0B);
  static const _red = Color(0xFFEF4444);
  static const _violet = Color(0xFF7C3AED);
  static const _bg = Color(0xFF010510);

  @override
  Widget build(BuildContext context) {
    final sparkData = [0.3, 0.5, 0.4, 0.7, 0.6, 0.8, 0.75, 0.9, 0.85, 0.95];

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        foregroundColor: Colors.white,
        title: const Text('STATISTICS ENGINE', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 13, color: Colors.white)),
        centerTitle: true,
        actions: [Padding(padding: const EdgeInsets.only(right: 14), child: Icon(Icons.analytics_rounded, color: _blue, size: 22))],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
        children: [
          // MAIN KPI ROW
          Row(children: [
            Expanded(child: _KpiBox('2,847', 'Data Points', _sky, Icons.data_object_rounded)),
            const SizedBox(width: 8),
            Expanded(child: _KpiBox('94.3%', 'Accuracy', _green, Icons.verified_rounded)),
            const SizedBox(width: 8),
            Expanded(child: _KpiBox('12', 'Reports', _violet, Icons.bar_chart_rounded)),
          ]),
          const SizedBox(height: 16),
          // SPARKLINE CHART
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: _blue.withOpacity(0.07), borderRadius: BorderRadius.circular(16), border: Border.all(color: _blue.withOpacity(0.18))),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Text('PERFORMANCE TREND', style: TextStyle(color: _sky, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 2)),
                const Spacer(),
                Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: _green.withOpacity(0.12), borderRadius: BorderRadius.circular(6)), child: Text('↑ +26%', style: TextStyle(color: _green, fontSize: 10, fontWeight: FontWeight.w800))),
              ]),
              const SizedBox(height: 14),
              SizedBox(height: 80, child: CustomPaint(painter: _SparkPainter(data: sparkData, color: _sky), size: const Size(double.infinity, 80))),
              const SizedBox(height: 8),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: ['Q1', 'Q2', 'Q3', 'Q4', 'Q5', 'Q6', 'Q7', 'Q8', 'Q9', 'Q10'].map((q) => Text(q, style: const TextStyle(color: Colors.white24, fontSize: 8))).toList()),
            ]),
          ),
          const SizedBox(height: 12),
          // BAR CHART
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: _violet.withOpacity(0.06), borderRadius: BorderRadius.circular(16), border: Border.all(color: _violet.withOpacity(0.16))),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('CATEGORY BREAKDOWN', style: TextStyle(color: _violet, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 2)),
              const SizedBox(height: 16),
              ...[('Economic', 0.82, _green), ('Social', 0.67, _sky), ('Political', 0.54, _blue), ('Cultural', 0.73, _amber), ('Environmental', 0.61, _teal)].map((b) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(children: [
                  SizedBox(width: 90, child: Text(b.$1, style: const TextStyle(color: Colors.white60, fontSize: 10))),
                  Expanded(child: Stack(children: [
                    Container(height: 16, decoration: BoxDecoration(color: Colors.white.withOpacity(0.04), borderRadius: BorderRadius.circular(3))),
                    FractionallySizedBox(widthFactor: b.$2, child: Container(height: 16, decoration: BoxDecoration(color: b.$3, borderRadius: BorderRadius.circular(3)))),
                  ])),
                  const SizedBox(width: 8),
                  Text('${(b.$2 * 100).round()}%', style: TextStyle(color: b.$3, fontSize: 10, fontWeight: FontWeight.w700, width: 32)),
                ]),
              )),
            ]),
          ),
          const SizedBox(height: 12),
          // STATISTICS TOOLS
          Row(children: [Container(width: 3, height: 14, color: _teal), const SizedBox(width: 8), Text('STATISTICAL INTELLIGENCE', style: TextStyle(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 2))]),
          const SizedBox(height: 12),
          _StatTool(color: _sky, icon: Icons.timeline_rounded, title: 'Trend Analysis Engine',
              body: 'Identify patterns, cycles, and trajectories in any dataset. The trend engine distinguishes genuine trends from statistical noise using smoothing algorithms calibrated to your data volatility profile.'),
          const SizedBox(height: 8),
          _StatTool(color: _green, icon: Icons.compare_arrows_rounded, title: 'Comparative Benchmarking',
              body: 'Compare your metrics against peers, historical performance, and industry standards. Benchmarking reveals whether an improvement is genuine progress or simply a rising tide lifting all boats.'),
          const SizedBox(height: 8),
          _StatTool(color: _amber, icon: Icons.warning_rounded, title: 'Outlier Detection',
              body: 'Automated flagging of statistical outliers — both positive (outperformers to study) and negative (failures to investigate). Understanding outliers is where the most valuable learning concentrates.'),
          const SizedBox(height: 8),
          _StatTool(color: _violet, icon: Icons.precision_manufacturing_rounded, title: 'Predictive Modelling',
              body: 'Build forecasts from historical data using regression analysis, moving averages, and pattern recognition. Predictions are always presented with confidence intervals, not false precision.'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: LinearGradient(colors: [_blue.withOpacity(0.08), _violet.withOpacity(0.05)]), borderRadius: BorderRadius.circular(16), border: Border.all(color: _blue.withOpacity(0.18))),
            child: Row(children: [
              Icon(Icons.format_quote_rounded, color: _amber, size: 26), const SizedBox(width: 12),
              const Expanded(child: Text('"Without data you\'re just another person with an opinion." — W. Edwards Deming', style: TextStyle(color: Colors.white, fontSize: 13, height: 1.4, fontStyle: FontStyle.italic))),
            ]),
          ),
        ],
      ),
    );
  }
}

class _KpiBox extends StatelessWidget {
  final String value, label; final Color color; final IconData icon;
  const _KpiBox(this.value, this.label, this.color, this.icon);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
    decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(14), border: Border.all(color: color.withOpacity(0.2))),
    child: Column(children: [
      Icon(icon, color: color, size: 18),
      const SizedBox(height: 6),
      Text(value, style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.w900)),
      Text(label, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white38, fontSize: 9, height: 1.2)),
    ]),
  );
}

class _SparkPainter extends CustomPainter {
  final List<double> data; final Color color;
  _SparkPainter({required this.data, required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = color..strokeWidth = 2..style = PaintingStyle.stroke..strokeCap = StrokeCap.round..strokeJoin = StrokeJoin.round;
    final fill = Paint()..shader = LinearGradient(colors: [color.withOpacity(0.3), color.withOpacity(0.0)], begin: Alignment.topCenter, end: Alignment.bottomCenter).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    final path = Path(); final fPath = Path();
    for (int i = 0; i < data.length; i++) {
      final x = i * (size.width / (data.length - 1)); final y = size.height - data[i] * size.height;
      if (i == 0) { path.moveTo(x, y); fPath.moveTo(x, y); } else { path.lineTo(x, y); fPath.lineTo(x, y); }
    }
    fPath.lineTo(size.width, size.height); fPath.lineTo(0, size.height); fPath.close();
    canvas.drawPath(fPath, fill); canvas.drawPath(path, p);
    // dots
    final dp = Paint()..color = color..style = PaintingStyle.fill;
    for (int i = 0; i < data.length; i++) { canvas.drawCircle(Offset(i * (size.width / (data.length - 1)), size.height - data[i] * size.height), 3, dp); }
  }
  @override bool shouldRepaint(_) => false;
}

class _StatTool extends StatelessWidget {
  final Color color; final IconData icon; final String title, body;
  const _StatTool({required this.color, required this.icon, required this.title, required this.body});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(13), decoration: BoxDecoration(color: color.withOpacity(0.07), borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withOpacity(0.18))),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(padding: const EdgeInsets.all(7), decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(9)), child: Icon(icon, color: color, size: 16)),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w800)),
        const SizedBox(height: 4),
        Text(body, style: const TextStyle(color: Colors.white54, fontSize: 11, height: 1.4)),
      ])),
    ]),
  );
}
