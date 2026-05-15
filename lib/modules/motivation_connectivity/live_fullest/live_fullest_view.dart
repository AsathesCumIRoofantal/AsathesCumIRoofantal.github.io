import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'live_fullest_controller.dart';

class LiveFullestView extends GetView<LiveFullestController> {
  const LiveFullestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SampleContentPage(
      title: 'Live to the Fullest',
      subtitle:
          'Design a whole life where energy, ethics, and joy occupy the same frame — not competing priorities but a single integrated vision. '
          'AIR helps you audit every domain of living and align daily choices with the version of yourself you most want to become.',
      icon: Icons.self_improvement_rounded,
      items: [
        SampleContentItem(
          title: 'Life Domain Audit',
          subtitle:
              'Score your current satisfaction across eight life domains — health, relationships, work, finances, growth, play, purpose, and environment. '
              'The audit reveals which domains are thriving and which are quietly draining the energy you need everywhere else.',
          icon: Icons.radar_rounded,
        ),
        SampleContentItem(
          title: 'Energy Architecture',
          subtitle:
              'Map your daily energy peaks and troughs, then redesign your schedule so your most demanding work lands in your highest-energy windows. '
              'Energy management is the foundation of full living — without it, even the best intentions collapse under fatigue.',
          icon: Icons.bolt_rounded,
        ),
        SampleContentItem(
          title: 'Ethical Compass Check',
          subtitle:
              'Periodically review your choices against your stated values to catch the slow drift that happens when convenience quietly overrides conviction. '
              'The compass check is not about guilt — it is about recalibrating so your actions and your identity stay aligned.',
          icon: Icons.explore_rounded,
        ),
        SampleContentItem(
          title: 'Joy Inventory',
          subtitle:
              'List the activities, people, and environments that reliably produce genuine joy — not just pleasure or distraction, but deep aliveness. '
              'The inventory ensures joy is scheduled, not left to chance, and that it grows as a deliberate part of your life design.',
          icon: Icons.sentiment_very_satisfied_rounded,
        ),
        SampleContentItem(
          title: 'Whole-Life Vision Board',
          subtitle:
              'Build a structured vision that integrates career ambition, relational depth, physical vitality, and spiritual meaning into one coherent picture. '
              'A whole-life vision prevents the trap of succeeding in one domain while quietly neglecting the others that make success feel worthwhile.',
          icon: Icons.landscape_rounded,
        ),
        SampleContentItem(
          title: 'Regret Minimisation Frame',
          subtitle:
              'Use the regret-minimisation framework to evaluate big decisions by asking which choice your future self will be most grateful for. '
              'The frame shifts decision-making from short-term comfort to long-term fulfilment, the hallmark of a life lived fully.',
          icon: Icons.hourglass_top_rounded,
        ),
      ],
    );
  }
}
