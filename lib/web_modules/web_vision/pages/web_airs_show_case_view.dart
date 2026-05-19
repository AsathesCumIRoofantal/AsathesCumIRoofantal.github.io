import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../_shared/_web_layout.dart';
import '../../_shared/web_shell.dart';
import 'web_airs_show_case_controller.dart';

class WebAirsShowCaseView extends GetView<WebAirsShowCaseController> {
  const WebAirsShowCaseView({super.key});

  static const String routeName = '/web-vision/airs-show-case';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = const Color(0xFFEAB308); // Yellow/Gold for Vision

    // Gradient background for a premium, cinematic feel
    final backgroundGradient = LinearGradient(
      colors: isDark
          ? [
              const Color(0xFF020617),
              const Color(0xFF1E1B4B),
            ] // Deep Blue/Purple
          : [const Color(0xFFFFFBEB), const Color(0xFFFEF3C7)], // Soft Gold
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return WebShell(
      currentRoute: routeName,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(gradient: backgroundGradient),
          child: Column(
            children: [
              // ── TOP NAVIGATION ──
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 24,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_rounded, color: primary),
                      onPressed: () => Get.back(),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'AIR\'s Show Case',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: isDark ? Colors.white : Colors.black87,
                        letterSpacing: 2,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: primary.withValues(alpha: 0.5),
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        'IMMERSIVE VIEW',
                        style: TextStyle(
                          color: primary,
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── IMMERSIVE CAROUSEL ──
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PageView.builder(
                      controller: controller.pageController,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Obx(() {
                          final isActive =
                              controller.currentIndex.value == index;
                          return _GalleryCard(
                            index: index,
                            isActive: isActive,
                            primary: primary,
                            isDark: isDark,
                          );
                        });
                      },
                    ),
                    // Navigation Arrows
                    Positioned(
                      left: 32,
                      child: _buildNavButton(
                        Icons.arrow_back_ios_new_rounded,
                        controller.previousPage,
                        isDark,
                      ),
                    ),
                    Positioned(
                      right: 32,
                      child: _buildNavButton(
                        Icons.arrow_forward_ios_rounded,
                        controller.nextPage,
                        isDark,
                      ),
                    ),
                    // Pagination Dots
                    Positioned(
                      bottom: 40,
                      child: Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            5,
                            (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: controller.currentIndex.value == index
                                  ? 24
                                  : 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: controller.currentIndex.value == index
                                    ? primary
                                    : (isDark
                                          ? Colors.white30
                                          : Colors.black26),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
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
    );
  }

  Widget _buildNavButton(IconData icon, VoidCallback onPressed, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.1)
            : Colors.black.withValues(alpha: 0.05),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: isDark ? Colors.white : Colors.black87),
        onPressed: onPressed,
        padding: const EdgeInsets.all(16),
      ),
    );
  }
}

class _GalleryCard extends StatelessWidget {
  final int index;
  final bool isActive;
  final Color primary;
  final bool isDark;

  const _GalleryCard({
    required this.index,
    required this.isActive,
    required this.primary,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final titles = [
      'The Aurora Initiative',
      'Project Nexus',
      'Global Summit 2025',
      'The Zenith Campus',
      'Future Protocols',
    ];

    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutQuint,
      margin: EdgeInsets.symmetric(
        horizontal: isActive ? 16 : 48,
        vertical: isActive ? 40 : 80,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          if (isActive)
            BoxShadow(
              color: primary.withValues(alpha: 0.2),
              blurRadius: 40,
              offset: const Offset(0, 20),
            ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Mock Image Background
            Container(
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF1E293B)
                    : const Color(0xFFE2E8F0),
              ),
              child: Center(
                child: Icon(
                  Icons.image,
                  size: 120,
                  color: isDark
                      ? Colors.white12
                      : Colors.black.withValues(alpha: 0.05),
                ),
              ),
            ),
            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.8),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AnimatedOpacity(
                    opacity: isActive ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 400),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Text(
                        'FEATURED',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 12,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  AnimatedSlide(
                    offset: isActive ? Offset.zero : const Offset(0, 0.5),
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOutCubic,
                    child: Text(
                      titles[index],
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: -1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  AnimatedOpacity(
                    opacity: isActive ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 800),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 600),
                      child: Text(
                        'A showcase of our most ambitious projects and their global impact. Experience the scale and depth of AIR\'s capabilities through these curated case studies.',
                        style: TextStyle(
                          fontSize: 18,
                          height: 1.6,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  AnimatedOpacity(
                    opacity: isActive ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 1000),
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      icon: const Icon(Icons.play_arrow_rounded),
                      label: const Text(
                        'View Case Study',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
