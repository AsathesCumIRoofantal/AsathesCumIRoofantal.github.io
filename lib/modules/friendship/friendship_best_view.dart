import 'package:air_app/modules/friendship/friendship_enhanced_view.dart';
import 'package:flutter/material.dart';

/// Minimalist design wrapper for Friendship module
/// Features: Clean typography, whitespace, essential elements only
class FriendshipBestView extends StatelessWidget {
  const FriendshipBestView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xff1a1a1a) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final accentColor = Colors.grey.shade400;

    return Scaffold(
      backgroundColor: bgColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 160,
            backgroundColor: bgColor,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: _MinimalistHeader(
                isDark: isDark,
                bgColor: bgColor,
                textColor: textColor,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                children: [
                  Text(
                    'Friendship',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w300,
                      color: textColor,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'The art of connection',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: isDark ? Colors.white60 : Colors.black54,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 48),
                  _MinimalistSection(
                    title: 'Overview',
                    content:
                        'Deep friendships are built on trust, authenticity, and mutual support. Explore what makes connections meaningful and how to nurture the bonds that matter most.',
                    isDark: isDark,
                  ),
                  const SizedBox(height: 48),
                  _MinimalistSection(
                    title: 'Pillars of Friendship',
                    isDark: isDark,
                    content: '',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _MinimalistPillar(
                          number: 1,
                          text: 'Trust',
                          description: 'The foundation of all strong bonds',
                          isDark: isDark,
                        ),
                        const SizedBox(height: 24),
                        _MinimalistPillar(
                          number: 2,
                          text: 'Presence',
                          description: 'Being fully there when it matters',
                          isDark: isDark,
                        ),
                        const SizedBox(height: 24),
                        _MinimalistPillar(
                          number: 3,
                          text: 'Authenticity',
                          description: 'Showing up as your true self',
                          isDark: isDark,
                        ),
                        const SizedBox(height: 24),
                        _MinimalistPillar(
                          number: 4,
                          text: 'Growth Together',
                          description: 'Evolving and supporting each other',
                          isDark: isDark,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),
                  _MinimalistSection(
                    title: 'A Thought',
                    isDark: isDark,
                    content: '',
                    child: Text(
                      '"Friendship is born at that moment when one person says to another: What! You too? I thought I was the only one."',
                      style: TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        height: 1.8,
                        color: textColor,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: isDark ? Colors.white10 : Colors.black10,
                    height: 1,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Original Content',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white60 : Colors.black54,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: const FriendshipEnhancedView()),
        ],
      ),
    );
  }
}

class _MinimalistHeader extends StatelessWidget {
  final bool isDark;
  final Color bgColor;
  final Color textColor;
  const _MinimalistHeader({
    required this.isDark,
    required this.bgColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(color: bgColor),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 50, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.people_outline_rounded, color: textColor, size: 32),
              const SizedBox(height: 12),
              Text(
                'Friendship'.toUpperCase(),
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 3,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Minimalist Approach',
                style: TextStyle(
                  color: isDark ? Colors.white60 : Colors.black54,
                  fontSize: 11,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MinimalistSection extends StatelessWidget {
  final String title;
  final String content;
  final Widget? child;
  final bool isDark;
  const _MinimalistSection({
    required this.title,
    required this.isDark,
    this.content = '',
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white : Colors.black87,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 16),
        if (content.isNotEmpty)
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              height: 1.8,
              color: isDark ? Colors.white70 : Colors.black54,
              fontWeight: FontWeight.w400,
            ),
          ),
        if (child != null) child!,
      ],
    );
  }
}

class _MinimalistPillar extends StatelessWidget {
  final int number;
  final String text;
  final String description;
  final bool isDark;
  const _MinimalistPillar({
    required this.number,
    required this.text,
    required this.description,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '0$number',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w300,
            color: isDark ? Colors.white30 : Colors.black12,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black87,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                description,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: isDark ? Colors.white60 : Colors.black54,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
