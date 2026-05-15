import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'finally_blessings_controller.dart';

class FinallyBlessingsView extends GetView<FinallyBlessingsController> {
  const FinallyBlessingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SampleContentPage(
      title: 'Finally, Blessings',
      subtitle:
          'Close every session with intentional gratitude and a clear benediction that anchors what was accomplished. '
          'Ending with clarity and appreciation is not a formality — it is the practice that makes the next beginning easier.',
      icon: Icons.spa_rounded,
      items: [
        SampleContentItem(
          title: 'Closing Gratitude Ritual',
          subtitle:
              'Spend two minutes naming three things you are genuinely grateful for from the session just completed. '
              'Gratitude rituals are brief by design — the goal is sincerity, not length.',
          icon: Icons.favorite_rounded,
        ),
        SampleContentItem(
          title: 'Session Benediction',
          subtitle:
              'Compose a short closing statement that acknowledges the work done and releases you from the session with intention. '
              'Benedictions can be personal, spiritual, or simply a clear declaration that this chapter is complete.',
          icon: Icons.auto_awesome_rounded,
        ),
        SampleContentItem(
          title: 'Accomplishment Acknowledgement',
          subtitle:
              'Before closing, explicitly name what you accomplished — even small wins deserve to be seen and recorded. '
              'Acknowledgement builds the evidence base that sustains motivation through difficult stretches.',
          icon: Icons.emoji_events_rounded,
        ),
        SampleContentItem(
          title: 'Intention for Next Opening',
          subtitle:
              'Set a single clear intention for the next time you return to this work, so you re-enter with purpose rather than confusion. '
              'The intention is stored and surfaced automatically at the start of your next session.',
          icon: Icons.wb_sunny_rounded,
        ),
        SampleContentItem(
          title: 'Blessing Library',
          subtitle:
              'Browse a curated collection of closing blessings, affirmations, and benedictions from diverse traditions and contributors. '
              'Save favourites to your personal library and rotate them to keep the closing ritual fresh.',
          icon: Icons.collections_bookmark_rounded,
        ),
        SampleContentItem(
          title: 'Gratitude History',
          subtitle:
              'Review your gratitude entries over time to see the patterns of what consistently brings you meaning and satisfaction. '
              'The history is a powerful antidote to negativity bias — proof, in your own words, that good things happen regularly.',
          icon: Icons.history_rounded,
        ),
      ],
    );
  }
}
