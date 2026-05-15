import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'merits_demerits_controller.dart';

class MeritsDemeritsView extends GetView<MeritsDemeritsController> {
  const MeritsDemeritsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Merits & Demerits',
      subtitle:
          'Maintain a balanced, transparent record of commendations and disciplinary marks on a single platform. '
          'Fair evaluation requires seeing both sides of the ledger — achievements and areas for improvement.',
      icon: Icons.balance,
      items: const [
        SampleContentItem(
          title: 'Merit Awards',
          subtitle:
              'Record formal commendations, certificates of excellence, and outstanding-performance citations. '
              'Each merit entry includes the awarding authority, date, and specific reason for recognition.',
          icon: Icons.emoji_events,
        ),
        SampleContentItem(
          title: 'Demerit Entries',
          subtitle:
              'Log disciplinary marks, warnings, and conduct violations with full contextual details. '
              'Demerit records are linked to the relevant policy clause to ensure procedural fairness.',
          icon: Icons.warning_amber,
        ),
        SampleContentItem(
          title: 'Net Score Dashboard',
          subtitle:
              'View a running net score that weighs merits against demerits over any selected period. '
              'The dashboard gives supervisors an at-a-glance picture of an individual\'s overall standing.',
          icon: Icons.dashboard,
        ),
        SampleContentItem(
          title: 'Appeal & Review',
          subtitle:
              'Submit a formal appeal against any demerit entry directly within the module. '
              'Appeals are routed to the reviewing authority with all supporting evidence attached.',
          icon: Icons.gavel,
        ),
        SampleContentItem(
          title: 'Trend Analysis',
          subtitle:
              'Analyse merit and demerit trends across teams or departments over time. '
              'Identify patterns that signal systemic issues or highlight consistently high performers.',
          icon: Icons.show_chart,
        ),
        SampleContentItem(
          title: 'Expiry & Archiving',
          subtitle:
              'Configure automatic expiry rules so older entries age off the active record appropriately. '
              'Archived entries remain accessible for historical audits but no longer affect the net score.',
          icon: Icons.archive,
        ),
      ],
    );
  }
}
