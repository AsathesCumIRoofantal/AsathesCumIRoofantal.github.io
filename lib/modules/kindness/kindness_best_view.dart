import 'package:air_app/modules/kindness/kindness_enhanced_view.dart';
import 'package:flutter/material.dart';

/// Card Cascade design wrapper for Kindness module
/// Features: Layered card system, cascade animations, compassionate aesthetics
class KindnessBestView extends StatefulWidget {
  const KindnessBestView({super.key});

  @override
  State<KindnessBestView> createState() => _KindnessBestViewState();
}

class _KindnessBestViewState extends State<KindnessBestView>
    with TickerProviderStateMixin {
  late AnimationController _cascadeController;

  @override
  void initState() {
    super.initState();
    _cascadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _cascadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const heartColor = Color(0xffe84855);
    const warmBg = Color(0xfffff5f5);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xff2a2a2a) : warmBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 180,
            backgroundColor: isDark ? const Color(0xff2a2a2a) : warmBg,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: _CascadeHeader(isDark: isDark),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                children: [
                  _CascadeCard(
                    animation: _cascadeController,
                    delay: 0.0,
                    isDark: isDark,
                    color: heartColor.withValues(alpha: 0.1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: heartColor.withValues(alpha: 0.15),
                              ),
                              child: const Icon(
                                Icons.favorite_rounded,
                                color: heartColor,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'The Gift of Kindness',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: isDark
                                          ? Colors.white
                                          : Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Small acts, lasting impact',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isDark
                                          ? Colors.white60
                                          : Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Kindness is not just about what we do—it\'s about the intention and compassion we bring to every interaction.',
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.6,
                            color: isDark ? Colors.white70 : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _CascadeCard(
                    animation: _cascadeController,
                    delay: 0.15,
                    isDark: isDark,
                    color: Colors.orange.withValues(alpha: 0.1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ways to Practice Kindness',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ...[
                          (
                            'Listen Deeply',
                            'Give someone your full attention',
                            Icons.hearing_rounded,
                          ),
                          (
                            'Share Generously',
                            'Give without expecting return',
                            Icons.card_giftcard_rounded,
                          ),
                          (
                            'Smile Often',
                            'A smile can brighten someone\'s day',
                            Icons.sentiment_satisfied_rounded,
                          ),
                          (
                            'Help Without Asking',
                            'Anticipate needs and act',
                            Icons.volunteer_activism_rounded,
                          ),
                        ].map(
                          (item) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _KindnessAction(
                              title: item.$1,
                              description: item.$2,
                              icon: item.$3,
                              isDark: isDark,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _CascadeCard(
                    animation: _cascadeController,
                    delay: 0.30,
                    isDark: isDark,
                    color: Colors.green.withValues(alpha: 0.1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kindness Ripple',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.white.withValues(alpha: 0.05)
                                : Colors.white.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: heartColor.withValues(alpha: 0.2),
                            ),
                          ),
                          child: Text(
                            'One act of kindness creates a ripple effect. When you show kindness, others are inspired to do the same, creating a cascade of compassion.',
                            style: TextStyle(
                              fontSize: 13,
                              height: 1.7,
                              fontStyle: FontStyle.italic,
                              color: isDark ? Colors.white70 : Colors.black54,
                            ),
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
          SliverToBoxAdapter(child: const KindnessEnhancedView()),
        ],
      ),
    );
  }
}

class _CascadeHeader extends StatelessWidget {
  final bool isDark;
  const _CascadeHeader({required this.isDark});

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
                const Color(0xffe84855).withValues(alpha: 0.1),
                Colors.orange.withValues(alpha: 0.08),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xffe84855).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xffe84855).withValues(alpha: 0.3),
                  ),
                ),
                child: const Icon(
                  Icons.favorite_rounded,
                  color: Color(0xffe84855),
                  size: 28,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Kindness'.toUpperCase(),
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black87,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Card Cascade Design',
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

class _CascadeCard extends StatelessWidget {
  final Widget child;
  final AnimationController animation;
  final double delay;
  final bool isDark;
  final Color color;
  const _CascadeCard({
    required this.child,
    required this.animation,
    required this.delay,
    required this.isDark,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final delayedAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animation,
        curve: Interval(delay, delay + 0.3, curve: Curves.easeOut),
      ),
    );

    return AnimatedBuilder(
      animation: delayedAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - delayedAnimation.value)),
          child: Opacity(
            opacity: delayedAnimation.value,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? Colors.white.withValues(alpha: 0.08) : color,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : Colors.black.withValues(alpha: 0.05),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
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
      child: child,
    );
  }
}

class _KindnessAction extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isDark;
  const _KindnessAction({
    required this.title,
    required this.description,
    required this.icon,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.orange.withValues(alpha: 0.15),
          ),
          child: Icon(icon, color: Colors.orange, size: 20),
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
                ),
              ),
              const SizedBox(height: 2),
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
