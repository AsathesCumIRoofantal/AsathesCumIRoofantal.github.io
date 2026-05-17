import 'package:air_app/modules/signup/signup_enhanced_view.dart';
import 'package:flutter/material.dart';

/// Neumorphic design wrapper for Signup module
/// Features: Soft shadows, embossed look, organic styling
class SignupBestView extends StatelessWidget {
  const SignupBestView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseBg = isDark ? const Color(0xffe0e5ec) : const Color(0xffe0e5ec);
    final shadowColor = isDark ? Colors.black45 : Colors.black12;

    return Scaffold(
      backgroundColor: baseBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 200,
            backgroundColor: baseBg,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: _NeumorphicHeader(
                baseBg: baseBg,
                shadowColor: shadowColor,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                children: [
                  _NeumorphicCard(
                    baseBg: baseBg,
                    shadowColor: shadowColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Begin Your Journey',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: isDark ? Colors.black87 : Colors.black87,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Create your account and unlock a world of meaningful connections, knowledge, and personal growth.',
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.6,
                            color: isDark ? Colors.black54 : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _NeumorphicCard(
                    baseBg: baseBg,
                    shadowColor: shadowColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Text(
                            'BENEFITS',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.5,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        ...[
                          ('Complete Profile', 'Tell us about yourself'),
                          ('Set Preferences', 'Customize your experience'),
                          ('Start Learning', 'Access exclusive content'),
                          ('Connect', 'Join our community'),
                        ].map(
                          (item) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _NeumorphicBullet(
                              title: item.$1,
                              subtitle: item.$2,
                              baseBg: baseBg,
                              shadowColor: shadowColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _NeumorphicCard(
                    baseBg: baseBg,
                    shadowColor: shadowColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Why Join?',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _ReasonItem(
                          icon: Icons.shield_rounded,
                          title: 'Privacy First',
                          description: 'Your data is secure and private',
                          baseBg: baseBg,
                        ),
                        const SizedBox(height: 12),
                        _ReasonItem(
                          icon: Icons.group_rounded,
                          title: 'Community',
                          description: 'Connect with like-minded individuals',
                          baseBg: baseBg,
                        ),
                        const SizedBox(height: 12),
                        _ReasonItem(
                          icon: Icons.trending_up_rounded,
                          title: 'Growth',
                          description:
                              'Develop yourself through guided content',
                          baseBg: baseBg,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: const SignupEnhancedView()),
        ],
      ),
    );
  }
}

class _NeumorphicHeader extends StatelessWidget {
  final Color baseBg;
  final Color shadowColor;
  const _NeumorphicHeader({required this.baseBg, required this.shadowColor});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(color: baseBg),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _NeumorphicButton(
                baseBg: baseBg,
                shadowColor: shadowColor,
                child: const Icon(
                  Icons.person_add_rounded,
                  color: Colors.blueGrey,
                  size: 28,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Create Account'.toUpperCase(),
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Neumorphic Design',
                style: TextStyle(
                  color: Colors.black54,
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

class _NeumorphicCard extends StatelessWidget {
  final Widget child;
  final Color baseBg;
  final Color shadowColor;
  const _NeumorphicCard({
    required this.child,
    required this.baseBg,
    required this.shadowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: baseBg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.8),
            offset: const Offset(-4, -4),
            blurRadius: 8,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: shadowColor,
            offset: const Offset(4, 4),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: child,
    );
  }
}

class _NeumorphicButton extends StatelessWidget {
  final Widget child;
  final Color baseBg;
  final Color shadowColor;
  const _NeumorphicButton({
    required this.child,
    required this.baseBg,
    required this.shadowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: baseBg,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.8),
            offset: const Offset(-4, -4),
            blurRadius: 8,
          ),
          BoxShadow(
            color: shadowColor,
            offset: const Offset(4, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: child,
    );
  }
}

class _NeumorphicBullet extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color baseBg;
  final Color shadowColor;
  const _NeumorphicBullet({
    required this.title,
    required this.subtitle,
    required this.baseBg,
    required this.shadowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: baseBg,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.white.withValues(alpha: 0.6),
                offset: const Offset(-2, -2),
                blurRadius: 4,
              ),
              BoxShadow(
                color: shadowColor,
                offset: const Offset(2, 2),
                blurRadius: 4,
              ),
            ],
          ),
          child: const Center(
            child: Icon(Icons.check_rounded, color: Colors.blue, size: 16),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ReasonItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color baseBg;
  const _ReasonItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.baseBg,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: baseBg,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withValues(alpha: 0.6),
                offset: const Offset(-3, -3),
                blurRadius: 6,
              ),
              BoxShadow(
                color: Colors.black12,
                offset: const Offset(3, 3),
                blurRadius: 6,
              ),
            ],
          ),
          child: Icon(icon, color: Colors.blue, size: 24),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
