import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'feedback_controller.dart';

class FeedbackView extends GetView<FeedbackController> {
  final bool isEmbedded;
  const FeedbackView({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Feedback',
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
            physics: isEmbedded ? const NeverScrollableScrollPhysics() : null,
            shrinkWrap: isEmbedded,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: [
              _buildHeader(context, isDark, onSurface),
              const SizedBox(height: 20),
              ..._sections.map(
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
            Colors.green.withValues(alpha: 0.15),
            Colors.lightGreen.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.green.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.feedback,
                  color: Colors.green,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Feedback',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'We value your opinion',
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
            'Your feedback helps us improve our services and features. '
            'Please let us know how we can serve you better.',
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
    _Section section,
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

class _Section {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> points;
  const _Section({
    required this.title,
    required this.icon,
    required this.color,
    required this.points,
  });
}

final List<_Section> _sections = [
  _Section(
    title: 'Submit Feedback',
    icon: Icons.rate_review,
    color: Colors.green,
    points: [
      'Provide general suggestions about any AIR module — your lived experience is the most valuable input we have.',
      'Report bugs and glitches with a structured form that captures device, OS, and reproduction steps automatically.',
      'Request new features with a brief use-case description so the team understands the real need behind the ask.',
      'Rate your experience after key interactions — short, optional, and never more than two taps.',
    ],
  ),
  _Section(
    title: 'Surveys & Polls',
    icon: Icons.poll,
    color: Colors.blue,
    points: [
      'Participate in quarterly product reviews — 5 questions, 3 minutes, and your answers directly shape the roadmap.',
      'Rate recent product updates with a simple thumbs-up/down plus an optional one-line comment.',
      'Vote on upcoming initiatives so the community\'s priorities, not just the team\'s assumptions, drive decisions.',
      'Pulse polls on specific topics — launched when a decision is genuinely open and community input will change it.',
    ],
  ),
  _Section(
    title: 'Response & Implementation',
    icon: Icons.done_all,
    color: Colors.purple,
    points: [
      'Feature tracking system: every submitted idea gets a public status — Under Review, Planned, In Progress, or Shipped.',
      'Implementing user suggestions is tracked transparently so you can see when your idea moved from request to reality.',
      'Transparency in decision-making: when we decline a suggestion, we explain why — not just a silent rejection.',
      'Monthly "You Said, We Did" digest that closes the loop between feedback submitted and changes shipped.',
    ],
  ),
  _Section(
    title: 'Community Insights',
    icon: Icons.insights,
    color: Colors.amber,
    points: [
      'Aggregated user sentiment analysis published quarterly — what the community loves, tolerates, and wants changed.',
      'Trend identification across feedback categories so systemic issues surface before they become crises.',
      'Strategic roadmap influence: the top-voted themes from community feedback are reviewed in every planning cycle.',
      'Anonymised verbatim quotes from feedback are shared with the product team to preserve the human voice behind the data.',
    ],
  ),
  _Section(
    title: 'Feedback Quality',
    icon: Icons.checklist_outlined,
    color: Colors.teal,
    points: [
      'Specific feedback beats vague feedback — the more context you give, the faster we can act on it.',
      'Screenshots and screen recordings can be attached to bug reports for faster diagnosis and resolution.',
      'Duplicate detection groups similar feedback so the team sees the true volume of demand for each issue.',
      'Feedback is tagged by module, severity, and type so triage is fast and nothing important gets buried.',
    ],
  ),
  _Section(
    title: 'Recognition Program',
    icon: Icons.star,
    color: Colors.yellow,
    points: [
      'Highlight valuable suggestions in the monthly community newsletter with the contributor\'s name (if they consent).',
      'Contributor acknowledgment: users whose feedback directly influenced a shipped feature are credited in release notes.',
      'Rewards for participation: consistent feedback contributors earn credits redeemable in the AIR rewards catalogue.',
      'Top feedback contributors are invited to early-access beta programmes for upcoming features.',
    ],
  ),
];
