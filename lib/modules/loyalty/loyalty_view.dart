import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'loyalty_controller.dart';

class LoyaltyView extends GetView<LoyaltyController> {
  const LoyaltyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Loyalty',
      subtitle:
          'Loyalty in AIR is about knowing where you commit long-term versus where you experiment. It\'s not blind allegiance — it\'s a deliberate signal that you\'ve chosen to invest deeply in a person, team, or cause.',
      icon: Icons.verified_outlined,
      items: const [
        SampleContentItem(
          title: 'Long-Term Commitments',
          subtitle:
              'Some relationships and causes deserve your unconditional investment — your family, your core team, your deepest values. Name them explicitly so you know what you\'re protecting when things get hard.',
          icon: Icons.anchor_outlined,
        ),
        SampleContentItem(
          title: 'Experimental Allegiances',
          subtitle:
              'Not every commitment needs to be permanent. Some relationships and projects are worth a trial period — log them separately so you can evaluate honestly without guilt when the trial ends.',
          icon: Icons.science_outlined,
        ),
        SampleContentItem(
          title: 'Loyalty Signals',
          subtitle:
              'Loyalty is shown through behavior, not declarations. Log the concrete signals you send — showing up when it\'s inconvenient, defending someone in their absence, keeping confidences under pressure.',
          icon: Icons.thumb_up_alt_outlined,
        ),
        SampleContentItem(
          title: 'Loyalty vs. Enabling',
          subtitle:
              'Loyalty does not mean covering for bad behavior or staying silent when someone you care about is heading in the wrong direction. Know the line between standing by someone and enabling their worst patterns.',
          icon: Icons.warning_outlined,
        ),
        SampleContentItem(
          title: 'Reciprocal Loyalty Check',
          subtitle:
              'Loyalty should be mutual. Periodically review whether the people and organizations you\'re loyal to are showing up for you in return — not to keep score, but to ensure the relationship is sustainable.',
          icon: Icons.compare_arrows_outlined,
        ),
        SampleContentItem(
          title: 'Exiting with Integrity',
          subtitle:
              'When a commitment no longer serves either party, leaving well is the final act of loyalty. Log how you\'ve ended commitments — did you give notice, honor obligations, and leave the door open?',
          icon: Icons.exit_to_app_outlined,
        ),
      ],
    );
  }
}
