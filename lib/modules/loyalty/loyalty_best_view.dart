import 'package:air_app/modules/loyalty/loyalty_enhanced_view.dart';
import 'package:flutter/material.dart';

/// Expansion Tiles design wrapper for Loyalty module
/// Features: Collapsible sections, hierarchical information, exploration-friendly
class LoyaltyBestView extends StatefulWidget {
  const LoyaltyBestView({super.key});

  @override
  State<LoyaltyBestView> createState() => _LoyaltyBestViewState();
}

class _LoyaltyBestViewState extends State<LoyaltyBestView> {
  int _expandedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const loyaltyColor = Color(0xffd4a574);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xff1a1a1a) : Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 180,
            backgroundColor: isDark ? const Color(0xff1a1a1a) : Colors.white,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: _ExpansionHeader(isDark: isDark),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                children: [
                  Text(
                    'The Strength of Loyalty',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : Colors.black87,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Loyalty is steadfastness and commitment. Explore the different dimensions of this profound value.',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: isDark ? Colors.white70 : Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _LoyaltyExpansionTile(
                    title: 'Personal Loyalty',
                    icon: Icons.person_rounded,
                    description: 'Being true to yourself and your values',
                    isExpanded: _expandedIndex == 0,
                    onExpanded: () => setState(() => _expandedIndex = 0),
                    isDark: isDark,
                    items: [
                      'Honor your commitments to yourself',
                      'Stay true to your core values',
                      'Practice consistency in actions',
                      'Grow without losing your essence',
                    ],
                  ),
                  const SizedBox(height: 12),
                  _LoyaltyExpansionTile(
                    title: 'Relational Loyalty',
                    icon: Icons.handshake_rounded,
                    description: 'Commitment to those you care about',
                    isExpanded: _expandedIndex == 1,
                    onExpanded: () => setState(() => _expandedIndex = 1),
                    isDark: isDark,
                    items: [
                      'Show up for loved ones consistently',
                      'Support them through challenges',
                      'Celebrate their victories',
                      'Maintain trust and transparency',
                    ],
                  ),
                  const SizedBox(height: 12),
                  _LoyaltyExpansionTile(
                    title: 'Professional Loyalty',
                    icon: Icons.business_rounded,
                    description: 'Dedication to your work and team',
                    isExpanded: _expandedIndex == 2,
                    onExpanded: () => setState(() => _expandedIndex = 2),
                    isDark: isDark,
                    items: [
                      'Deliver quality work consistently',
                      'Contribute to team success',
                      'Build lasting professional relationships',
                      'Uphold organizational values',
                    ],
                  ),
                  const SizedBox(height: 12),
                  _LoyaltyExpansionTile(
                    title: 'Community Loyalty',
                    icon: Icons.public_rounded,
                    description: 'Service to the greater good',
                    isExpanded: _expandedIndex == 3,
                    onExpanded: () => setState(() => _expandedIndex = 3),
                    isDark: isDark,
                    items: [
                      'Contribute to your community',
                      'Support collective causes',
                      'Be a reliable community member',
                      'Work toward shared prosperity',
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  Container(width: 4, height: 22, color: loyaltyColor),
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
          SliverToBoxAdapter(child: const LoyaltyEnhancedView()),
        ],
      ),
    );
  }
}

class _ExpansionHeader extends StatelessWidget {
  final bool isDark;
  const _ExpansionHeader({required this.isDark});

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
                const Color(0xffd4a574).withValues(alpha: 0.1),
                Colors.orange.withValues(alpha: 0.06),
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
                  color: const Color(0xffd4a574).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xffd4a574).withValues(alpha: 0.3),
                  ),
                ),
                child: const Icon(
                  Icons.verified_rounded,
                  color: Color(0xffd4a574),
                  size: 28,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Loyalty'.toUpperCase(),
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black87,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Expansion Tiles Design',
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

class _LoyaltyExpansionTile extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final List<String> items;
  final bool isExpanded;
  final VoidCallback onExpanded;
  final bool isDark;
  const _LoyaltyExpansionTile({
    required this.title,
    required this.description,
    required this.icon,
    required this.items,
    required this.isExpanded,
    required this.onExpanded,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.08)
            : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.black.withValues(alpha: 0.05),
        ),
      ),
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onExpanded,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xffd4a574).withValues(alpha: 0.15),
                      ),
                      child: Icon(
                        icon,
                        color: const Color(0xffd4a574),
                        size: 20,
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
                              fontWeight: FontWeight.w700,
                              color: isDark ? Colors.white : Colors.black87,
                              fontSize: 14,
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
                    Icon(
                      isExpanded
                          ? Icons.expand_less_rounded
                          : Icons.expand_more_rounded,
                      color: const Color(0xffd4a574),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isExpanded)
            Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: items
                    .map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(
                                    0xffd4a574,
                                  ).withValues(alpha: 0.6),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                item,
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
                    )
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
