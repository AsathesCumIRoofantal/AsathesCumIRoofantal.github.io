import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'get_connected_controller.dart';

class GetConnectedView extends GetView<GetConnectedController> {
  const GetConnectedView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SampleContentPage(
      title: 'Get Connected',
      subtitle:
          'Practise healthy social graph hygiene — curating who you follow, why you follow them, and what each connection is actually doing to your thinking. '
          'A well-tended network amplifies your best work; an untended one quietly shapes your beliefs without your consent.',
      icon: Icons.hub_rounded,
      items: [
        SampleContentItem(
          title: 'Connection Intent Audit',
          subtitle:
              'Review each significant connection and articulate the mutual value it creates — learning, collaboration, support, or inspiration. '
              'Connections without a clear intent tend to become noise; naming the intent transforms them into deliberate relationships.',
          icon: Icons.manage_accounts_rounded,
        ),
        SampleContentItem(
          title: 'Follow Quality Score',
          subtitle:
              'Rate the accounts and feeds you follow on a signal-to-noise scale, then prune or mute the ones that consistently lower your thinking quality. '
              'What you consume shapes what you produce — a high-quality follow list is one of the highest-leverage investments you can make.',
          icon: Icons.tune_rounded,
        ),
        SampleContentItem(
          title: 'Weak Tie Activator',
          subtitle:
              'Identify dormant connections that once had value and send a brief, genuine re-engagement message to reactivate the relationship. '
              'Research consistently shows that weak ties — not close friends — are the source of most breakthrough opportunities.',
          icon: Icons.link_rounded,
        ),
        SampleContentItem(
          title: 'Diverse Perspective Tracker',
          subtitle:
              'Monitor the ideological, cultural, and professional diversity of your active network to guard against echo-chamber drift. '
              'Diversity in your social graph is not a moral checkbox — it is a cognitive advantage that keeps your models of the world accurate.',
          icon: Icons.diversity_3_rounded,
        ),
        SampleContentItem(
          title: 'Reciprocity Ledger',
          subtitle:
              'Track the give-and-take balance in your key relationships to ensure you are contributing as much as you are drawing. '
              'Sustainable networks are built on reciprocity; the ledger makes imbalances visible before they erode trust.',
          icon: Icons.balance_rounded,
        ),
        SampleContentItem(
          title: 'Network Health Dashboard',
          subtitle:
              'See a visual summary of your connection activity — new links formed, dormant links, and the overall growth trajectory of your social graph. '
              'The dashboard turns an invisible asset into a measurable one, making intentional network-building a regular practice.',
          icon: Icons.analytics_rounded,
        ),
      ],
    );
  }
}
