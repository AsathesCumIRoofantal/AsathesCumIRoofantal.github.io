import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'rewards_credits_controller.dart';

class RewardsCreditsView extends GetView<RewardsCreditsController> {
  const RewardsCreditsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SampleContentPage(
      title: 'Rewards & Credits',
      subtitle:
          'Track your recognition ledger — every credit earned, reward received, and redemption made — so your contributions are always visible and their value is never lost. '
          'Rewards and credits in AIR are not gamification; they are a transparent record of the behaviours the platform values and the recognition you have genuinely earned.',
      icon: Icons.stars_rounded,
      items: [
        SampleContentItem(
          title: 'Credit Balance',
          subtitle:
              'View your current credit balance — the total of all credits earned minus any redeemed — with a breakdown by source, category, and time period. '
              'Your balance is a real-time reflection of your recognised contribution; it updates automatically as new credits are issued or redeemed.',
          icon: Icons.account_balance_wallet_rounded,
        ),
        SampleContentItem(
          title: 'Earned Rewards',
          subtitle:
              'Browse the full list of rewards you have earned — badges, commendations, privileges, and credits — each with the specific action or milestone that triggered it. '
              'Earned rewards are permanent; they cannot be revoked and they travel with your profile as a verifiable record of recognised achievement.',
          icon: Icons.emoji_events_rounded,
        ),
        SampleContentItem(
          title: 'Redemption Catalogue',
          subtitle:
              'Explore the catalogue of things you can redeem your credits for — access upgrades, priority services, community recognition, or partner benefits. '
              'The catalogue is updated regularly; check it before your credits accumulate too long, as the best redemptions tend to have limited availability.',
          icon: Icons.redeem_rounded,
        ),
        SampleContentItem(
          title: 'Redemption History',
          subtitle:
              'Review a complete log of every redemption you have made — what was redeemed, when, for how many credits, and what was received in return. '
              'History gives you a clear picture of how you are using your recognition and whether your redemption choices are aligned with your actual priorities.',
          icon: Icons.receipt_rounded,
        ),
        SampleContentItem(
          title: 'Recognition Triggers',
          subtitle:
              'Understand exactly which behaviours and milestones earn credits and rewards in AIR — published openly so there is no ambiguity about what is valued. '
              'Knowing the triggers lets you make intentional choices about where to invest your effort for maximum recognised impact.',
          icon: Icons.bolt_rounded,
        ),
        SampleContentItem(
          title: 'Reward Posture Settings',
          subtitle:
              'Configure how you want to engage with the rewards system — whether to display your balance publicly, receive notifications for new credits, or opt into peer-recognition features. '
              'Your posture is yours to set; AIR respects that some people prefer quiet recognition while others value public acknowledgement.',
          icon: Icons.tune_rounded,
        ),
      ],
    );
  }
}
