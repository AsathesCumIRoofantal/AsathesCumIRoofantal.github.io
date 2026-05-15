import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'being_recorded_rewarded_controller.dart';

class BeingRecordedRewardedView extends GetView<BeingRecordedRewardedController> {
  const BeingRecordedRewardedView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SampleContentPage(
      title: 'Being Recorded & Rewarded',
      subtitle:
          'Understand exactly what AIR logs about your behaviour, how those metrics are used, and how recognition follows the actions that matter most. '
          'Transparency on recording and rewards removes ambiguity — you always know what is being measured, why it counts, and what you stand to gain.',
      icon: Icons.military_tech_rounded,
      items: [
        SampleContentItem(
          title: 'What Gets Logged',
          subtitle:
              'See a plain-language breakdown of every data point AIR records about your activity — actions taken, time spent, contributions made, and interactions completed. '
              'Nothing is logged silently; every metric has a stated purpose and a clear link to the outcomes it is designed to support.',
          icon: Icons.receipt_long_rounded,
        ),
        SampleContentItem(
          title: 'Metrics Dashboard',
          subtitle:
              'View your personal metrics in real time — contribution scores, engagement rates, reliability indices, and growth indicators — presented in a clear, honest dashboard. '
              'Metrics are not used to rank you against others by default; they are tools for your own self-awareness and improvement.',
          icon: Icons.dashboard_rounded,
        ),
        SampleContentItem(
          title: 'Recognition Triggers',
          subtitle:
              'Understand the specific behaviours and milestones that trigger recognition in AIR — what actions earn credits, badges, endorsements, or elevated status. '
              'Recognition triggers are published openly so there is no guesswork about what is valued and no room for arbitrary favouritism.',
          icon: Icons.emoji_events_rounded,
        ),
        SampleContentItem(
          title: 'Reward Ledger',
          subtitle:
              'Review a complete, timestamped ledger of every reward you have received — credits, badges, commendations, and privileges — with the specific action that earned each one. '
              'The ledger is your permanent record of recognised contribution; it travels with your profile and is visible to those you choose to share it with.',
          icon: Icons.account_balance_rounded,
        ),
        SampleContentItem(
          title: 'Data Privacy Controls',
          subtitle:
              'Manage which logged data is visible to others, which is shared with AIR\'s matching systems, and which remains strictly private to you. '
              'Privacy controls are granular and reversible — you can adjust them at any time without losing the underlying data.',
          icon: Icons.lock_rounded,
        ),
        SampleContentItem(
          title: 'Behaviour Feedback Loop',
          subtitle:
              'Receive periodic feedback that connects your logged behaviour to your stated goals — showing where your actions are aligned and where there is a gap worth addressing. '
              'The feedback loop is designed to be constructive, not punitive; it is a mirror, not a judge.',
          icon: Icons.loop_rounded,
        ),
      ],
    );
  }
}
