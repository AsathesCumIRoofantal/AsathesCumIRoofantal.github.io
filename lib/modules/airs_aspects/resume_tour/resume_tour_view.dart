import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'resume_tour_controller.dart';

class ResumeTourView extends GetView<ResumeTourController> {
  const ResumeTourView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SampleContentPage(
      title: 'Resume Tour',
      subtitle:
          'Pick up the guided orientation tour exactly where you left off and work through the remaining steps at your own pace. '
          'The tour is designed so that completing it gives you a confident, working understanding of every major AIR capability.',
      icon: Icons.play_circle_rounded,
      items: [
        SampleContentItem(
          title: 'Progress Checkpoint',
          subtitle:
              'See a clear summary of which tour stages you have completed, which are in progress, and which are still ahead. '
              'The checkpoint prevents the disorientation of returning after a break — you always know exactly where you are in the journey.',
          icon: Icons.flag_rounded,
        ),
        SampleContentItem(
          title: 'Module Deep-Dives',
          subtitle:
              'Step through interactive walkthroughs of each AIR module — not just what it does, but how to use it effectively in real situations. '
              'Deep-dives are designed to be completed in 5–10 minutes each, making it easy to fit orientation into a busy schedule.',
          icon: Icons.explore_rounded,
        ),
        SampleContentItem(
          title: 'Guided Feature Discovery',
          subtitle:
              'Unlock hidden and advanced features through a structured discovery sequence that reveals capabilities in the order they become most useful. '
              'Discovery is paced to match your growing familiarity — you will not be shown features you are not yet ready to use.',
          icon: Icons.search_rounded,
        ),
        SampleContentItem(
          title: 'Orientation Quiz',
          subtitle:
              'Test your understanding of key AIR concepts with a short quiz at the end of each tour section to reinforce what you have learned. '
              'Quizzes are low-stakes and immediately reviewed — they are learning tools, not assessments.',
          icon: Icons.quiz_rounded,
        ),
        SampleContentItem(
          title: 'Personalised Tour Path',
          subtitle:
              'Adjust the tour sequence based on your role, interests, and the modules most relevant to your immediate goals. '
              'A personalised path means you spend time on what matters most to you, not on a generic sequence designed for everyone.',
          icon: Icons.route_rounded,
        ),
        SampleContentItem(
          title: 'Tour Completion Certificate',
          subtitle:
              'Earn a completion certificate when you finish the full orientation tour — a shareable credential that signals your readiness to contribute fully. '
              'The certificate is recorded in your AIR profile and visible to collaborators who want to know your level of platform fluency.',
          icon: Icons.workspace_premium_rounded,
        ),
      ],
    );
  }
}
