import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'greetings_controller.dart';

class GreetingsView extends GetView<GreetingsController> {
  const GreetingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SampleContentPage(
      title: 'Greetings',
      subtitle:
          'Understand and practise the warm protocols AIR uses to greet people across cultures, contexts, and communication channels. '
          'A well-crafted greeting is not small talk — it is the first signal of respect, and it sets the tone for everything that follows.',
      icon: Icons.waving_hand_rounded,
      items: [
        SampleContentItem(
          title: 'Cultural Greeting Library',
          subtitle:
              'Browse a curated library of greeting customs from dozens of cultures — verbal, gestural, and written — so you can meet people on their own terms. '
              'The library is searchable by region, formality level, and context, making it a practical reference for real interactions.',
          icon: Icons.language_rounded,
        ),
        SampleContentItem(
          title: 'Context-Aware Greeting Builder',
          subtitle:
              'Generate a contextually appropriate greeting for any situation — first meeting, re-engagement, formal introduction, or community welcome — in seconds. '
              'The builder factors in the recipient\'s background, the channel, and the relationship stage to produce something that feels genuinely personal.',
          icon: Icons.auto_awesome_rounded,
        ),
        SampleContentItem(
          title: 'First Impression Principles',
          subtitle:
              'Learn the evidence-based principles behind strong first impressions — warmth before competence, name use, and the power of genuine curiosity. '
              'These principles apply across cultures and channels, giving you a reliable foundation regardless of the specific greeting form.',
          icon: Icons.psychology_rounded,
        ),
        SampleContentItem(
          title: 'Welcome Message Templates',
          subtitle:
              'Access a set of thoughtfully written welcome messages for new AIR members, guests, and collaborators that you can personalise and send in one tap. '
              'Templates save time without sacrificing warmth — they are starting points, not scripts.',
          icon: Icons.mail_rounded,
        ),
        SampleContentItem(
          title: 'Greeting Tone Calibrator',
          subtitle:
              'Adjust the formality, warmth, and length of any greeting to match the specific relationship and context you are navigating. '
              'Tone mismatches are one of the most common sources of early friction — the calibrator helps you get it right the first time.',
          icon: Icons.tune_rounded,
        ),
        SampleContentItem(
          title: 'Re-engagement Opener',
          subtitle:
              'Reconnect with someone you have not spoken to in a while using an opener that acknowledges the gap without making it awkward. '
              'Re-engagement is a skill — the right opener turns a dormant relationship into an active one with a single well-crafted message.',
          icon: Icons.refresh_rounded,
        ),
      ],
    );
  }
}
