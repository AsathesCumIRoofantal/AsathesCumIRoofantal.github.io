import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'imagination_features_controller.dart';

class ImaginationFeaturesView extends GetView<ImaginationFeaturesController> {
  const ImaginationFeaturesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SampleContentPage(
      title: 'Imagination Features',
      subtitle:
          'Explore imagined futures and speculative feature concepts — a safe space to brainstorm bold ideas without touching production systems. '
          'AIR captures your vision, stress-tests it against real constraints, and helps you decide which concepts are worth building next.',
      icon: Icons.auto_awesome_rounded,
      items: [
        SampleContentItem(
          title: 'Idea Canvas',
          subtitle:
              'Sketch out feature concepts in free-form — describe what you imagine, who it serves, and what problem it solves, without worrying about technical feasibility yet. '
              'The canvas is a judgment-free zone where half-formed ideas are welcome; refinement comes later.',
          icon: Icons.draw_rounded,
        ),
        SampleContentItem(
          title: 'Concept Stress-Test',
          subtitle:
              'Run your imagined feature through AIR\'s structured stress-test — checking it against existing architecture, user needs, resource constraints, and ethical considerations. '
              'Stress-testing early saves months of wasted effort and surfaces the real blockers before a single line of code is written.',
          icon: Icons.science_rounded,
        ),
        SampleContentItem(
          title: 'Future Roadmap Board',
          subtitle:
              'Pin your strongest concepts to a personal roadmap board, ordered by impact and feasibility, so you always know which imagined feature is next in line. '
              'The board is visible to collaborators you invite, turning private imagination into shared direction.',
          icon: Icons.map_rounded,
        ),
        SampleContentItem(
          title: 'Inspiration Feed',
          subtitle:
              'Browse a curated feed of emerging technologies, design patterns, and real-world innovations that AIR surfaces based on your profile and interests. '
              'Inspiration is not random here — it is filtered to match the domains where your imagination is most likely to produce something valuable.',
          icon: Icons.lightbulb_rounded,
        ),
        SampleContentItem(
          title: 'Prototype Sandbox',
          subtitle:
              'Spin up a lightweight sandbox environment to mock up user flows, data models, or interaction patterns for your concept — completely isolated from live systems. '
              'Sandboxes expire automatically, keeping the environment clean while giving you enough time to validate the core idea.',
          icon: Icons.developer_mode_rounded,
        ),
        SampleContentItem(
          title: 'Concept Voting & Feedback',
          subtitle:
              'Share your imagined features with a trusted circle and collect structured feedback — ratings, comments, and improvement suggestions — before committing to a build. '
              'Peer feedback at the concept stage is the cheapest form of validation available; use it before investing real resources.',
          icon: Icons.how_to_vote_rounded,
        ),
      ],
    );
  }
}
