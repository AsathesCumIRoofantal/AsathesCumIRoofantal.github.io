import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'code_conduct_controller.dart';

class CodeConductView extends GetView<CodeConductController> {
  const CodeConductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;
    final primary = theme.colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Code & Conduct',
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
              _buildHeader(context, isDark, onSurface, primary),
              const SizedBox(height: 24),
              ..._sections.map((section) =>
                  _buildSection(context, section, isDark, onSurface, primary)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark, Color onSurface, Color primary) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primary.withOpacity(0.15), primary.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: primary.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: primary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(Icons.gavel_rounded, color: primary, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Community Standards',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Guidelines for respectful collaboration',
                      style: TextStyle(
                        fontSize: 13,
                        color: onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Our Code of Conduct outlines expectations for participation in our community, '
            'steps for reporting unacceptable behavior, and the consequences for violations. '
            'We are committed to providing a welcoming and inclusive environment for everyone.',
            style: TextStyle(
              fontSize: 14,
              color: onSurface.withOpacity(0.75),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, _ConductSection section, bool isDark, Color onSurface, Color primary) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDark
            ? Theme.of(context).cardColor.withOpacity(0.35)
            : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.06)
              : Theme.of(context).colorScheme.outline.withOpacity(0.12),
        ),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                )
              ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: section.color.withOpacity(0.12),
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
          iconColor: onSurface.withOpacity(0.5),
          collapsedIconColor: onSurface.withOpacity(0.4),
          children: section.points
              .map((point) => _buildPoint(point, onSurface, section.color))
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
            decoration: BoxDecoration(
              color: accent,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              point,
              style: TextStyle(
                fontSize: 14,
                color: onSurface.withOpacity(0.75),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ConductSection {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> points;

  const _ConductSection({
    required this.title,
    required this.icon,
    required this.color,
    required this.points,
  });
}

final List<_ConductSection> _sections = [
  _ConductSection(
    title: 'Respectful Communication',
    icon: Icons.chat_bubble_outline_rounded,
    color: Colors.blue,
    points: [
      'Use welcoming and inclusive language.',
      'Be respectful of differing viewpoints and experiences.',
      'Gracefully accept constructive criticism.',
      'Show empathy towards other community members.',
    ],
  ),
  _ConductSection(
    title: 'Unacceptable Behavior',
    icon: Icons.block_rounded,
    color: Colors.redAccent,
    points: [
      'No use of sexualized language, imagery, or unwelcome advances.',
      'No trolling, insulting, or derogatory comments.',
      'No harassment in public or private channels.',
      'No publishing others\' private information without permission.',
      'No discriminatory jokes or language.',
    ],
  ),
  _ConductSection(
    title: 'Professional Standards',
    icon: Icons.verified_outlined,
    color: Colors.green,
    points: [
      'Prioritize what is best for the community.',
      'Focus on quality and continuous improvement.',
      'Take responsibility for mistakes and learn from them.',
      'Support and mentor fellow community members.',
    ],
  ),
  _ConductSection(
    title: 'Reporting & Enforcement',
    icon: Icons.report_gmailerrorred_outlined,
    color: Colors.orange,
    points: [
      'Instances of abuse may be reported to project maintainers.',
      'All complaints will be reviewed and investigated promptly.',
      'Maintainers are obligated to maintain confidentiality.',
      'Violations may result in warnings, temporary or permanent bans.',
    ],
  ),
  _ConductSection(
    title: 'Scope',
    icon: Icons.public_rounded,
    color: Colors.purple,
    points: [
      'Applies within all project spaces and public representation.',
      'Includes use of official emails, social media, and events.',
      'Applies both online and offline community interactions.',
    ],
  ),
];
