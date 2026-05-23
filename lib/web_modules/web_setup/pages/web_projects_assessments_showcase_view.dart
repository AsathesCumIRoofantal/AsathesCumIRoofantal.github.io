import 'package:air_app/web_modules/_shared/web_shell.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebProjectsAssessmentsShowcaseView extends StatelessWidget {
  const WebProjectsAssessmentsShowcaseView({super.key});

  static const routeName = '/web-setup/projects-assessments-showcase';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return WebShell(
      currentRoute: routeName,
      child: Scaffold(
        backgroundColor: isDark
            ? const Color(0xFF08111F)
            : const Color(0xFFF5F7FB),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 550,
              pinned: true,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'Projects & Assessments',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF5B8CFF),
                            Color(0xFF6E44FF),
                            Color(0xFF00C2A8),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 60,
                      right: -40,
                      child: Container(
                        width: 220,
                        height: 220,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(200),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 24,
                      bottom: 60,
                      child: SizedBox(
                        width: 520,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Text(
                                'Flutter 2026 Experience Layer',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 18),
                            const Text(
                              'Execution metrics, project intelligence and performance scoring.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Wrap(
                              spacing: 14,
                              runSpacing: 14,
                              children: List.generate(
                                4,
                                (index) => AnimatedContainer(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeOutCubic,
                                  padding: const EdgeInsets.all(18),
                                  width: 140,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(24),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.1),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.auto_awesome,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        'Module $index',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      const Text(
                                        'Motion driven micro interactions',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(24),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final width = constraints.maxWidth;

                      int columns = 1;

                      if (width > 1600) {
                        columns = 4;
                      } else if (width > 1200) {
                        columns = 3;
                      } else if (width > 700) {
                        columns = 2;
                      }

                      final cardWidth =
                          (width - ((columns - 1) * 24)) / columns;

                      return Wrap(
                        spacing: 24,
                        runSpacing: 24,
                        children: List.generate(8, (index) {
                          return TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0, end: 1),
                            duration: Duration(
                              milliseconds: 500 + (index * 80),
                            ),
                            curve: Curves.easeOutCubic,

                            builder: (context, value, child) {
                              return Transform.translate(
                                offset: Offset(0, 40 * (1 - value)),
                                child: Opacity(opacity: value, child: child),
                              );
                            },

                            child: SizedBox(
                              width: cardWidth,

                              child: Container(
                                padding: const EdgeInsets.all(22),

                                decoration: BoxDecoration(
                                  color: isDark
                                      ? const Color(0xFF111C2D)
                                      : Colors.white,

                                  borderRadius: BorderRadius.circular(30),

                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 30,
                                      offset: const Offset(0, 12),
                                      color: Colors.black.withOpacity(0.06),
                                    ),
                                  ],
                                ),

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  mainAxisSize: MainAxisSize.min,

                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 26,

                                          backgroundColor: const Color(
                                            0xFF5B8CFF,
                                          ).withOpacity(0.15),

                                          child: const Icon(
                                            Icons.bolt,
                                            color: Color(0xFF5B8CFF),
                                          ),
                                        ),

                                        const Spacer(),

                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),

                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),

                                            color: Colors.green.withOpacity(
                                              0.12,
                                            ),
                                          ),

                                          child: const Text(
                                            'Realtime',

                                            style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 24),

                                    Text(
                                      'Feature Experience #$index',

                                      style: TextStyle(
                                        color: isDark
                                            ? Colors.white
                                            : Colors.black87,

                                        fontSize: 22,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                    Text(
                                      'Flutter enables high-performance sliver layouts, animated dashboards, adaptive web rendering, glassmorphism, AI-ready experiences and silky desktop responsiveness.',

                                      style: TextStyle(
                                        color: isDark
                                            ? Colors.white70
                                            : Colors.black54,

                                        height: 1.6,
                                      ),
                                    ),

                                    const SizedBox(height: 24),

                                    LinearProgressIndicator(
                                      value: (index + 1) / 10,
                                      borderRadius: BorderRadius.circular(20),
                                      minHeight: 10,
                                    ),

                                    const SizedBox(height: 16),

                                    Wrap(
                                      spacing: 10,
                                      runSpacing: 10,

                                      children: const [
                                        Chip(label: Text('Slivers')),
                                        Chip(label: Text('Animations')),
                                        Chip(label: Text('Responsive')),
                                        Chip(label: Text('GetX')),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      );
                    },
                  ),
                ]),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 60),
                child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(34),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF0F172A), Color(0xFF172554)],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Why Flutter 2026?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        'Single codebase delivery across mobile, web, desktop and embedded surfaces. GPU accelerated rendering, AI workflow integration, advanced animation orchestration and premium UI pipelines make Flutter ideal for futuristic AIR experiences.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          height: 1.7,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        children: List.generate(
                          3,
                          (index) => Container(
                            width: 260,
                            padding: const EdgeInsets.all(22),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.06),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.animation,
                                  color: Colors.white,
                                  size: 32,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'Adaptive Motion System',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Dynamic transitions and responsive interaction layers for modern web storytelling.',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
