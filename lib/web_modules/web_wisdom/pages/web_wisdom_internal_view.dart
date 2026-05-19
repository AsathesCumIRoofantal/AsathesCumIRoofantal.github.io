import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../_shared/_web_layout.dart';
import '../../_shared/web_shell.dart';
import 'web_wisdom_internal_controller.dart';

class WebWisdomInternalView extends GetView<WebWisdomInternalController> {
  const WebWisdomInternalView({super.key});

  static const String routeName = '/web-wisdom/wisdom';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = const Color(0xFF4F46E5);
    final isDesktop = WBreak.isDesktop(context);

    final chapters = [
      {
        'title': 'The First Principle',
        'quote': 'Rule neither by force nor by fear, but by the quiet gravity of consistent truth.',
        'content': 'In Mazeasta, the foundation of all interaction is the unshakeable commitment to truth. When ambiguity clouds the room, the one who anchors themselves in observable reality becomes the silent leader. This is not about winning arguments; it is about providing a lighthouse when the fog rolls in.',
      },
      {
        'title': 'Reflective Pauses',
        'quote': 'A decision made in haste is a debt borrowed against the future.',
        'content': 'Before acting on any new input, introduce a deliberate pause. This micro-gap between stimulus and response is where wisdom is born. It allows you to consult the rule-set, align with your long-term vision, and respond with intention rather than react with emotion.',
      },
      {
        'title': 'Harmony in Conflict',
        'quote': 'Friction is not the enemy; unmanaged friction is.',
        'content': 'Conflict is the forge where better ideas are tempered. Approach disagreements not as battles to be won, but as puzzles to be solved collectively. Listen for the underlying need beneath the opposing argument, and build bridges that address the core rather than the symptom.',
      },
    ];

    return WebShell(
      currentRoute: routeName,
      child: Scaffold(
        backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
        body: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_rounded, color: primary),
                    onPressed: () => Get.back(),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Wisdom Chapters',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const Spacer(),
                  Obx(() => Text(
                    'Chapter ${controller.currentPage.value + 1} of ${chapters.length}',
                    style: TextStyle(
                      color: primary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  )),
                ],
              ),
            ),
            
            // Content Carousel
            Expanded(
              child: PageView.builder(
                controller: PageController(viewportFraction: isDesktop ? 0.6 : 0.85),
                onPageChanged: controller.setPage,
                itemCount: chapters.length,
                itemBuilder: (context, index) {
                  return Obx(() {
                    final double scale = controller.currentPage.value == index ? 1.0 : 0.9;
                    final double opacity = controller.currentPage.value == index ? 1.0 : 0.5;
                    return AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: opacity,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOutQuart,
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                        transform: Matrix4.identity()..scale(scale, scale),
                        transformAlignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isDark ? WColors.cardDark : Colors.white,
                          borderRadius: BorderRadius.circular(32),
                          boxShadow: [
                            BoxShadow(
                              color: primary.withValues(alpha: 0.15),
                              blurRadius: 30,
                              offset: const Offset(0, 15),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(48),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '0${index + 1}',
                                style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.w900,
                                  color: primary.withValues(alpha: 0.2),
                                  height: 1,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                chapters[index]['title']!,
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900,
                                  color: isDark ? Colors.white : Colors.black87,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              const SizedBox(height: 32),
                              Container(
                                padding: const EdgeInsets.only(left: 24),
                                decoration: BoxDecoration(
                                  border: Border(
                                    left: BorderSide(color: primary, width: 4),
                                  ),
                                ),
                                child: Text(
                                  '"${chapters[index]['quote']}"',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontStyle: FontStyle.italic,
                                    height: 1.5,
                                    color: primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 32),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Text(
                                    chapters[index]['content']!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      height: 1.8,
                                      color: isDark ? Colors.white70 : Colors.black87,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
