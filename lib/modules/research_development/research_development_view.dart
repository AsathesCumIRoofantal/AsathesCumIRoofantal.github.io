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
      'Comprehensive data sets and statistical analysis for all active R&D streams.',
      'Performance metrics for experimental models — tracking accuracy, precision, and recall across iterations.',
      'Data visualisation and reporting dashboards updated in real time as new experiment results are logged.',
      'Anomaly detection pipelines that automatically flag outlier results for human investigation.',
    ],
  ),
  _RDSection(
    title: 'AI & Machine Learning Research',
    icon: Icons.memory_outlined,
    color: Colors.deepPurple,
    points: [
      'Explore AIR\'s active NLP experiments — including entity classification models trained on the all-space atlas dataset.',
      'Contribute annotated training samples to improve the accuracy of AIR\'s identity placement algorithms.',
      'Access model versioning logs to understand how each iteration improved upon — or diverged from — its predecessor.',
      'Review the ethical framework governing AIR\'s AI development: bias audits, explainability standards, and consent protocols.',
      'Join the quarterly ML review sessions where results are shared transparently with the broader R&D community.',
    ],
  ),
  _RDSection(
    title: 'Open Source Contributions',
    icon: Icons.code_outlined,
    color: Colors.green,
    points: [
      'Access AIR\'s public repositories and contribute to open components under the AIR Open Licence.',
      'Browse the contribution backlog and claim tasks matched to your skill level and domain expertise.',
      'Submit pull requests with supporting test cases and documentation — reviewed within a 5-day window.',
      'Receive AIR-V credits for merged contributions proportionate to complexity and community impact.',
      'Participate in quarterly open-source sprints with structured mentoring for first-time contributors.',
    ],
  ),
  _RDSection(
    title: 'Patent & Intellectual Property',
    icon: Icons.gavel_outlined,
    color: Colors.amber,
    points: [
      'Use AIR\'s IP strategy framework to determine whether a new idea should be patented, published openly, or kept proprietary.',
      'Access prior art search tools and patent database integrations to validate novelty before filing.',
      'Consult the IP advisory panel — comprising legal volunteers — for guidance on filing strategy and jurisdiction.',
      'Understand AIR\'s shared-ownership model: community contributors retain partial rights to innovations they seed.',
      'Track the lifecycle of pending and granted patents in the AIR IP registry.',
    ],
  ),
  _RDSection(
    title: 'Prototype Deployment & Evaluation',
    icon: Icons.rocket_launch_outlined,
    color: Colors.deepOrange,
    points: [
      'Move from validated prototype to limited deployment using AIR\'s staged rollout framework — starting with internal testers.',
      'Define success criteria before deployment so evaluation is objective and not subject to post-hoc rationalisation.',
      'Collect structured user feedback through in-app instruments and analyse it against the original prototype hypotheses.',
      'Log deployment learnings to the R&D knowledge base so future teams inherit your hard-won insights.',
      'Decide on scale-up, iteration, or deprecation through a structured decision memo reviewed by the R&D council.',
    ],
  ),
  _RDSection(
    title: 'Collaborative Experiments',
    icon: Icons.science_outlined,
    color: Colors.blueAccent,
    points: [
      'Propose a new collaborative experiment by submitting a hypothesis, methodology, and resource estimate to the R&D board.',
      'Partner with other AIR sections — Knowledge Centre, Higher Studies, Service Production — for cross-functional research.',
      'Access shared laboratory resources: compute credits, dataset access, and expert time — allocated by the R&D council.',
      'Document experiment progress in structured lab notebooks that become part of the permanent R&D archive.',
    ],
  ),
  _RDSection(
    title: 'Field Research & Surveys',
    icon: Icons.explore_outlined,
    color: Colors.brown,
    points: [
      'Design and deploy surveys to the AIR community using the built-in survey builder with logic branching.',
      'Access anonymised aggregate results in real time and export structured datasets for statistical analysis.',
      'Plan qualitative field research — interviews, focus groups, and ethnographic observation — with templates and consent forms.',
      'Link field research findings to corresponding R&D projects so insights are contextualised and retrievable.',
      'Maintain a participant registry to track informed consent and manage research ethics compliance.',
    ],
  ),
];
