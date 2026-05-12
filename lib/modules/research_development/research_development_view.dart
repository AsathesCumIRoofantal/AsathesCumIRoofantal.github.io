import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'research_development_controller.dart';

class ResearchDevelopmentView extends GetView<ResearchDevelopmentController> {
  const ResearchDevelopmentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Research & Development',
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
              ..._rdSections.map((s) => _buildSection(context, s, isDark, onSurface)),
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
          colors: [Colors.cyan.withOpacity(0.15), Colors.blueAccent.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.cyan.withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.science_outlined, color: Colors.cyan, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Research & Development',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: onSurface)),
                    const SizedBox(height: 4),
                    Text('Innovating for the future',
                        style: TextStyle(fontSize: 13, color: onSurface.withOpacity(0.6))),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Welcome to the core of innovation. Our R&D division is dedicated to '
            'exploring new frontiers, advancing technologies, and creating '
            'groundbreaking solutions that shape tomorrow\'s landscape.',
            style: TextStyle(fontSize: 14, color: onSurface.withOpacity(0.75), height: 1.6),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, _RDSection section, bool isDark, Color onSurface) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: isDark ? theme.cardColor.withOpacity(0.35) : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.06)
              : theme.colorScheme.outline.withOpacity(0.12),
        ),
        boxShadow: isDark
            ? []
            : [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 3))],
      ),
      child: Theme(
        data: theme.copyWith(dividerColor: Colors.transparent),
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
          title: Text(section.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: onSurface)),
          iconColor: onSurface.withOpacity(0.5),
          collapsedIconColor: onSurface.withOpacity(0.4),
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
            child: Text(point,
                style: TextStyle(fontSize: 14, color: onSurface.withOpacity(0.75), height: 1.5)),
          ),
        ],
      ),
    );
  }
}

class _RDSection {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> points;
  const _RDSection({required this.title, required this.icon, required this.color, required this.points});
}

final List<_RDSection> _rdSections = [
  _RDSection(
    title: 'Current Projects',
    icon: Icons.biotech_outlined,
    color: Colors.cyan,
    points: [
      'Ongoing experiments and prototype development.',
      'Active machine learning and AI model training.',
      'Software and hardware beta testing phases.',
    ],
  ),
  _RDSection(
    title: 'Research Publications',
    icon: Icons.library_books_outlined,
    color: Colors.indigo,
    points: [
      'Access our latest whitepapers and technical reports.',
      'Peer-reviewed journal articles and studies.',
      'Internal technical documentation and archives.',
    ],
  ),
  _RDSection(
    title: 'Innovation Lab',
    icon: Icons.lightbulb_outline,
    color: Colors.amber,
    points: [
      'Brainstorming boards and ideation tracking.',
      'Submit and vote on new feature proposals.',
      'Hackathon events and collaborative sprints.',
    ],
  ),
  _RDSection(
    title: 'Data & Analytics',
    icon: Icons.insights_outlined,
    color: Colors.teal,
    points: [
      'Comprehensive data sets and statistical analysis.',
      'Performance metrics for experimental models.',
      'Data visualization and reporting dashboards.',
    ],
  ),
];
