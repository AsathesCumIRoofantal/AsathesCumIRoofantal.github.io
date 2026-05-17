import 'package:air_app/modules/respect/respect_enhanced_view.dart';
import 'package:flutter/material.dart';

/// Animated Hero design wrapper for Respect module
/// Features: Hero animations, dynamic transitions, emphasis on dignity
class RespectBestView extends StatefulWidget {
  const RespectBestView({super.key});

  @override
  State<RespectBestView> createState() => _RespectBestViewState();
}

class _RespectBestViewState extends State<RespectBestView>
    with SingleTickerProviderStateMixin {
  late AnimationController _heroController;

  @override
  void initState() {
    super.initState();
    _heroController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _heroController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const respectColor = Color(0xff2c5aa0);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xff1a1a1a) : Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 220,
            backgroundColor: isDark ? const Color(0xff1a1a1a) : Colors.white,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: _HeroHeader(
                heroController: _heroController,
                isDark: isDark,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                children: [
                  _HeroCard(
                    heroController: _heroController,
                    delay: 0.0,
                    isDark: isDark,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'The Foundation of Dignity',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: respectColor,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Respect is the cornerstone of all healthy relationships. It\'s about recognizing the inherent worth and dignity in every person.',
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.6,
                            color: isDark ? Colors.white70 : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _HeroCard(
                    heroController: _heroController,
                    delay: 0.3,
                    isDark: isDark,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Principles of Respect',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: respectColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ...[
                          (
                            'Listen Without Judgment',
                            'Hear others with an open mind',
                          ),
                          (
                            'Honor Differences',
                            'Celebrate what makes us unique',
                          ),
                          (
                            'Keep Boundaries',
                            'Respect personal space and limits',
                          ),
                          ('Value Their Time', 'Show up and be present'),
                          (
                            'Apologize Sincerely',
                            'Take responsibility when wrong',
                          ),
                        ].map(
                          (item) => Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: _RespectPrinciple(
                              title: item.$1,
                              description: item.$2,
                              isDark: isDark,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _HeroCard(
                    heroController: _heroController,
                    delay: 0.6,
                    isDark: isDark,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'In Daily Practice',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: respectColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: respectColor.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: respectColor.withValues(alpha: 0.2),
                            ),
                          ),
                          child: Column(
                            children: [
                              ...[
                                'Address people by their preferred names',
                                'Ask before giving advice',
                                'Follow through on commitments',
                                'Disagree respectfully',
                                'Celebrate others\' successes',
                              ].map(
                                (point) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 6,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle_rounded,
                                        color: respectColor,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          point,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: isDark
                                                ? Colors.white70
                                                : Colors.black54,
                                            height: 1.5,
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: const RespectEnhancedView()),
        ],
      ),
    );
  }
}

class _HeroHeader extends StatelessWidget {
  final AnimationController heroController;
  final bool isDark;
  const _HeroHeader({required this.heroController, required this.isDark});

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
                const Color(0xff2c5aa0).withValues(alpha: 0.1),
                const Color(0xff1e3a5f).withValues(alpha: 0.08),
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
                animation: heroController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: 1.0 + (0.05 * heroController.value),
                    child: Transform.rotate(
                      angle: 0.02 * heroController.value,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(
                            0xff2c5aa0,
                          ).withValues(alpha: 0.15),
                          border: Border.all(
                            color: const Color(
                              0xff2c5aa0,
                            ).withValues(alpha: 0.3),
                          ),
                        ),
                        child: const Icon(
                          Icons.handshake_rounded,
                          color: Color(0xff2c5aa0),
                          size: 28,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              Text(
                'Respect'.toUpperCase(),
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black87,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Animated Hero Design',
                style: TextStyle(
                  color: isDark ? Colors.white60 : Colors.black54,
                  fontSize: 12,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HeroCard extends StatelessWidget {
  final Widget child;
  final AnimationController heroController;
  final double delay;
  final bool isDark;
  const _HeroCard({
    required this.child,
    required this.heroController,
    required this.delay,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final delayedAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: heroController,
        curve: Interval(delay, delay + 0.3, curve: Curves.easeInOut),
      ),
    );

    return AnimatedBuilder(
      animation: delayedAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 10 * (1 - delayedAnimation.value)),
          child: Opacity(
            opacity: 0.5 + (0.5 * delayedAnimation.value),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xff2c5aa0).withValues(alpha: 0.15),
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(
                      0xff2c5aa0,
                    ).withValues(alpha: 0.1 * delayedAnimation.value),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: child,
            ),
          ),
        );
      },
    );
  }
}

class _RespectPrinciple extends StatelessWidget {
  final String title;
  final String description;
  final bool isDark;
  const _RespectPrinciple({
    required this.title,
    required this.description,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xff2c5aa0).withValues(alpha: 0.15),
            border: Border.all(
              color: const Color(0xff2c5aa0).withValues(alpha: 0.3),
              width: 1.5,
            ),
          ),
          child: const Center(
            child: Icon(Icons.star_rounded, color: Color(0xff2c5aa0), size: 14),
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
                  color: isDark ? Colors.white : Colors.black87,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? Colors.white60 : Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
