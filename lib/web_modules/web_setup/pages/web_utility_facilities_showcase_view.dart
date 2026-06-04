import 'package:air_app/web_modules/_shared/web_shell.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/web_modules/_shared/web_nav_data.dart';

class UtilityFacilities extends StatelessWidget {
  const UtilityFacilities({super.key});

  static const String routeName = WebNavData.setup_utilityFacilities;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return WebShell(
      currentRoute: routeName,
      child: Scaffold(
        backgroundColor: const Color(0xFF0B1020),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 280,
              pinned: true,
              backgroundColor: const Color(0xFF111827),
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Utility & Facilities'),
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF4F46E5), Color(0xFF0F172A)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -40,
                        top: 40,
                        child: Container(
                          height: 220,
                          width: 220,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(200),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(28),
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
                                color: Colors.white.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: const Text(
                                'Flutter Web Showcase',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Infrastructure monitor',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 34,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Facility maps, animated utilities, metrics overview.',
                              style: TextStyle(
                                color: Color(0xFFD1D5DB),
                                fontSize: 15,
                                height: 1.4,
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

            SliverPadding(
              padding: const EdgeInsets.all(24),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final features = [
                    'Sliver animation systems',
                    'Responsive Flutter web layout',
                    'Interactive motion cards',
                    'Realtime dashboard visuals',
                    'Adaptive desktop + mobile experience',
                    'Modern AIR design language',
                  ];

                  return TweenAnimationBuilder(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: Duration(milliseconds: 400 + (index * 120)),
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0, 40 * (1 - value)),
                        child: Opacity(opacity: value, child: child),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.10),
                            Colors.white.withOpacity(0.03),
                          ],
                        ),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.08),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white.withOpacity(0.08),
                            child: Text('${index + 1}'),
                          ),
                          const Spacer(),
                          Text(
                            features[index % features.length],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'This section demonstrates how Flutter can build immersive web experiences with animation, slivers, responsive UI and modern UX patterns.',
                            style: TextStyle(
                              color: Color(0xFFCBD5E1),
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }, childCount: 6),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isMobile ? 1 : 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: isMobile ? 1.1 : 1.3,
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Container(
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: Colors.white.withOpacity(0.04),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Flutter Showcase Power',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Flutter excels at animated dashboards, cinematic layouts, responsive interfaces, hero transitions, glassmorphism, custom painters, adaptive grids, parallax scrolling and immersive storytelling experiences across desktop and web.',
                        style: TextStyle(
                          color: Color(0xFFD1D5DB),
                          height: 1.6,
                          fontSize: 16,
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
