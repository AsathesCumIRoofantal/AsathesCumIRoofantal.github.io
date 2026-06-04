import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../_shared/_web_layout.dart';
import '../../_shared/web_shell.dart';
import 'web_maintenance_controller.dart';

class WebMaintenanceView extends GetView<WebMaintenanceController> {
  static const routeName = '/web-profile/maintenance';
  const WebMaintenanceView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = const Color(0xFF7C3AED); // Profile Violet
    final secondaryColor = const Color(0xFF4C1D95);

    return WebShell(
      currentRoute: routeName,
      child: Scaffold(
        backgroundColor: isDark ? WColors.surfaceDark : const Color(0xFFF8FAFC),
        body: CustomScrollView(
          slivers: [
            // 1. THE DIAGNOSTIC HEADER (SliverAppBar)
            SliverAppBar(
              expandedHeight: 420,
              pinned: true,
              backgroundColor: primaryColor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                onPressed: () => Get.back(),
              ),
              flexibleSpace: FlexibleSpaceBar(
                title: const Text(
                  'SYSTEM MAINTENANCE',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primaryColor, secondaryColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // 2026 UNIQUE: Rotating Radar Custom Paint
                      Obx(
                        () => controller.isScanning.value
                            ? CustomPaint(
                                    size: const Size(350, 350),
                                    painter: RadarPainter(primaryColor),
                                  )
                                  .animate(onPlay: (c) => c.repeat())
                                  .rotate(duration: Duration(seconds: 4))
                            : const SizedBox.shrink(),
                      ),

                      // Center Health Gauge
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'CORE STABILITY',
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 3,
                            ),
                          ),
                          Obx(
                            () => Text(
                              '${controller.systemHealth.value}%',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 64,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'OPTIMAL',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 2. THE HEALTH Gauges (Glassmorphism Row)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    _buildGauge(
                      'CPU LOAD',
                      controller.cpuLoad,
                      Icons.memory,
                      isDark,
                    ),
                    const SizedBox(width: 15),
                    _buildGauge(
                      'MEMORY',
                      controller.memoryUsage,
                      Icons.storage,
                      isDark,
                    ),
                    const SizedBox(width: 15),
                    _buildGauge(
                      'LATENCY',
                      controller.networkLatency,
                      Icons.wifi,
                      isDark,
                    ),
                  ],
                ),
              ),
            ),

            // 3. FLUTTER 2026 BLOCK (Maintenance Specialization)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.auto_awesome,
                            color: Color(0xFFA78BFA),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Flutter 2026 Powers This',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildFeatureRow(
                        'Sliver-Symmetry',
                        'Perfectly aligned layouts that shift dynamically based on system load.',
                      ),
                      _buildFeatureRow(
                        'Custom Render Pipelines',
                        'GPU-accelerated Radar simulation running at constant 120fps.',
                      ),
                      _buildFeatureRow(
                        'Haptic Diagnostics',
                        'Sensing hardware health via high-frequency vibration patterns.',
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 4. THE CYBER-TERMINAL (Log Stream)
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0A0A0A), // Deep Black
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: primaryColor.withValues(alpha: 0.4),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withValues(alpha: 0.2),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.terminal,
                                color: Colors.greenAccent,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'CORE_LOGS_V2.0',
                                style: TextStyle(
                                  color: Colors.greenAccent,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ],
                          ),
                          Obx(
                            () => Switch(
                              value: controller.isScanning.value,
                              onChanged: (_) => controller.toggleScan(),
                              activeColor: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: Colors.white10, height: 20),
                      ...controller.systemLogs
                          .map(
                            (log) => Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '[${log['time']}] ',
                                    style: const TextStyle(
                                      color: Colors.greenAccent,
                                      fontSize: 13,
                                      fontFamily: 'monospace',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      log['msg']!,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 13,
                                        fontFamily: 'monospace',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                      const SizedBox(height: 10),
                      const Text(
                        '█',
                        style: TextStyle(
                          color: Colors.greenAccent,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 60)),
          ],
        ),
      ),
    );
  }

  Widget _buildGauge(String label, RxDouble value, IconData icon, bool isDark) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? Colors.white10 : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF7C3AED).withValues(alpha: 0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF7C3AED), size: 20),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            Obx(
              () => Text(
                '${value.value}${label == 'LATENCY' ? ' ms' : '%'}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureRow(String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(
              color: Color(0xFFA78BFA),
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.white70, fontSize: 13),
                children: [
                  TextSpan(
                    text: '$title: ',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: desc),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 2026 Custom Paint: Radar Logic
class RadarPainter extends CustomPainter {
  final Color color;
  RadarPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = color.withValues(alpha: 0.15)
      ..strokeWidth = 1;
    // Draw Grid Circles
    paint.style = PaintingStyle.stroke;
    paint.color = color.withValues(alpha: 0.15);
    paint.strokeWidth = 1;
    for (var i = 1; i <= 3; i++) {
      canvas.drawCircle(center, radius * (i / 3), paint);
    }

    // Draw the sweeping line (rotation handled by .animate().rotate())
    paint.color = color.withValues(alpha: 0.5);
    paint.strokeWidth = 3;
    canvas.drawLine(center, Offset(center.dx + radius, center.dy), paint);

    // Draw a glow at the end of the line
    paint.color = Colors.white;
    canvas.drawCircle(Offset(center.dx + radius, center.dy), 3, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
