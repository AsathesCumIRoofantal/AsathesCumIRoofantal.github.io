import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'training_controller.dart';

class TrainingView extends GetView<TrainingController> {
  const TrainingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SampleContentPage(
      title: 'Training',
      subtitle:
          'Engage with structured drills, curated curricula, and deliberate practice loops designed to level up your capabilities in the areas that matter most to your AIR journey. '
          'Training here is not passive consumption — it is active repetition with feedback, designed to build durable competence rather than surface-level familiarity.',
      icon: Icons.fitness_center_rounded,
      items: [
        SampleContentItem(
          title: 'Active Curricula',
          subtitle:
              'Browse and enrol in structured learning programmes — each with a clear objective, sequenced modules, and a defined completion standard. '
              'Curricula are built around real AIR competencies, not generic content, so every hour invested translates directly into capability you will use.',
          icon: Icons.menu_book_rounded,
        ),
        SampleContentItem(
          title: 'Drill Library',
          subtitle:
              'Access a library of focused practice drills — short, repeatable exercises targeting specific skills like decision-making, communication, analysis, or technical execution. '
              'Drills are designed to be completed in under fifteen minutes, making them easy to fit into any schedule without disrupting flow.',
          icon: Icons.repeat_rounded,
        ),
        SampleContentItem(
          title: 'Progress Tracker',
          subtitle:
              'Monitor your training progress across all active curricula and drills — completion percentages, time invested, assessment scores, and competency milestones reached. '
              'Progress data is honest and granular; it shows not just what you have completed but how well you have demonstrated the underlying skill.',
          icon: Icons.trending_up_rounded,
        ),
        SampleContentItem(
          title: 'Assessments & Certifications',
          subtitle:
              'Complete formal assessments at the end of each curriculum to validate your learning and earn AIR-recognised certifications that appear on your profile. '
              'Certifications are not participation trophies — they require demonstrated competence and carry real weight in AIR\'s matching and recommendation systems.',
          icon: Icons.verified_rounded,
        ),
        SampleContentItem(
          title: 'Coaching & Mentorship',
          subtitle:
              'Connect with experienced practitioners who can guide your training, answer questions, and provide the kind of contextual feedback that no automated system can replicate. '
              'Coaching is available on-demand for specific challenges and as a structured engagement for longer development arcs.',
          icon: Icons.support_agent_rounded,
        ),
        SampleContentItem(
          title: 'Practice Scenarios',
          subtitle:
              'Work through realistic, scenario-based practice cases that simulate the decisions, pressures, and trade-offs you will face in real AIR contexts. '
              'Scenarios are updated regularly to reflect current challenges, ensuring your practice stays relevant rather than becoming an exercise in outdated situations.',
          icon: Icons.psychology_rounded,
        ),
        SampleContentItem(
          title: 'Training Schedule',
          subtitle:
              'Set a personal training schedule — daily, weekly, or sprint-based — and let AIR send reminders, track streaks, and adjust the plan when life gets in the way. '
              'Consistency beats intensity; a modest schedule you actually follow produces better results than an ambitious one you abandon after two weeks.',
          icon: Icons.calendar_today_rounded,
        ),
      ],
    );
  }
}
