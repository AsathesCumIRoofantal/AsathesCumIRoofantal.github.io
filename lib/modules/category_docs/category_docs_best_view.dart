import 'package:air_app/modules/category_docs/category_docs_view.dart';
import 'package:flutter/material.dart';

/// Dark Neon design wrapper for Category Docs module
/// Features: Dark background, neon accents, document-focused presentation
class CategoryDocsBestView extends StatefulWidget {
  const CategoryDocsBestView({super.key});

  @override
  State<CategoryDocsBestView> createState() => _CategoryDocsBestViewState();
}

class _CategoryDocsBestViewState extends State<CategoryDocsBestView>
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
    const neonBlue = Color(0xff00d4ff);
    const neonGreen = Color(0xff00ff88);
    const darkBg = Color(0xff0a0e27);

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
              background: _NeonDocsHeader(
                glowController: _glowController,
                neonBlue: neonBlue,
                neonGreen: neonGreen,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                children: [
                  _NeonDocsCard(
                    neonColor: neonBlue,
                    glowController: _glowController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Knowledge Repository',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: neonBlue,
                            letterSpacing: 2,
                            shadows: [
                              Shadow(
                                color: neonBlue.withValues(alpha: 0.6),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Comprehensive documentation and resources organized by category. Find the information you need quickly and easily.',
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
                  _NeonDocsCard(
                    neonColor: neonGreen,
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
                                color: neonGreen,
                                borderRadius: BorderRadius.circular(2),
                                boxShadow: [
                                  BoxShadow(
                                    color: neonGreen.withValues(alpha: 0.8),
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'DOCUMENTATION CATEGORIES',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.5,
                                color: neonGreen,
                                shadows: [
                                  Shadow(
                                    color: neonGreen.withValues(alpha: 0.5),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ...[
                          ('Guides', 'Step-by-step instructions and tutorials'),
                          (
                            'References',
                            'Complete API and feature documentation',
                          ),
                          (
                            'Best Practices',
                            'Industry standards and recommendations',
                          ),
                          ('FAQ', 'Answers to frequently asked questions'),
                          ('Resources', 'Tools, templates, and downloads'),
                        ].map(
                          (item) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _NeonDocCategory(
                              title: item.$1,
                              description: item.$2,
                              neonColor: neonBlue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _NeonDocsCard(
                    neonColor: neonBlue,
                    glowController: _glowController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Browse by Type',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: neonBlue,
                            shadows: [
                              Shadow(
                                color: neonBlue.withValues(alpha: 0.5),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        ...[
                          (
                            'Video Tutorials',
                            '📹',
                            'Learn visually from experts',
                          ),
                          (
                            'Written Guides',
                            '📖',
                            'Detailed written documentation',
                          ),
                          ('Code Examples', '💻', 'Real-world code samples'),
                          ('Interactive Demo', '🎮', 'Try features in sandbox'),
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
                                          color: neonBlue,
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
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: const CategoryDocsView()),
        ],
      ),
    );
  }
}

class _NeonDocsHeader extends StatelessWidget {
  final AnimationController glowController;
  final Color neonBlue;
  final Color neonGreen;
  const _NeonDocsHeader({
    required this.glowController,
    required this.neonBlue,
    required this.neonGreen,
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
                const Color(0xff1a1f3a),
                const Color(0xff0a0e27),
                neonGreen.withValues(alpha: 0.1),
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
                      color: neonBlue.withValues(
                        alpha: 0.1 + (0.15 * glowController.value),
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: neonBlue.withValues(
                          alpha: 0.4 + (0.3 * glowController.value),
                        ),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: neonBlue.withValues(
                            alpha: 0.3 * glowController.value,
                          ),
                          blurRadius: 12 + (8 * glowController.value),
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.library_books_rounded,
                      color: Color(0xff00d4ff),
                      size: 28,
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              Text(
                'Category Docs'.toUpperCase(),
                style: TextStyle(
                  color: neonBlue,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 3,
                  shadows: [
                    Shadow(
                      color: neonBlue.withValues(alpha: 0.6),
                      blurRadius: 12,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Dark Neon Design',
                style: TextStyle(
                  color: neonGreen.withValues(alpha: 0.8),
                  fontSize: 12,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w500,
                  shadows: [
                    Shadow(
                      color: neonGreen.withValues(alpha: 0.4),
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

class _NeonDocsCard extends StatelessWidget {
  final Widget child;
  final Color neonColor;
  final AnimationController glowController;
  const _NeonDocsCard({
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

class _NeonDocCategory extends StatelessWidget {
  final String title;
  final String description;
  final Color neonColor;
  const _NeonDocCategory({
    required this.title,
    required this.description,
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
                description,
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
