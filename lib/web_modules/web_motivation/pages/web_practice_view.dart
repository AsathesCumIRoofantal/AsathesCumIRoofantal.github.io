import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../_shared/_web_layout.dart';
import '../../_shared/web_shell.dart';
import 'web_practice_controller.dart';

class WebPracticeView extends GetView<WebPracticeController> {
  static const routeName = '/web-motivation/practice';
  const WebPracticeView({super.key});
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = const Color(0xFFEC4899);
    return WebShell(
      currentRoute: routeName,
      child: Scaffold(
        backgroundColor: isDark ? WColors.surfaceDark : const Color(0xFFFFF1F2),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              backgroundColor: primary,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text(
                  'Practice & Expertise',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primary, const Color(0xFFB91C1C)],
                    ),
                  ),
                  child: Center(
                    child:
                        Icon(
                              Icons.fitness_center_rounded,
                              size: 120,
                              color: Colors.white24,
                            )
                            .animate(onPlay: (c) => c.repeat())
                            .scale(
                              begin: Offset(.9, .9),
                              end: Offset(1.1, 1.1),
                            ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
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
                      const Row(
                        children: [
                          Icon(Icons.auto_awesome, color: Color(0xFFA78BFA)),
                          SizedBox(width: 8),
                          Text(
                            'Flutter 2026 Powers This',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildF(
                        'Haptic Progress-Sensing',
                        'Feeling the "weight" of expertise as a progress bar fills.',
                      ),
                      _buildF(
                        'Sliver-Grid Mastery',
                        'Adaptive lapped grid that highlights the most practiced skill.',
                      ),
                      _buildF(
                        'Expertise-Symmetry',
                        'Real-time comparison of your current skill vs the global average lapped data.',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  final item = controller.masteryLevels[index];
                  return Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white10 : Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: primary.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(item['icon'], color: primary),
                        const Spacer(),
                        Text(
                          item['skill'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 10),
                        LinearProgressIndicator(
                          value: item['progress'],
                          color: primary,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${item['hours']} Invested',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: (100 * index).ms);
                }, childCount: controller.masteryLevels.length),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildF(String t, String d) => Padding(
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
                  text: '$t: ',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: d),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
