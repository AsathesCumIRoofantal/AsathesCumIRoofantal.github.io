import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'court_cases_controller.dart';

class CourtCasesView extends GetView<CourtCasesController> {
  final bool isEmbedded;
  const CourtCasesView({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Court Cases',
      subtitle:
          'Maintain informational case files covering dockets, hearing schedules, and counsel coordination. '
          'This module provides a structured reference — not legal advice — to keep all parties informed.',
      icon: Icons.account_balance,
      items: const [
        SampleContentItem(
          title: 'Case Docket',
          subtitle:
              'View the full docket for each case including case number, parties involved, and current status. '
              'Docket entries are updated as new filings and orders are received from the court.',
          icon: Icons.folder_open,
        ),
        SampleContentItem(
          title: 'Hearing Schedule',
          subtitle:
              'Track upcoming hearing dates, venues, and required attendees for each active case. '
              'Calendar reminders are sent to relevant personnel well in advance of each hearing.',
          icon: Icons.event,
        ),
        SampleContentItem(
          title: 'Document Repository',
          subtitle:
              'Store and organise all case-related documents including pleadings, affidavits, and orders. '
              'Documents are version-controlled and access is restricted to authorised personnel only.',
          icon: Icons.folder_special,
        ),
        SampleContentItem(
          title: 'Counsel Coordination',
          subtitle:
              'Log communications and instructions exchanged with legal counsel for each case. '
              'Coordination records help ensure continuity when personnel or counsel changes occur.',
          icon: Icons.connect_without_contact,
        ),
        SampleContentItem(
          title: 'Case Timeline',
          subtitle:
              'Visualise the full chronological history of a case from filing through to resolution. '
              'Timelines make it easy to brief new team members and prepare for upcoming hearings.',
          icon: Icons.timeline,
        ),
        SampleContentItem(
          title: 'Outcome & Closure',
          subtitle:
              'Record the final judgement or settlement outcome and close the case file formally. '
              'Closed cases are archived with all documents intact for future reference and appeals.',
          icon: Icons.gavel,
        ),
      ],
    );
  }
}



