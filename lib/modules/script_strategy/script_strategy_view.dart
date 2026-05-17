import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'script_strategy_controller.dart';

class ScriptStrategyView extends GetView<ScriptStrategyController> {
  final bool isEmbedded;
  const ScriptStrategyView({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final onSurface = theme.colorScheme.onSurface;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Script & Strategy',
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
            shrinkWrap: isEmbedded,
            physics: isEmbedded
                ? const NeverScrollableScrollPhysics()
                : const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: [
              _buildHeader(context, isDark, onSurface),
              const SizedBox(height: 20),
              ..._scriptSections.map(
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
            Colors.deepPurple.withValues(alpha: 0.15),
            Colors.indigo.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.deepPurple.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.auto_stories_outlined,
                  color: Colors.deepPurple,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Script & Strategy',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Narrative scripts and strategic storylines',
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
            'Craft compelling narratives and strategic storylines for campaigns, teaching, and communication. '
            'A well-written script turns a good idea into a message that moves people to act.',
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
    _ScriptSection section,
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

class _ScriptSection {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> points;
  const _ScriptSection({
    required this.title,
    required this.icon,
    required this.color,
    required this.points,
  });
}

final List<_ScriptSection> _scriptSections = [
  _ScriptSection(
    title: 'Video Script Templates',
    icon: Icons.videocam_outlined,
    color: Colors.deepPurple,
    points: [
      'Hook-first structure: open with a question, bold claim, or surprising fact that earns the next 30 seconds of attention.',
      'Three-act framework: Problem → Solution → Call to Action — simple, proven, and adaptable to any topic or length.',
      'Explainer script template for product demos: context, feature walkthrough, benefit statement, and next step.',
      'Testimonial script guide: how to coach real users to tell their story naturally without sounding rehearsed.',
      'Short-form (60-second) and long-form (10-minute) variants so the same message scales across platforms.',
    ],
  ),
  _ScriptSection(
    title: 'Content Planning Framework',
    icon: Icons.calendar_view_month_outlined,
    color: Colors.indigo,
    points: [
      'Content pillars: define 3–5 core themes that every piece of content maps back to for consistency and depth.',
      'Content calendar template with lead times for ideation, scripting, production, review, and publishing.',
      'Audience journey mapping: create content for awareness, consideration, and decision stages separately.',
      'Repurposing matrix: one long-form piece becomes a blog post, three social clips, a newsletter section, and a slide deck.',
      'Seasonal and event-based content hooks planned 6 weeks in advance so nothing is rushed at the last minute.',
    ],
  ),
  _ScriptSection(
    title: 'Strategic Execution Checklist',
    icon: Icons.checklist_rounded,
    color: Colors.teal,
    points: [
      'Pre-production: confirm message, audience, platform, tone, and success metric before a single word is written.',
      'Script review checklist: clarity, accuracy, tone alignment, call-to-action strength, and legal/compliance sign-off.',
      'Production brief template: everything the camera operator, editor, or designer needs in one single document.',
      'Post-publish review: did the content achieve its goal? Document what worked and what to adjust next time.',
      'Version control for scripts: never lose a previous draft — label versions clearly and archive them in AIR.',
    ],
  ),
  _ScriptSection(
    title: 'Storytelling Principles',
    icon: Icons.auto_stories_outlined,
    color: Colors.orange,
    points: [
      'Show, don\'t tell: use specific examples, numbers, and scenes rather than abstract claims and adjectives.',
      'Emotional arc: every good story moves the audience from one emotional state to another — map that journey first.',
      'Character-driven narratives: even a product story needs a protagonist whose problem the product solves.',
      'Conflict and resolution: without tension there is no story — name the obstacle clearly before offering the solution.',
      'Authentic voice: the best scripts sound like a real person talking, not a press release being read aloud.',
    ],
  ),
  _ScriptSection(
    title: 'Campaign Narrative Design',
    icon: Icons.campaign_outlined,
    color: Colors.pink,
    points: [
      'Campaign brief: one-page document that aligns the team on objective, audience, message, tone, and timeline.',
      'Narrative thread: the single idea that runs through every piece of a campaign so it feels cohesive, not scattered.',
      'Message hierarchy: primary message (one sentence), secondary messages (three points), and supporting proof.',
      'Tone calibration: formal vs. conversational, urgent vs. reflective, inspirational vs. instructional — choose deliberately.',
      'Campaign retrospective: after every campaign, document what the narrative achieved and what it missed.',
    ],
  ),
  _ScriptSection(
    title: 'Teaching & Training Scripts',
    icon: Icons.school_outlined,
    color: Colors.green,
    points: [
      'Learning objective first: every training script starts with "by the end of this, the learner will be able to..."',
      'Chunking: break complex topics into 5–7 minute segments with a clear micro-objective per chunk.',
      'Check-for-understanding moments: build in questions, pauses, or activities every 10 minutes to maintain engagement.',
      'Plain language rule: if a 14-year-old wouldn\'t understand it, rewrite it — clarity is not dumbing down.',
      'Scenario-based learning: use realistic situations and characters so learners can immediately apply what they hear.',
    ],
  ),
  _ScriptSection(
    title: 'Script Review & Iteration',
    icon: Icons.edit_note_outlined,
    color: Colors.blueGrey,
    points: [
      'Read aloud test: every script must be read aloud before it is considered final — the ear catches what the eye misses.',
      'Peer review protocol: share with one person who knows the topic and one who doesn\'t — both perspectives matter.',
      'Timing check: record yourself reading at natural pace and compare to the target duration — adjust accordingly.',
      'Feedback integration: track every suggested change, decide accept or reject with a reason, and update the master draft.',
      'Final sign-off checklist: message clarity, tone consistency, factual accuracy, legal review, and stakeholder approval.',
    ],
  ),
];
