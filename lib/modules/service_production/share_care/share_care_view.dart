import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'share_care_controller.dart';

class ShareCareView extends GetView<ShareCareController> {
  final bool isEmbedded;
  const ShareCareView({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    return const SampleContentPage(
      title: 'Share & Care',
      subtitle:
          'Cultivate a mutual-aid posture by sharing resources, knowledge, and support with the people in your circle. '
          'Care loops — regular check-ins and acts of generosity — strengthen the trust that makes every AIR collaboration more resilient.',
      icon: Icons.volunteer_activism_rounded,
      items: [
        SampleContentItem(
          title: 'Resource Sharing Board',
          subtitle:
              'Post tools, templates, contacts, or capacity that you are willing to share with your network. '
              'Others can request access directly, and the board keeps a transparent record of what has been exchanged.',
          icon: Icons.share_rounded,
        ),
        SampleContentItem(
          title: 'Care Check-In Scheduler',
          subtitle:
              'Set up recurring check-ins with key people in your circle so no relationship drifts through neglect. '
              'Check-ins are lightweight — a single question or a brief voice note — designed to fit into a busy schedule.',
          icon: Icons.favorite_border_rounded,
        ),
        SampleContentItem(
          title: 'Support Request Hub',
          subtitle:
              'Raise a support request when you need help, and browse open requests from others you can assist. '
              'Requests are matched by skill and availability so the right person is connected to the right need quickly.',
          icon: Icons.support_agent_rounded,
        ),
        SampleContentItem(
          title: 'Generosity Ledger',
          subtitle:
              'Track acts of giving and receiving within your circle to maintain a healthy balance of mutual aid over time. '
              'The ledger is private by default but can be shared selectively to acknowledge contributions publicly.',
          icon: Icons.balance_rounded,
        ),
        SampleContentItem(
          title: 'Knowledge Gift Library',
          subtitle:
              'Contribute articles, guides, or recorded walkthroughs to a shared library that your circle can draw from freely. '
              'Contributions are attributed to the author and rated by usefulness so the best content rises to the top.',
          icon: Icons.menu_book_rounded,
        ),
        SampleContentItem(
          title: 'Circle Wellbeing Pulse',
          subtitle:
              'Run anonymous wellbeing pulse surveys across your circle to surface stress, burnout risk, or unmet needs. '
              'Aggregate results guide where to direct care energy without exposing any individual\'s private responses.',
          icon: Icons.monitor_heart_rounded,
        ),
      ],
    );
  }
}
