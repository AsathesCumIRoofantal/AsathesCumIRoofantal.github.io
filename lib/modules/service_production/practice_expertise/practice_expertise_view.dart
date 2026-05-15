import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'practice_expertise_controller.dart';

class PracticeExpertiseView extends GetView<PracticeExpertiseController> {
  const PracticeExpertiseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SampleContentPage(
      title: 'Practice Expertise',
      subtitle:
          'Log deliberate practice sessions, track repetitions, and deepen specialisation through structured feedback loops. '
          'Expertise is not accidental — it is the cumulative result of intentional reps recorded and reviewed over time.',
      icon: Icons.model_training_rounded,
      items: [
        SampleContentItem(
          title: 'Practice Session Log',
          subtitle:
              'Record each deliberate practice session with duration, focus area, and self-assessed quality rating. '
              'The log builds a visible streak that reinforces the habit and makes gaps immediately apparent.',
          icon: Icons.edit_calendar_rounded,
        ),
        SampleContentItem(
          title: 'Skill Depth Tracker',
          subtitle:
              'Map your current proficiency across every skill domain relevant to your AIR role on a 1–10 scale. '
              'Depth scores update automatically as practice hours accumulate and assessments are completed.',
          icon: Icons.stacked_bar_chart_rounded,
        ),
        SampleContentItem(
          title: 'Feedback Journal',
          subtitle:
              'Capture coach, peer, and self-feedback after each practice block in a structured journal format. '
              'Recurring feedback themes are surfaced automatically so you can spot patterns across dozens of sessions.',
          icon: Icons.rate_review_rounded,
        ),
        SampleContentItem(
          title: 'Specialisation Roadmap',
          subtitle:
              'Define the specific expertise milestones you are working toward and the practice path to reach each one. '
              'Roadmap progress is visualised as a journey so you always know how far you have come and what remains.',
          icon: Icons.map_rounded,
        ),
        SampleContentItem(
          title: 'Rep Counter & Goals',
          subtitle:
              'Set weekly and monthly repetition targets for high-priority skills and track completion in real time. '
              'Missed targets trigger a gentle nudge rather than a penalty, keeping motivation constructive.',
          icon: Icons.fitness_center_rounded,
        ),
        SampleContentItem(
          title: 'Expert Benchmark Library',
          subtitle:
              'Compare your practice metrics against anonymised benchmarks from top performers in the same domain. '
              'Benchmarks reveal which dimensions of practice correlate most strongly with expert-level outcomes.',
          icon: Icons.leaderboard_rounded,
        ),
        SampleContentItem(
          title: 'Mastery Certificates',
          subtitle:
              'Earn verifiable mastery certificates when you hit predefined practice and assessment thresholds for a skill. '
              'Certificates are stored in your AIR profile and can be shared with teams or included in performance reviews.',
          icon: Icons.workspace_premium_rounded,
        ),
      ],
    );
  }
}
