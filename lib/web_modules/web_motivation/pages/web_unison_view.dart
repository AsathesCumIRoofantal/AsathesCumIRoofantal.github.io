import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../_shared/_web_layout.dart';
import '../../_shared/web_shell.dart';
import 'web_unison_controller.dart';

class WebUnisonView extends GetView<WebUnisonController> {
  static const routeName = '/web-motivation/unison';
  const WebUnisonView({super.key});
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
                  'Being Together is Unison',
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
                              Icons.group_rounded,
                              size: 120,
                              color: Colors.white24,
                            )
                            .animate(onPlay: (c) => c.repeat())
                            .scale(
                              begin: Offset(0.9, 0.9),
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
                        'Synchronized Pulsing',
                        'UI elements that heartbeat in unison with other active users on the page.',
                      ),
                      _buildF(
                        'Empathy-Lapped Grids',
                        'Sliver-grids that morph their borders based on the proximity of connected nodes.',
                      ),
                      _buildF(
                        'Collective-Symmetry',
                        'Mirroring the layout for two users to create a shared virtual space.',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final item = controller.unisonCircles[index];
                  return Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.white10 : Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: item['color'].withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.waves, color: item['color']),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['title'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    item['desc'],
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                      .animate()
                      .fadeIn(delay: (100 * index).ms)
                      .slideX(begin: 0.1);
                }, childCount: controller.unisonCircles.length),
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
