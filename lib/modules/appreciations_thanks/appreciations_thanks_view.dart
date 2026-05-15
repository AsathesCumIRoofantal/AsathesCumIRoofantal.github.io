import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'appreciations_thanks_controller.dart';

class AppreciationsThanksView extends GetView<AppreciationsThanksController> {
  const AppreciationsThanksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Appreciations & Thanks',
      subtitle:
          'Gratitude expressed while the memory is fresh lands differently than gratitude delayed. This module helps you build a living gratitude ledger — thanking people specifically, promptly, and in ways that actually reach them.',
      icon: Icons.card_giftcard_outlined,
      items: const [
        SampleContentItem(
          title: 'Gratitude Ledger',
          subtitle:
              'A gratitude ledger is a running log of people who have helped, supported, or inspired you. Keeping it visible ensures you don\'t let meaningful contributions go unacknowledged as time passes.',
          icon: Icons.book_outlined,
        ),
        SampleContentItem(
          title: 'Specific Thanks',
          subtitle:
              'Generic thanks ("thanks for everything") lands weakly. Specific thanks ("thank you for staying late to help me debug that issue on Tuesday") lands with weight. Practice naming the exact action and its impact.',
          icon: Icons.edit_outlined,
        ),
        SampleContentItem(
          title: 'Timely Appreciation',
          subtitle:
              'Appreciation expressed within 24-48 hours of the act is far more powerful than appreciation delivered weeks later. Log pending thank-yous and set a reminder to deliver them before the window closes.',
          icon: Icons.timer_outlined,
        ),
        SampleContentItem(
          title: 'Public vs. Private Thanks',
          subtitle:
              'Some appreciation lands better in public — it validates the person in front of their peers. Other thanks are more meaningful in private. Know which mode fits the person and the act before you deliver it.',
          icon: Icons.campaign_outlined,
        ),
        SampleContentItem(
          title: 'Appreciation Rituals',
          subtitle:
              'Build appreciation into your regular rhythms — a weekly team shoutout, a monthly note to someone who helped you, an annual letter to a mentor. Rituals ensure gratitude doesn\'t depend on spontaneous memory.',
          icon: Icons.event_repeat_outlined,
        ),
        SampleContentItem(
          title: 'Receiving Thanks Gracefully',
          subtitle:
              'Deflecting appreciation ("it was nothing") dismisses the giver\'s experience. Practice receiving thanks with a simple, genuine acknowledgment — "that means a lot, thank you for saying so" — and let it land.',
          icon: Icons.sentiment_very_satisfied_outlined,
        ),
        SampleContentItem(
          title: 'Gratitude for Ordinary Things',
          subtitle:
              'The people who show up reliably — the consistent ones, the quiet contributors — often go unthanked because their presence feels ordinary. Make a habit of thanking the people you take for granted most.',
          icon: Icons.star_border_outlined,
        ),
      ],
    );
  }
}
