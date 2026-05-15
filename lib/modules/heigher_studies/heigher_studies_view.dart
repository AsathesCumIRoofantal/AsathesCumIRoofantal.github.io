import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'heigher_studies_controller.dart';

class HeigherStudiesView extends GetView<HeigherStudiesController> {
  const HeigherStudiesView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Higher Studies',
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
            Colors.blue.withOpacity(0.15),
            Colors.lightBlue.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.blue.withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.school_outlined,
                  color: Colors.blue,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Higher Studies',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Navigate your post-graduate journey inside AIR',
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
            'AIR\'s Higher Studies lane maps every step from entrance prep to graduation — '
            'curating programs, scholarships, and mentors so your academic climb stays on track.',
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
    title: 'Program Discovery',
    icon: Icons.travel_explore,
    color: Colors.blue,
    points: [
      'Browse curated Masters, MBA, and PG Diploma programs matched to your AIR profile and career goals.',
      'Filter by mode — full-time, part-time, online, or hybrid — so you find a format that fits your life.',
      'Compare tuition, duration, and alumni outcomes side-by-side before shortlisting.',
    ],
  ),
  _Section(
    title: 'Entrance Exam Prep',
    icon: Icons.quiz_outlined,
    color: Colors.indigo,
    points: [
      'Access topic-wise practice sets for GRE, GMAT, CAT, GATE, and other major entrance exams.',
      'Track mock-test scores over time and let AIR surface the weak areas that need the most attention.',
      'Set a target exam date and receive a personalised daily study schedule inside the app.',
    ],
  ),
  _Section(
    title: 'Scholarships & Funding',
    icon: Icons.workspace_premium,
    color: Colors.amber,
    points: [
      'Discover merit-based, need-based, and domain-specific scholarships from universities and foundations worldwide.',
      'AIR alerts you to upcoming deadlines and auto-fills common application fields from your profile.',
      'Track application status and required documents in one consolidated funding dashboard.',
    ],
  ),
  _Section(
    title: 'Statement of Purpose',
    icon: Icons.edit_note,
    color: Colors.teal,
    points: [
      'Use AIR\'s guided SOP builder to craft a compelling narrative around your academic and professional journey.',
      'Get structured feedback on clarity, tone, and alignment with the program\'s stated values.',
      'Save multiple SOP drafts tailored to different universities without losing version history.',
    ],
  ),
  _Section(
    title: 'Recommendation Letters',
    icon: Icons.mark_email_read_outlined,
    color: Colors.green,
    points: [
      'Manage your recommender list and send polite reminder nudges directly from AIR.',
      'Share a context brief with each recommender so they can write a targeted, evidence-rich letter.',
      'Track submission status per university so nothing slips through the cracks at deadline time.',
    ],
  ),
  _Section(
    title: 'Visa & Relocation',
    icon: Icons.flight_takeoff_outlined,
    color: Colors.cyan,
    points: [
      'Step-by-step visa checklists for popular study destinations — US, UK, Canada, Germany, and Australia.',
      'Connect with AIR community members who have recently relocated to your target country for first-hand tips.',
      'Budget planner for tuition, living costs, and travel so you arrive financially prepared.',
    ],
  ),
  _Section(
    title: 'Alumni & Mentors',
    icon: Icons.people_alt_outlined,
    color: Colors.purple,
    points: [
      'Browse verified alumni from your target programs who have opted in to mentor prospective students.',
      'Book 30-minute Q&A sessions to get candid insights about campus life, placements, and coursework.',
      'Join cohort groups for your intake year and start building your network before classes begin.',
    ],
  ),
  _Section(
    title: 'Interview Preparation',
    icon: Icons.record_voice_over_outlined,
    color: Colors.deepOrange,
    points: [
      'Access domain-specific interview question banks — technical, HR, and case-study formats — curated for top graduate programmes.',
      'Practice with timed mock interviews and receive AI-assisted feedback on structure, clarity, and keyword density.',
      'Review real anonymised interview experiences shared by successful admits inside the AIR community.',
      'Build a personal answer library for recurring themes: leadership experience, failure lessons, and long-term vision narratives.',
    ],
  ),
  _Section(
    title: 'Thesis & Research Guide',
    icon: Icons.menu_book_outlined,
    color: Colors.brown,
    points: [
      'Navigate topic selection with a structured funnel — from broad research domain down to a specific, defensible question.',
      'Use the citation manager integration to organise references, avoid plagiarism, and format bibliographies automatically.',
      'Access thesis templates aligned with major international style guides: APA, MLA, Chicago, and Harvard.',
      'Connect with faculty volunteers who offer one-off thesis direction reviews to first-time researchers.',
      'Track chapter milestones and submission deadlines inside the AIR study planner so nothing falls behind.',
    ],
  ),
  _Section(
    title: 'Career After Graduation',
    icon: Icons.work_outline,
    color: Colors.blueGrey,
    points: [
      'Map the career trajectories of graduates from your target programme using anonymised alumni outcome data.',
      'Identify the roles, industries, and companies that most frequently absorb your degree type within the first two years.',
      'Use the salary benchmarking tool to negotiate your first role with real data rather than guesswork.',
      'Access a 90-day post-graduation action plan template used by successful AIR community members.',
      'Set up automatic job-alert feeds filtered by degree relevance and geographic preference.',
    ],
  ),
  _Section(
    title: 'Digital Learning Resources',
    icon: Icons.devices_outlined,
    color: Colors.teal,
    points: [
      'Access a curated library of MOOCs, recorded lectures, and open courseware from top universities — free and paid options included.',
      'Build a personal learning stack aligned with the prerequisites and electives of your shortlisted programmes.',
      'Track online course completions and generate a verified digital credential record shareable on your AIR profile.',
      'Subscribe to subject-specific newsletters and paper digests so you arrive at your programme already engaged with current research.',
    ],
  ),
  _Section(
    title: 'Academic Writing Workshop',
    icon: Icons.edit_outlined,
    color: Colors.deepPurple,
    points: [
      'Understand the structural anatomy of strong academic writing: argument, evidence, synthesis, and citation.',
      'Practice paragraph construction using scaffolded exercises that progressively reduce guidance.',
      'Learn to distinguish between descriptive, analytical, critical, and evaluative writing modes — and when each is required.',
      'Use the peer-review pairing feature to exchange drafts with a community member for structured feedback.',
      'Access a vocabulary bank of academic connective phrases to replace colloquial language in formal submissions.',
    ],
  ),
];
