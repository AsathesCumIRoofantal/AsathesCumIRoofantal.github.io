import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'airs_showcase_controller.dart';

class AirsShowcaseView extends GetView<AirsShowcaseController> {
  const AirsShowcaseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SampleContentPage(
      title: "AIR's Showcase",
      subtitle:
          'Explore the highlights and exemplars that demonstrate AIR operating at its best — real stories, real results, real impact. '
          'The showcase is both a source of pride and a practical reference for what good looks like in every domain.',
      icon: Icons.emoji_events_rounded,
      items: [
        SampleContentItem(
          title: 'Featured Success Stories',
          subtitle:
              'In-depth case studies of AIR initiatives that delivered exceptional outcomes for users or communities. '
              'Each story details the challenge, the approach taken, and the measurable results achieved.',
          icon: Icons.auto_stories_rounded,
        ),
        SampleContentItem(
          title: 'Innovation Spotlights',
          subtitle:
              'Highlight novel solutions, creative workarounds, and breakthrough ideas that emerged from within the AIR community. '
              'Spotlights celebrate the people behind the ideas and encourage others to experiment boldly.',
          icon: Icons.lightbulb_rounded,
        ),
        SampleContentItem(
          title: 'Impact Metrics Gallery',
          subtitle:
              'Visualise the cumulative impact of AIR across key dimensions — lives touched, processes improved, and time saved. '
              'Metrics are updated in real time and presented in formats suitable for sharing with external audiences.',
          icon: Icons.bar_chart_rounded,
        ),
        SampleContentItem(
          title: 'Community Exemplars',
          subtitle:
              'Recognise individuals and teams whose conduct, collaboration, and results set the standard for the entire AIR community. '
              'Exemplars are nominated by peers and verified by a transparent review process.',
          icon: Icons.people_rounded,
        ),
        SampleContentItem(
          title: 'Partner Achievements',
          subtitle:
              'Document milestones reached through AIR\'s external partnerships — joint projects, co-developed tools, and shared wins. '
              'Partner achievements reinforce the value of the ecosystem and attract new collaborators.',
          icon: Icons.diversity_3_rounded,
        ),
        SampleContentItem(
          title: 'Showcase Submission',
          subtitle:
              'Nominate a project, person, or outcome you believe deserves recognition in the AIR showcase. '
              'Submissions are reviewed within 72 hours and published with full attribution to the nominator.',
          icon: Icons.upload_rounded,
        ),
      ],
    );
  }
}
