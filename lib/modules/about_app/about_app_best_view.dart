import 'package:air_app/modules/about_app/about_app_view.dart';
import 'package:flutter/material.dart';

/// Neumorphic design wrapper for About App module
/// Features: Soft shadows, embossed look, app information
class AboutAppBestView extends StatelessWidget {
  const AboutAppBestView({super.key});

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
              background: _NeumorphicAboutHeader(
                baseBg: baseBg,
                shadowColor: shadowColor,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                children: [
                  _NeumorphicCard(
                    baseBg: baseBg,
                    shadowColor: shadowColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'About AIR App',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'AIR - All in Relationships - is a comprehensive platform designed to guide you through all dimensions of human connection, personal growth, and meaningful living.',
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.6,
                            color: Colors.black54,
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
                            'APP VISION',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.5,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        ...[
                          (
                            'Comprehensive',
                            'Cover all aspects of life and relationships',
                          ),
                          (
                            'Accessible',
                            'Knowledge available to everyone, everywhere',
                          ),
                          (
                            'Practical',
                            'Actionable insights you can apply today',
                          ),
                          ('Inspiring', 'Motivate positive change and growth'),
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
                          'Our Features',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _AppFeatureItem(
                          icon: Icons.menu_book_rounded,
                          title: 'Comprehensive Content',
                          description:
                              'Organized knowledge across all life domains',
                          baseBg: baseBg,
                        ),
                        const SizedBox(height: 12),
                        _AppFeatureItem(
                          icon: Icons.sentiment_very_satisfied_rounded,
                          title: 'Personal Development',
                          description:
                              'Guided growth through value-based learning',
                          baseBg: baseBg,
                        ),
                        const SizedBox(height: 12),
                        _AppFeatureItem(
                          icon: Icons.groups_rounded,
                          title: 'Community Connection',
                          description:
                              'Share and learn with like-minded people',
                          baseBg: baseBg,
                        ),
                        const SizedBox(height: 12),
                        _AppFeatureItem(
                          icon: Icons.lightbulb_outline_rounded,
                          title: 'Practical Wisdom',
                          description:
                              'Ancient wisdom meets modern application',
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
          SliverToBoxAdapter(child: const AboutAppView()),
        ],
      ),
    );
  }
}

class _NeumorphicAboutHeader extends StatelessWidget {
  final Color baseBg;
  final Color shadowColor;
  const _NeumorphicAboutHeader({
    required this.baseBg,
    required this.shadowColor,
  });

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
                  Icons.info_rounded,
                  color: Colors.blueGrey,
                  size: 28,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'About App'.toUpperCase(),
                style: TextStyle(
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

class _AppFeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color baseBg;
  const _AppFeatureItem({
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
