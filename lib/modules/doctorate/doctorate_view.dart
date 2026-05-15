import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'doctorate_controller.dart';

class DoctorateView extends GetView<DoctorateController> {
  const DoctorateView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Doctorate',
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
            Colors.teal.withOpacity(0.15),
            Colors.green.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.teal.withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.biotech_outlined,
                  color: Colors.teal,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Doctorate',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Advanced study lane for researchers and scholars',
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
            'AIR\'s Doctorate lane supports the full scholarly arc — from deep reading habits and proposal writing '
            'to publication pipelines and viva preparation — so your research rhythm compounds over time.',
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
            ? theme.cardColor.withOpacity(0.35)
            : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.06)
              : theme.colorScheme.outline.withOpacity(0.12),
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
    title: 'Research Rhythm',
    icon: Icons.schedule_outlined,
    color: Colors.teal,
    points: [
      'Design a weekly deep-work schedule that protects long reading blocks from meeting creep and notifications.',
      'Log daily research hours in AIR so you can spot patterns — when you\'re most productive and when you drift.',
      'Set milestone targets (chapters drafted, papers read, experiments run) and review them in weekly retrospectives.',
    ],
  ),
  _Section(
    title: 'Literature & Deep Reading',
    icon: Icons.menu_book_outlined,
    color: Colors.indigo,
    points: [
      'Build a structured reading list organised by theme, methodology, and citation weight in your field.',
      'Use AIR\'s annotation layer to capture key arguments, counter-arguments, and your own critical notes per paper.',
      'Track which papers you\'ve read, skimmed, or queued so your literature review stays comprehensive and honest.',
    ],
  ),
  _Section(
    title: 'Thesis Architecture',
    icon: Icons.account_tree_outlined,
    color: Colors.blue,
    points: [
      'Map your thesis structure — chapters, sub-sections, and argument flow — in a visual outline before writing.',
      'Link each section to the supporting literature and data sources so gaps become visible early.',
      'Version-control your drafts inside AIR and leave timestamped notes for your advisor review cycles.',
    ],
  ),
  _Section(
    title: 'Research Proposals & Grants',
    icon: Icons.description_outlined,
    color: Colors.green,
    points: [
      'Use AIR\'s proposal template to articulate research questions, methodology, and expected contributions clearly.',
      'Track grant deadlines, funding bodies, and submission requirements in one consolidated calendar.',
      'Store reviewer feedback from past proposals and use it to sharpen future applications.',
    ],
  ),
  _Section(
    title: 'Publication Pipeline',
    icon: Icons.publish_outlined,
    color: Colors.purple,
    points: [
      'Manage your manuscript pipeline — from draft to submission to revision — with status tags per journal.',
      'Log peer-review feedback and track response letters so revision cycles stay organised and timely.',
      'Celebrate accepted papers in your AIR profile and link them to your public scholarly identity.',
    ],
  ),
  _Section(
    title: 'Advisor & Peer Collaboration',
    icon: Icons.group_work_outlined,
    color: Colors.orange,
    points: [
      'Schedule regular advisor check-ins and log action items so nothing agreed in meetings gets forgotten.',
      'Share chapter drafts with trusted peers for pre-submission critique using AIR\'s secure sharing links.',
      'Join or form a doctoral writing group inside AIR to maintain accountability and reduce isolation.',
    ],
  ),
  _Section(
    title: 'Viva & Defence Prep',
    icon: Icons.record_voice_over_outlined,
    color: Colors.red,
    points: [
      'Compile a list of likely examiner questions based on your thesis and practice structured responses.',
      'Record mock defence sessions and review them to improve clarity, pacing, and confidence under pressure.',
      'Prepare a concise 10-minute summary of your contribution that you can deliver fluently from memory.',
    ],
  ),
];
