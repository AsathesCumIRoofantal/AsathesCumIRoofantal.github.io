import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'innovation_key_controller.dart';

class InnovationKeyView extends GetView<InnovationKeyController> {
  const InnovationKeyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SampleContentPage(
      title: 'Innovation Is Key',
      subtitle:
          'Understand why novelty matters in AIR and how to generate, test, and scale new ideas without sacrificing integrity or trust. '
          'Real innovation is disciplined creativity — it solves genuine problems in ways that hold up under scrutiny.',
      icon: Icons.key_rounded,
      items: [
        SampleContentItem(
          title: 'Idea Generation Studio',
          subtitle:
              'Use structured brainstorming prompts, constraint-based thinking, and analogical reasoning to generate novel solutions. '
              'Ideas are captured in a shared studio so the best ones can be developed collaboratively rather than in isolation.',
          icon: Icons.lightbulb_rounded,
        ),
        SampleContentItem(
          title: 'Innovation Pipeline',
          subtitle:
              'Move ideas through a staged pipeline — raw concept, feasibility check, prototype, pilot, and scale — with clear criteria at each gate. '
              'The pipeline prevents both premature scaling and indefinite stagnation in the concept phase.',
          icon: Icons.linear_scale_rounded,
        ),
        SampleContentItem(
          title: 'Integrity Stress Test',
          subtitle:
              'Before advancing any innovation, stress-test it against AIR\'s core values and non-negotiable commitments. '
              'An idea that only works by cutting ethical corners is not innovation — it is a liability dressed up as progress.',
          icon: Icons.verified_user_rounded,
        ),
        SampleContentItem(
          title: 'Rapid Prototype Lab',
          subtitle:
              'Build lightweight prototypes of promising ideas in 48 hours or less using AIR\'s modular component library. '
              'Fast prototyping surfaces real-world friction early, when changes are cheap and learning is fast.',
          icon: Icons.science_rounded,
        ),
        SampleContentItem(
          title: 'Innovation Metrics',
          subtitle:
              'Track the health of your innovation pipeline — ideas generated, experiments run, pilots launched, and innovations scaled. '
              'Metrics reveal whether the culture is genuinely innovative or just talking about innovation.',
          icon: Icons.analytics_rounded,
        ),
        SampleContentItem(
          title: 'Cross-Domain Pollination',
          subtitle:
              'Deliberately import ideas from fields outside your domain and test whether they solve problems in new ways. '
              'The most disruptive innovations in history came from applying a known solution to an unexpected context.',
          icon: Icons.shuffle_rounded,
        ),
        SampleContentItem(
          title: 'Innovation Recognition',
          subtitle:
              'Celebrate and attribute every innovation that ships — from the original idea through to the team that scaled it. '
              'Recognition reinforces the behaviours that produce innovation and signals to the whole community that novelty is valued.',
          icon: Icons.emoji_events_rounded,
        ),
      ],
    );
  }
}
