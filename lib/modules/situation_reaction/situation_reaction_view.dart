import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'situation_reaction_controller.dart';

class SituationReactionView extends GetView<SituationReactionController> {
  const SituationReactionView({super.key});

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Situation Reaction',
      subtitle:
          'Run scenario-based drills that test how individuals respond under pressure. '
          'Capture stimulus, response, and lessons learned to build a library of institutional knowledge.',
      icon: Icons.crisis_alert,
      items: const [
        SampleContentItem(
          title: 'Scenario Library',
          subtitle:
              'Browse a curated set of real-world scenarios categorised by difficulty and domain. '
              'Each scenario includes context, constraints, and expected competency indicators.',
          icon: Icons.library_books,
        ),
        SampleContentItem(
          title: 'Run a Drill',
          subtitle:
              'Launch a timed scenario drill for an individual or group and record their live responses. '
              'The system timestamps each decision point to support detailed post-drill analysis.',
          icon: Icons.play_arrow,
        ),
        SampleContentItem(
          title: 'Response Capture',
          subtitle:
              'Document the exact actions taken in response to a stimulus, including rationale. '
              'Responses can be entered as text, voice notes, or structured multiple-choice answers.',
          icon: Icons.record_voice_over,
        ),
        SampleContentItem(
          title: 'Evaluator Scoring',
          subtitle:
              'Assessors rate each response against a predefined rubric covering speed, accuracy, and judgement. '
              'Scores are aggregated to produce an overall situational-awareness rating.',
          icon: Icons.grading,
        ),
        SampleContentItem(
          title: 'Lessons Learned',
          subtitle:
              'Capture key takeaways from each drill and link them to specific training objectives. '
              'Lessons are shared across the team so everyone benefits from each exercise.',
          icon: Icons.lightbulb_outline,
        ),
        SampleContentItem(
          title: 'Drill History & Trends',
          subtitle:
              'Review past drill results to track improvement in reaction time and decision quality. '
              'Trend charts highlight recurring weaknesses that need targeted remediation.',
          icon: Icons.trending_up,
        ),
        SampleContentItem(
          title: 'Create Custom Scenario',
          subtitle:
              'Design a bespoke scenario tailored to your unit\'s specific operational context. '
              'Set the stimulus, define acceptable responses, and publish it to the shared library.',
          icon: Icons.add_box,
        ),
      ],
    );
  }
}
