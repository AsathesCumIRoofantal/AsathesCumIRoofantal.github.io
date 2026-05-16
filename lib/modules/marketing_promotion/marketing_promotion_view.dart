import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'marketing_promotion_controller.dart';

class MarketingPromotionView extends GetView<MarketingPromotionController> {
  const MarketingPromotionView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Marketing & Promotion',
          style: TextStyle(
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
            color: onSurface,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: onSurface,
        iconTheme: IconThemeData(color: onSurface),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [theme.scaffoldBackgroundColor, theme.colorScheme.surface]
                : [theme.colorScheme.surface, theme.scaffoldBackgroundColor],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: [
              _buildHeader(context, isDark, onSurface),
              const SizedBox(height: 20),
              ..._marketingSections.map(
                (s) => _buildSection(context, s, isDark, onSurface),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark, Color onSurface) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.purple.withValues(alpha: 0.15),
            Colors.pinkAccent.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.purple.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.purple.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.shop, color: Colors.purple, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Marketing & Promotion',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Brand strategy & campaigns',
                      style: TextStyle(
                        fontSize: 13,
                        color: onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Discover our marketing initiatives and promotional campaigns. '
            'We leverage data-driven strategies to elevate brand awareness and '
            'drive successful product launches.',
            style: TextStyle(
              fontSize: 14,
              color: onSurface.withValues(alpha: 0.75),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    _MarketingSection section,
    bool isDark,
    Color onSurface,
  ) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: isDark
            ? theme.cardColor.withValues(alpha: 0.35)
            : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.06)
              : theme.colorScheme.outline.withValues(alpha: 0.12),
        ),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
      ),
      child: Theme(
        data: theme.copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: section.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(section.icon, color: section.color, size: 20),
          ),
          title: Text(
            section.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: onSurface,
            ),
          ),
          iconColor: onSurface.withValues(alpha: 0.5),
          collapsedIconColor: onSurface.withValues(alpha: 0.4),
          children: section.points
              .map((p) => _buildPoint(p, onSurface, section.color))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildPoint(String point, Color onSurface, Color accent) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              point,
              style: TextStyle(
                fontSize: 14,
                color: onSurface.withValues(alpha: 0.75),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MarketingSection {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> points;
  const _MarketingSection({
    required this.title,
    required this.icon,
    required this.color,
    required this.points,
  });
}

final List<_MarketingSection> _marketingSections = [
  _MarketingSection(
    title: 'Digital Campaigns',
    icon: Icons.campaign_outlined,
    color: Colors.purple,
    points: [
      'Targeted social media advertising across Instagram, LinkedIn, and YouTube aligned with AIR\'s audience segments.',
      'SEO and content marketing strategies that build organic reach without compromising authenticity or brand voice.',
      'Email newsletters and drip campaigns with personalised sequences based on user behaviour and profile data.',
      'Retargeting flows that re-engage visitors who showed intent but did not convert on first contact.',
    ],
  ),
  _MarketingSection(
    title: 'Brand Assets',
    icon: Icons.branding_watermark_outlined,
    color: Colors.pink,
    points: [
      'Access to official AIR logos, colour palettes, and typography guidelines so every touchpoint stays consistent.',
      'Marketing collateral — banners, slide decks, and social templates — ready to customise for your campaign.',
      'High-resolution media kits for press and partner use, including approved spokesperson bios and key stats.',
      'Brand tone-of-voice guide to ensure written content sounds unmistakably AIR across all channels.',
    ],
  ),
  _MarketingSection(
    title: 'Market Research',
    icon: Icons.analytics_outlined,
    color: Colors.indigo,
    points: [
      'Customer persona development grounded in real AIR user data — demographics, motivations, and pain points.',
      'Competitor analysis reports updated quarterly so positioning stays sharp and differentiated.',
      'A/B testing results and conversion metrics from live campaigns, shared transparently with the team.',
      'Trend monitoring across industry publications and social listening tools to catch shifts early.',
    ],
  ),
  _MarketingSection(
    title: 'Ethical Outreach',
    icon: Icons.handshake_outlined,
    color: Colors.teal,
    points: [
      'All outreach campaigns are reviewed against AIR\'s ethical guidelines before launch — no dark patterns.',
      'Consent-first email and SMS practices: opt-in only, easy unsubscribe, and transparent data use disclosures.',
      'Community-led promotion: amplify genuine user stories rather than manufactured testimonials.',
      'Partnerships are vetted for value alignment before any co-marketing agreement is signed.',
    ],
  ),
  _MarketingSection(
    title: 'Campaign Performance',
    icon: Icons.bar_chart_outlined,
    color: Colors.orange,
    points: [
      'Real-time dashboards tracking impressions, clicks, conversions, and cost-per-acquisition per campaign.',
      'Weekly performance reviews with clear attribution so budget flows to what actually works.',
      'Post-campaign retrospectives that document what landed, what flopped, and what to try next cycle.',
      'ROI benchmarks compared against industry standards to keep expectations calibrated and honest.',
    ],
  ),
  _MarketingSection(
    title: 'Promotion Calendar',
    icon: Icons.calendar_month_outlined,
    color: Colors.green,
    points: [
      'Annual promotion calendar aligned with AIR milestones, seasonal moments, and community events.',
      'Content pipeline with lead times for design, copy, review, and scheduling — no last-minute scrambles.',
      'Cross-team coordination so product launches, events, and campaigns land together, not in conflict.',
      'Evergreen content library that keeps working between campaign bursts without extra effort.',
    ],
  ),
];
