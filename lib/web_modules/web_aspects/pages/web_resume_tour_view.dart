import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../_shared/_web_layout.dart';
import '../../_shared/web_shell.dart';
import 'web_resume_tour_controller.dart';

class WebResumeTourView extends GetView<WebResumeTourController> {
  static const routeName = '/web-aspects/resume-tour';
  const WebResumeTourView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = const Color(0xFFE11D48); // Aspects Rose
    final secondaryColor = const Color(0xFFB91C1C);

    return WebShell(
      currentRoute: routeName,
      child: Scaffold(
        // Aspects light background: Pale Rose
        backgroundColor: isDark ? WColors.surfaceDark : const Color(0xFFFFF1F2),
        body: CustomScrollView(
          slivers: [
            // 1. THE JOURNEY HEADER
            SliverAppBar(
              expandedHeight: 350,
              pinned: true,
              backgroundColor: primaryColor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                onPressed: () => Get.back(),
              ),
              flexibleSpace: FlexibleSpaceBar(
                title: const Text(
                  "Resume Your Journey",
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
                      Positioned(
                        right: -50,
                        top: 20,
                        child: _buildPulseCircle(200, Colors.white10),
                      ),
                      Positioned(
                        left: -30,
                        bottom: 50,
                        child: _buildPulseCircle(150, Colors.white10),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.map_rounded,
                              size: 100,
                              color: Colors.white24,
                            ),
                            const SizedBox(height: 20),
                            Obx(
                              () => Text(
                                '${controller.tourPercentage.value.toStringAsFixed(1)}% Explored',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 2. PROGRESS DASHBOARD (Bento-style)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white10 : Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: primaryColor.withValues(alpha: 0.2),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withValues(alpha: 0.05),
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMetric(
                        'STOPS',
                        controller.completedStops,
                        '/ ${controller.totalStops}',
                        Icons.location_on,
                      ),
                      const VerticalDivider(color: Colors.grey),
                      _buildMetric('STATUS', 'Active', '', Icons.bolt),
                      const VerticalDivider(color: Colors.grey),
                      _buildMetric(
                        'NEXT',
                        'Sliver Hub',
                        '',
                        Icons.auto_awesome,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 3. FLUTTER 2026 BLOCK (Aspects Specialization)
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
                        'Animated Steppers',
                        'The roadmap path dynamically calculates distance and draws in real-time.',
                      ),
                      _buildFeatureRow(
                        'Gamified Onboarding',
                        'Each stop triggers a micro-confetti burst upon successful completion.',
                      ),
                      _buildFeatureRow(
                        'Haptic Journey-Sync',
                        'Device vibrations match the "importance" of the tour stop.',
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 4. THE INTERACTIVE ROADMAP (The core unique design)
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final stop = controller.tourStops[index];
                  return _TourStopCard(
                    stop: stop,
                    index: index,
                    isDark: isDark,
                    primaryColor: primaryColor,
                  );
                }, childCount: controller.tourStops.length),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 60)),
          ],
        ),
      ),
    );
  }

  Widget _buildPulseCircle(double size, Color color) {
    return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        )
        .animate(onPlay: (c) => c.repeat())
        .scale(
          begin: Offset(1, 1),
          end: Offset(1.5, 1.5),
          duration: Duration(seconds: 3),
          curve: Curves.easeInOut,
        )
        .fadeIn();
  }

  Widget _buildMetric(
    String label,
    dynamic value,
    String suffix,
    IconData icon,
  ) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFFE11D48), size: 24),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '$value$suffix',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
        ),
      ],
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

class _TourStopCard extends StatelessWidget {
  final Map<String, dynamic> stop;
  final int index;
  final bool isDark;
  final Color primaryColor;

  const _TourStopCard({
    required this.stop,
    required this.index,
    required this.isDark,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    bool isCompleted = stop['status'] == 'completed';
    bool isCurrent = stop['status'] == 'current';

    return IntrinsicHeight(
      child: Row(
        children: [
          // THE ROADMAP LINE
          SizedBox(
            width: 40,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: 4,
                    color: index == 0
                        ? Colors.transparent
                        : (isCompleted
                              ? primaryColor
                              : Colors.grey.withOpacity(0.3)),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white10 : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isCurrent
                          ? primaryColor
                          : (isCompleted
                                ? primaryColor.withValues(alpha: 0.2)
                                : Colors.grey.withOpacity(0.2)),
                      width: isCurrent ? 2 : 1,
                    ),
                    boxShadow: isCurrent
                        ? [
                            BoxShadow(
                              color: primaryColor.withValues(alpha: 0.15),
                              blurRadius: 15,
                            ),
                          ]
                        : [],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isCompleted
                              ? primaryColor
                              : (isCurrent
                                    ? primaryColor.withValues(alpha: 0.2)
                                    : Colors.grey.withValues(alpha: 0.1)),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          stop['icon'],
                          color: isCompleted ? Colors.white : primaryColor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              stop['title'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              stop['desc'],
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isCurrent)
                        ElevatedButton(
                          onPressed: () =>
                              Get.find<WebResumeTourController>().resumeTour(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('RESUME'),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: (100 * index).ms).slideX(begin: 0.1);
  }
}
