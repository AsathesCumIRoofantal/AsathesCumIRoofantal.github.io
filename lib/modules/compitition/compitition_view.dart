import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'compitition_controller.dart';

class CompititionView extends GetView<CompititionController> {
  final bool isEmbedded;
  const CompititionView({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Competition',
      subtitle:
          'Fair competition in AIR is about playing hard within agreed rules, scoring honestly, and recovering with grace after the result. This module helps you compete in ways that build your reputation rather than damage it.',
      icon: Icons.emoji_events_outlined,
      items: const [
        SampleContentItem(
          title: 'Rules of Engagement',
          subtitle:
              'Every competition has rules — explicit and implicit. Know them before you enter, play within them even when no one is watching, and call out violations calmly when they occur.',
          icon: Icons.gavel_outlined,
        ),
        SampleContentItem(
          title: 'Honest Scoring',
          subtitle:
              'Inflating your wins or minimizing your losses distorts your feedback loop. Log competition outcomes accurately — the score, the context, and what you actually controlled versus what was luck.',
          icon: Icons.scoreboard_outlined,
        ),
        SampleContentItem(
          title: 'Competing to Learn',
          subtitle:
              'The best competitors enter contests to learn, not just to win. Set a learning goal for each competition — a skill to test, a strategy to try — so every outcome has value regardless of the result.',
          icon: Icons.lightbulb_outline,
        ),
        SampleContentItem(
          title: 'Winning with Humility',
          subtitle:
              'How you win matters as much as whether you win. Acknowledge your opponent\'s effort, avoid gloating, and resist the urge to attribute every win entirely to your own superiority.',
          icon: Icons.sentiment_satisfied_outlined,
        ),
        SampleContentItem(
          title: 'Losing with Dignity',
          subtitle:
              'Losing well is a skill. Congratulate the winner genuinely, resist the urge to make excuses, and give yourself 24 hours before analyzing what went wrong so emotion doesn\'t distort the review.',
          icon: Icons.sentiment_neutral_outlined,
        ),
        SampleContentItem(
          title: 'Recovery Protocol',
          subtitle:
              'After a loss, the fastest path back is a structured recovery — rest, review, reset. Log your post-competition recovery routine and refine it so you return to peak readiness faster each time.',
          icon: Icons.refresh_outlined,
        ),
        SampleContentItem(
          title: 'Competition Ethics',
          subtitle:
              'Shortcuts that compromise your integrity cost more than any single win is worth. Define your ethical lines — what you will never do to win — and treat them as non-negotiable regardless of the stakes.',
          icon: Icons.verified_user_outlined,
        ),
      ],
    );
  }
}



