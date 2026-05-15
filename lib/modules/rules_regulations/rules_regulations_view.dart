import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'rules_regulations_controller.dart';

class RulesRegulationsView extends GetView<RulesRegulationsController> {
  const RulesRegulationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Rules & Regulations',
      subtitle:
          'Navigate the full rules corpus — what is permitted, what is prohibited, and what falls in the grey zone. '
          'Clear, searchable policy content helps everyone act with confidence and stay compliant.',
      icon: Icons.menu_book,
      items: const [
        SampleContentItem(
          title: 'Permitted Actions',
          subtitle:
              'Browse the definitive list of actions, behaviours, and practices that are explicitly allowed. '
              'Each entry cites the relevant policy clause so you can verify the source directly.',
          icon: Icons.check_circle_outline,
        ),
        SampleContentItem(
          title: 'Prohibited Conduct',
          subtitle:
              'Review all actions and behaviours that are strictly forbidden, along with associated penalties. '
              'Prohibited conduct entries are linked to disciplinary procedures for full context.',
          icon: Icons.block,
        ),
        SampleContentItem(
          title: 'Grey-Zone Guidance',
          subtitle:
              'Explore situations where the rules are ambiguous and official guidance has been issued. '
              'Grey-zone entries include real-world examples and recommended courses of action.',
          icon: Icons.help_outline,
        ),
        SampleContentItem(
          title: 'Policy Search',
          subtitle:
              'Search the entire rules corpus by keyword, policy number, or topic to find answers fast. '
              'Search results are ranked by relevance and include direct links to the source document.',
          icon: Icons.search,
        ),
        SampleContentItem(
          title: 'Recent Amendments',
          subtitle:
              'Stay up to date with the latest changes to rules and regulations as they are published. '
              'Amendment notifications are pushed to all affected personnel automatically.',
          icon: Icons.update,
        ),
        SampleContentItem(
          title: 'Compliance Acknowledgement',
          subtitle:
              'Confirm that you have read and understood key policy updates with a digital acknowledgement. '
              'Acknowledgement records are stored and visible to supervisors for compliance tracking.',
          icon: Icons.verified,
        ),
      ],
    );
  }
}
