import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../_shared/_web_layout.dart';
import '../../_shared/web_shell.dart';
import 'web_limits_controller.dart';

class WebLimitsView extends GetView<WebLimitsController> {
  static const routeName = '/web-aspects/limits';
  const WebLimitsView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = const Color(0xFFE11D48);
    final secondaryColor = const Color(0xFFB91C1C);

    return WebShell(
      currentRoute: routeName,
      child: Scaffold(
        backgroundColor: isDark ? WColors.surfaceDark : const Color(0xFFFFF1F2),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              backgroundColor: primaryColor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                onPressed: () => Get.back(),
              ),
              flexibleSpace: FlexibleSpaceBar(
                title: const Text(
                  'Limits (0 or 1)',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primaryColor, secondaryColor],
                    ),
                  ),
                  child: Center(
                    child: Obx(
                      () =>
                          Icon(
                                controller.isInfiniteMode.value
                                    ? Icons.blur_on_rounded
                                    : Icons.blur_off_rounded,
                                size: 120,
                                color: Colors.white24,
                              )
                              .animate(onPlay: (c) => c.repeat())
                              .scale(
                                begin: Offset(0.9, 0.9),
                                end: Offset(1.1, 1.1),
                                duration: Duration(seconds: 2),
                              ),
                    ),
                  ),
                ),
              ),
            ),

            // THE BINARY TOGGLE (Unique Centerpiece)
            SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    children: [
                      const Text(
                        'SYSTEM STATE',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Obx(
                        () => GestureDetector(
                          onTap: controller.toggleLimit,
                          child: Container(
                            width: 120,
                            height: 60,
                            decoration: BoxDecoration(
                              color: controller.isInfiniteMode.value
                                  ? primaryColor
                                  : Colors.grey[400],
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryColor.withValues(alpha: 0.3),
                                  blurRadius: 20,
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                AnimatedAlign(
                                  duration: 300.ms,
                                  alignment: controller.isInfiniteMode.value
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    child: Container(
                                      width: 25,
                                      height: 25,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 15,
                                  child: Text(
                                    '0',
                                    style: TextStyle(
                                      color: controller.isInfiniteMode.value
                                          ? Colors.white54
                                          : Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 15,
                                  child: Text(
                                    '1',
                                    style: TextStyle(
                                      color: controller.isInfiniteMode.value
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Obx(
                        () => Text(
                          controller.isInfiniteMode.value
                              ? 'INFINITE MODE ACTIVE'
                              : 'MINIMAL BASELINE ACTIVE',
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

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
                      _buildFeature(
                        'State-Morphing UI',
                        'The entire layout physically transforms based on the binary state (0/1).',
                      ),
                      _buildFeature(
                        'Binary-Rain Backdrop',
                        'Procedural background patterns that react to the current limit state.',
                      ),
                      _buildFeature(
                        'Asymmetric Scaling',
                        'Cards expand and contract their internal richness using reactive slivers.',
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
                  final item = controller.limitsData[index];
                  return Obx(
                    () =>
                        Container(
                              margin: const EdgeInsets.only(bottom: 15),
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: isDark ? Colors.white10 : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: item['color'].withValues(alpha: 0.3),
                                  width: controller.isInfiniteMode.value
                                      ? 3
                                      : 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    item['icon'],
                                    color: item['color'],
                                    size: 30,
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['title'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          controller.isInfiniteMode.value
                                              ? item['limit1']
                                              : item['limit0'],
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (controller.isInfiniteMode.value)
                                    const Icon(
                                      Icons.verified,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                ],
                              ),
                            )
                            .animate()
                            .fadeIn(delay: (100 * index).ms)
                            .slideX(begin: 0.1),
                  );
                }, childCount: controller.limitsData.length),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 60)),
          ],
        ),
      ),
    );
  }

  Widget _buildFeature(String title, String desc) {
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
