import 'package:air_app/modules/affection_love/affection_love_view.dart';
import 'package:flutter/material.dart';

/// Modal Focus design wrapper for Affection & Love module
/// Features: Centered focus, modal overlays, intimate presentation
class AffectionLoveBestView extends StatefulWidget {
  const AffectionLoveBestView({super.key});

  @override
  State<AffectionLoveBestView> createState() => _AffectionLoveBestViewState();
}

class _AffectionLoveBestViewState extends State<AffectionLoveBestView>
    with TickerProviderStateMixin {
  late AnimationController _focusController;
  int _selectedFocus = 0;

  @override
  void initState() {
    super.initState();
    _focusController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _focusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const loveColor = Color(0xffff1744);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xff1a1a1a) : Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 180,
                backgroundColor: isDark
                    ? const Color(0xff1a1a1a)
                    : Colors.white,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  background: _ModalHeader(isDark: isDark),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 24,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Affection & Love',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: loveColor,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'The deepest expression of human connection',
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark ? Colors.white60 : Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 28),
                      ...[
                        (
                          'Romantic Love',
                          'The passionate bond between partners',
                          Icons.favorite_rounded,
                        ),
                        (
                          'Family Love',
                          'The unconditional care we share with family',
                          Icons.family_restroom_rounded,
                        ),
                        (
                          'Self-Love',
                          'Compassion and acceptance of oneself',
                          Icons.self_improvement_rounded,
                        ),
                        (
                          'Universal Love',
                          'Compassion extended to all beings',
                          Icons.public_rounded,
                        ),
                      ].asMap().entries.map((entry) {
                        int idx = entry.key;
                        var data = entry.value;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _ModalFocusCard(
                            title: data.$1,
                            description: data.$2,
                            icon: data.$3,
                            isSelected: _selectedFocus == idx,
                            onTap: () => setState(() {
                              _selectedFocus = idx;
                              _focusController.forward(from: 0);
                            }),
                            isDark: isDark,
                          ),
                        );
                      }),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      Container(width: 4, height: 22, color: loveColor),
                      const SizedBox(width: 10),
                      Text(
                        'ORIGINAL CONTENT',
                        style: TextStyle(
                          letterSpacing: 2,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: isDark ? Colors.white60 : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(child: const AffectionLoveView()),
            ],
          ),
          // Modal Overlay for selected item
          if (_selectedFocus >= 0)
            _ModalOverlay(
              selectedIndex: _selectedFocus,
              animationController: _focusController,
              isDark: isDark,
            ),
        ],
      ),
    );
  }
}

class _ModalHeader extends StatelessWidget {
  final bool isDark;
  const _ModalHeader({required this.isDark});

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
                const Color(0xffff1744).withValues(alpha: 0.08),
                const Color(0xfff50057).withValues(alpha: 0.05),
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
                  color: const Color(0xffff1744).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xffff1744).withValues(alpha: 0.3),
                  ),
                ),
                child: const Icon(
                  Icons.favorite_rounded,
                  color: Color(0xffff1744),
                  size: 28,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Love'.toUpperCase(),
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black87,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Modal Focus Design',
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

class _ModalFocusCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDark;
  const _ModalFocusCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xffff1744).withValues(alpha: 0.15)
              : (isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : Colors.grey.shade50),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? const Color(0xffff1744).withValues(alpha: 0.5)
                : (isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : Colors.black.withValues(alpha: 0.05)),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xffff1744).withValues(alpha: 0.2),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(
                  0xffff1744,
                ).withValues(alpha: isSelected ? 0.25 : 0.1),
              ),
              child: Icon(icon, color: const Color(0xffff1744), size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: isSelected
                          ? const Color(0xffff1744)
                          : (isDark ? Colors.white : Colors.black87),
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
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
            if (isSelected)
              const Icon(
                Icons.check_circle_rounded,
                color: Color(0xffff1744),
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}

class _ModalOverlay extends StatelessWidget {
  final int selectedIndex;
  final AnimationController animationController;
  final bool isDark;
  const _ModalOverlay({
    required this.selectedIndex,
    required this.animationController,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    const List<Map<String, dynamic>> focusPoints = [
      {
        'title': 'Romantic Love',
        'points': [
          'Built on trust and vulnerability',
          'Requires continuous effort and attention',
          'Grows through shared experiences',
          'Celebrates both passion and partnership',
        ],
      },
      {
        'title': 'Family Love',
        'points': [
          'Unconditional and enduring',
          'Roots us in belonging',
          'Shapes our identity and values',
          'Provides lifelong support',
        ],
      },
      {
        'title': 'Self-Love',
        'points': [
          'Foundation for all relationships',
          'Acceptance of strengths and flaws',
          'Setting healthy boundaries',
          'Investing in your own growth',
        ],
      },
      {
        'title': 'Universal Love',
        'points': [
          'Compassion without conditions',
          'Service to others',
          'Recognition of shared humanity',
          'Creating positive change',
        ],
      },
    ];

    final data = focusPoints[selectedIndex];

    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Transform.translate(
            offset: Offset(0, 200 * (1 - animationController.value)),
            child: Opacity(
              opacity: animationController.value,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey.shade900 : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xffff1744).withValues(alpha: 0.3),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 24,
                        offset: const Offset(0, -8),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['title'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xffff1744),
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...((data['points'] as List<String>).map(
                        (point) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 4),
                                child: Icon(
                                  Icons.favorite_rounded,
                                  color: Color(0xffff1744),
                                  size: 14,
                                ),
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
                      )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
