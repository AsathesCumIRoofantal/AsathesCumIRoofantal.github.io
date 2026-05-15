import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'rivalry_controller.dart';

class RivalryView extends GetView<RivalryController> {
  const RivalryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Rivalry',
      subtitle:
          'Healthy rivalry sharpens you — it raises your standard, exposes your gaps, and pushes you past comfortable plateaus. This module helps you channel competitive tension into growth rather than letting it corrode relationships.',
      icon: Icons.sports_score_outlined,
      items: const [
        SampleContentItem(
          title: 'Identify Your Rivals',
          subtitle:
              'A rival is someone whose performance sets your benchmark. Name the people or teams you measure yourself against — not to diminish them, but to use their excellence as a calibration point for your own.',
          icon: Icons.person_search_outlined,
        ),
        SampleContentItem(
          title: 'What They Do Better',
          subtitle:
              'Honest rivalry requires honest assessment. Log the specific areas where your rival outperforms you — their speed, their craft, their consistency — and treat each gap as a training target.',
          icon: Icons.trending_up_outlined,
        ),
        SampleContentItem(
          title: 'Rivalry vs. Resentment',
          subtitle:
              'Rivalry becomes toxic when it tips into resentment — wanting them to fail rather than wanting yourself to improve. Monitor your internal narrative and redirect it toward your own progress.',
          icon: Icons.warning_amber_outlined,
        ),
        SampleContentItem(
          title: 'Learning from Losses',
          subtitle:
              'Every time a rival beats you is a data point. Log the outcome, analyze what they did differently, and extract one concrete lesson you can apply before the next encounter.',
          icon: Icons.school_outlined,
        ),
        SampleContentItem(
          title: 'Mutual Respect',
          subtitle:
              'The best rivalries are built on mutual respect — each party acknowledging the other\'s quality. Acknowledge your rival\'s wins publicly and privately; it keeps the competition clean and motivating.',
          icon: Icons.handshake_outlined,
        ),
        SampleContentItem(
          title: 'Rivalry Expiry',
          subtitle:
              'Some rivalries outlive their usefulness — the gap closes, the context changes, or the relationship evolves. Know when to retire a rivalry and convert it into collaboration or simple admiration.',
          icon: Icons.timer_off_outlined,
        ),
      ],
    );
  }
}
