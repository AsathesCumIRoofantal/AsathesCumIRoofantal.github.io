import 'package:air_app/modules/learn_fun/learn_fun_enhanced_view.dart';
import 'package:flutter/material.dart';

/// Dark Neon design wrapper for Learn Fun module
/// Features: Dark background, neon accents, cyberpunk aesthetics, glowing effects
class LearnFunBestView extends StatefulWidget {
  const LearnFunBestView({super.key});

  @override
  State<LearnFunBestView> createState() => _LearnFunBestViewState();
}

class _LearnFunBestViewState extends State<LearnFunBestView>
    with SingleTickerProviderStateMixin {
  late AnimationController _glowController;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const neonCyan = Color(0xff00ff88);
    const neonPurple = Color(0xffff00ff);
    const darkBg = Color(0xff0a0e27);
    const darkBg2 = Color(0xff1a1f3a);

    return Scaffold(
      backgroundColor: darkBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 220,
            backgroundColor: darkBg,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: _NeonHeader(
                glowController: _glowController,
                neonCyan: neonCyan,
                neonPurple: neonPurple,
                darkBg2: darkBg2,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                children: [
                  _NeonCard(
                    neonColor: neonCyan,
                    glowController: _glowController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Enter the Fun Zone',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: neonCyan,
                            letterSpacing: 2,
                            shadows: [
                              Shadow(
                                color: neonCyan.withValues(alpha: 0.6),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Explore learning through interactive games, challenges, and engaging content designed to make education fun and memorable.',
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.6,
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _NeonCard(
                    neonColor: neonPurple,
                    glowController: _glowController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 4,
                              height: 20,
                              decoration: BoxDecoration(
                                color: neonPurple,
                                borderRadius: BorderRadius.circular(2),
                                boxShadow: [
                                  BoxShadow(
                                    color: neonPurple.withValues(alpha: 0.8),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'NEON FEATURES',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.5,
                                color: neonPurple,
                                shadows: [
                                  Shadow(
                                    color: neonPurple.withValues(alpha: 0.5),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ...[
                          (
                            'Interactive Quizzes',
                            'Test and expand your knowledge',
                          ),
                          (
                            'Achievement Badges',
                            'Unlock rewards as you progress',
                          ),
                          ('Leaderboards', 'Compete in a fun environment'),
                          (
                            'Daily Challenges',
                            'Fresh content every single day',
                          ),
                        ].map(
                          (item) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _NeonFeatureItem(
                              title: item.$1,
                              subtitle: item.$2,
                              neonColor: neonCyan,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _NeonCard(
                    neonColor: neonCyan,
                    glowController: _glowController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Game Modes',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: neonCyan,
                            shadows: [
                              Shadow(
                                color: neonCyan.withValues(alpha: 0.5),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        ...[
                          ('Solo Quest', '🎮', 'Learn at your own pace'),
                          ('Group Battle', '👥', 'Team up with others'),
                          ('Time Attack', '⏱️', 'Race against the clock'),
                          ('Survival Mode', '🛡️', 'Endless challenges'),
                        ].map(
                          (item) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Text(
                                  item.$2,
                                  style: const TextStyle(fontSize: 20),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.$1,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: neonCyan,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        item.$3,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white.withValues(
                                            alpha: 0.6,
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 20,
                        decoration: BoxDecoration(
                          color: neonCyan,
                          borderRadius: BorderRadius.circular(2),
                          boxShadow: [
                            BoxShadow(
                              color: neonCyan.withValues(alpha: 0.8),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'ORIGINAL CONTENT',
                        style: TextStyle(
                          letterSpacing: 2,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: const LearnFunEnhancedView()),
        ],
      ),
    );
  }
}

class _NeonHeader extends StatelessWidget {
  final AnimationController glowController;
  final Color neonCyan;
  final Color neonPurple;
  final Color darkBg2;
  const _NeonHeader({
    required this.glowController,
    required this.neonCyan,
    required this.neonPurple,
    required this.darkBg2,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                darkBg2,
                darkBg2.withValues(alpha: 0.8),
                neonPurple.withValues(alpha: 0.15),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AnimatedBuilder(
                animation: glowController,
                builder: (context, child) {
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: neonCyan.withValues(
                        alpha: 0.1 + (0.15 * glowController.value),
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: neonCyan.withValues(
                          alpha: 0.4 + (0.3 * glowController.value),
                        ),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: neonCyan.withValues(
                            alpha: 0.3 * glowController.value,
                          ),
                          blurRadius: 12 + (8 * glowController.value),
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.sports_esports_rounded,
                      color: neonCyan,
                      size: 28,
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              Text(
                'Learn Fun'.toUpperCase(),
                style: TextStyle(
                  color: neonCyan,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 3,
                  shadows: [
                    Shadow(
                      color: neonCyan.withValues(alpha: 0.6),
                      blurRadius: 12,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Dark Neon Design',
                style: TextStyle(
                  color: neonPurple.withValues(alpha: 0.8),
                  fontSize: 12,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w500,
                  shadows: [
                    Shadow(
                      color: neonPurple.withValues(alpha: 0.4),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _NeonCard extends StatelessWidget {
  final Widget child;
  final Color neonColor;
  final AnimationController glowController;
  const _NeonCard({
    required this.child,
    required this.neonColor,
    required this.glowController,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: glowController,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: neonColor.withValues(
                alpha: 0.3 + (0.2 * glowController.value),
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: neonColor.withValues(alpha: 0.15 * glowController.value),
                blurRadius: 12,
                spreadRadius: 1,
              ),
            ],
          ),
          child: child,
        );
      },
    );
  }
}

class _NeonFeatureItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color neonColor;
  const _NeonFeatureItem({
    required this.title,
    required this.subtitle,
    required this.neonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: neonColor, width: 2),
            boxShadow: [
              BoxShadow(color: neonColor.withValues(alpha: 0.5), blurRadius: 6),
            ],
          ),
          child: Center(
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: neonColor,
                boxShadow: [
                  BoxShadow(
                    color: neonColor.withValues(alpha: 0.8),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: neonColor,
                  fontSize: 14,
                  shadows: [
                    Shadow(
                      color: neonColor.withValues(alpha: 0.4),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
