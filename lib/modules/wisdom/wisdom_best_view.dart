import 'package:air_app/modules/wisdom/wisdom_enhanced_view.dart';
import 'package:flutter/material.dart';

/// Minimalist design wrapper for Wisdom module
/// Features: Clean typography, whitespace, philosophical emphasis
class WisdomBestView extends StatelessWidget {
  const WisdomBestView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xff1a1a1a) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;

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
              background: _MinimalistWisdomHeader(
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
                    'Wisdom',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w300,
                      color: textColor,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'The integration of knowledge and experience',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: isDark ? Colors.white60 : Colors.black54,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 48),
                  _MinimalistWisdomSection(
                    title: 'What is Wisdom?',
                    content:
                        'Wisdom transcends knowledge. It is the ability to discern truth, understand context, and make sound judgments that consider consequences—both immediate and long-term.',
                    isDark: isDark,
                  ),
                  const SizedBox(height: 48),
                  _MinimalistWisdomSection(
                    title: 'The Journey',
                    isDark: isDark,
                    content: '',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _MinimalistWisdomStep(
                          phase: 'Learning',
                          text:
                              'Acquire knowledge through experience and study',
                          isDark: isDark,
                        ),
                        const SizedBox(height: 28),
                        _MinimalistWisdomStep(
                          phase: 'Reflection',
                          text: 'Examine experiences and extract meaning',
                          isDark: isDark,
                        ),
                        const SizedBox(height: 28),
                        _MinimalistWisdomStep(
                          phase: 'Integration',
                          text: 'Synthesize knowledge into living principles',
                          isDark: isDark,
                        ),
                        const SizedBox(height: 28),
                        _MinimalistWisdomStep(
                          phase: 'Application',
                          text: 'Act with discernment and purpose',
                          isDark: isDark,
                        ),
                        const SizedBox(height: 28),
                        _MinimalistWisdomStep(
                          phase: 'Transmission',
                          text: 'Share wisdom with the next generation',
                          isDark: isDark,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),
                  _MinimalistWisdomSection(
                    title: 'Wisdom in Practice',
                    isDark: isDark,
                    content: '',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _MinimalistWisdomPractice(
                          title: 'Seek Understanding',
                          isDark: isDark,
                        ),
                        const SizedBox(height: 16),
                        _MinimalistWisdomPractice(
                          title: 'Listen More Than You Speak',
                          isDark: isDark,
                        ),
                        const SizedBox(height: 16),
                        _MinimalistWisdomPractice(
                          title: 'Question Your Assumptions',
                          isDark: isDark,
                        ),
                        const SizedBox(height: 16),
                        _MinimalistWisdomPractice(
                          title: 'Consider Long-Term Consequences',
                          isDark: isDark,
                        ),
                        const SizedBox(height: 16),
                        _MinimalistWisdomPractice(
                          title: 'Embrace Humility',
                          isDark: isDark,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),
                  _MinimalistWisdomSection(
                    title: 'A Contemplation',
                    isDark: isDark,
                    content: '',
                    child: Text(
                      '"The beginning of wisdom is the definition of terms." — Socrates',
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
                    color: isDark ? Colors.white10 : Colors.black12,
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
          SliverToBoxAdapter(child: const WisdomEnhancedView()),
        ],
      ),
    );
  }
}

class _MinimalistWisdomHeader extends StatelessWidget {
  final bool isDark;
  final Color bgColor;
  final Color textColor;
  const _MinimalistWisdomHeader({
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
              Icon(Icons.auto_awesome_outlined, color: textColor, size: 32),
              const SizedBox(height: 12),
              Text(
                'Wisdom'.toUpperCase(),
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

class _MinimalistWisdomSection extends StatelessWidget {
  final String title;
  final String content;
  final Widget? child;
  final bool isDark;
  const _MinimalistWisdomSection({
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

class _MinimalistWisdomStep extends StatelessWidget {
  final String phase;
  final String text;
  final bool isDark;
  const _MinimalistWisdomStep({
    required this.phase,
    required this.text,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          phase,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white60 : Colors.black54,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          text,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: isDark ? Colors.white : Colors.black87,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}

class _MinimalistWisdomPractice extends StatelessWidget {
  final String title;
  final bool isDark;
  const _MinimalistWisdomPractice({required this.title, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '—',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w300,
            color: isDark ? Colors.white30 : Colors.black12,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: isDark ? Colors.white70 : Colors.black54,
            ),
          ),
        ),
      ],
    );
  }
}
