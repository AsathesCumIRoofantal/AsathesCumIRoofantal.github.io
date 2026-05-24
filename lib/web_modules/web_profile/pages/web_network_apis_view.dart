import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../_shared/_web_layout.dart';
import '../../_shared/web_shell.dart';
import 'web_network_apis_controller.dart';

class WebNetworkApisView extends GetView<WebNetworkApisController> {
  static const routeName = '/web-profile/network-apis';
  const WebNetworkApisView({super.key});

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
            // 1. NEURAL HUB HEADER
            SliverAppBar(
              expandedHeight: 320,
              pinned: true,
              backgroundColor: primaryColor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                onPressed: () => Get.back(),
              ),
              flexibleSpace: FlexibleSpaceBar(
                title: const Text(
                  'Network & API Hub',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    color: Colors.white,
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
                    children: [
                      // 2026 UNIQUE: "Connecting Nodes" Background
                      Positioned.fill(
                        child: CustomPaint(painter: NetworkLinesPainter()),
                      ),
                      Center(
                        child:
                            Icon(
                                  Icons.hub_rounded,
                                  size: 140,
                                  color: Colors.white.withOpacity(0.2),
                                )
                                .animate(onPlay: (c) => c.repeat())
                                .rotate(
                                  duration: Duration(seconds: 10),
                                  curve: Curves.linear,
                                ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 2. LIVE METRICS DASHBOARD
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    _buildStatCard(
                      'LATENCY',
                      controller.globalLatency,
                      ' ms',
                      Icons.speed,
                      isDark,
                    ),
                    const SizedBox(width: 15),
                    _buildStatCard(
                      'REQUESTS',
                      controller.totalRequests,
                      ' API',
                      Icons.dataset,
                      isDark,
                    ),
                    const SizedBox(width: 15),
                    _buildStatCard(
                      'UPTIME',
                      controller.systemUptime,
                      '%',
                      Icons.cloud_done,
                      isDark,
                      isText: true,
                    ),
                  ],
                ),
              ),
            ),

            // 3. FLUTTER 2026 BLOCK (Network Specialization)
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
                        'gRPC-Web Integration',
                        'Direct binary streaming for API responses, reducing payload size by 60%.',
                      ),
                      _buildFeatureRow(
                        'Auto-Rotation Logic',
                        'Self-healing keys that rotate automatically on detected anomalies.',
                      ),
                      _buildFeatureRow(
                        'Sliver-Sync Mesh',
                        'Dynamic UI updates based on real-time server heartbeat signals.',
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 4. API NODE LIST (The "Neural" Feed)
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final node = controller.apiNodes[index];
                  return _ApiNodeCard(node: node, index: index, isDark: isDark);
                }, childCount: controller.apiNodes.length),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 60)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String label,
    RxDouble? value,
    String suffix,
    IconData icon,
    bool isDark, {
    bool isText = false,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? Colors.white10 : Colors.white,
          borderRadius: BorderRadius.circular(24),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: const Color(0xFF7C3AED), size: 24),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            Obx(
              () => Text(
                isText
                    ? '${controller.systemUptime.value}$suffix'
                    : '${value?.value}$suffix',
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
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

class _ApiNodeCard extends StatelessWidget {
  final Map<String, dynamic> node;
  final int index;
  final bool isDark;
  const _ApiNodeCard({
    required this.node,
    required this.index,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final color = node['color'] as Color;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? Colors.white10 : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.08),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // THE HEARTBEAT: Pulsing dot animation
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ).animate().scale(duration: Duration(seconds: 1)),
                  const SizedBox(width: 10),
                  Text(
                    node['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Text(
                node['status'],
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          // API KEY BOX (Glassmorphic Code Block)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? Colors.black38 : Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color.withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                const Icon(Icons.vpn_key_rounded, size: 16, color: Colors.grey),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    node['key'],
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.refresh_rounded,
                    size: 18,
                    color: Colors.grey,
                  ),
                  onPressed: () =>
                      Get.find<WebNetworkApisController>().rotateKey(index),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                node['endpoint'],
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Text(
                '${node['callsPerMin']} req/m',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: (100 * index).ms).slideX(begin: 0.1);
  }
}

// 2026 Background Painter: Neural Mesh
class NetworkLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.strokeWidth = 0.5;
    paint.color = Colors.white.withOpacity(0.1);

    // Draw abstract grid of connecting nodes
    for (var i = 0; i < size.width; i += 60) {
      canvas.drawLine(
        Offset(i.toDouble(), 0),
        Offset(i.toDouble(), size.height),
        paint,
      );
    }
    for (var j = 0; j < size.height; j += 60) {
      canvas.drawLine(
        Offset(0, j.toDouble()),
        Offset(size.width, j.toDouble()),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
