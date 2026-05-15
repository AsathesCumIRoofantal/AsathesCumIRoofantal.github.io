import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'obligations_controller.dart';

class ObligationsView extends GetView<ObligationsController> {
  const ObligationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Obligations',
      subtitle:
          'Track every legal, moral, and contractual commitment so nothing slips through the cracks. '
          'AIR surfaces due dates, counterparties, and breach risks in one accountable view.',
      icon: Icons.gavel,
      items: const [
        SampleContentItem(
          title: 'Active Commitments',
          subtitle:
              'List every obligation currently in force — contracts, promises, regulatory duties, and court orders. '
              'Each entry carries a due date, responsible party, and current status so you always know what is outstanding.',
          icon: Icons.checklist_rtl,
        ),
        SampleContentItem(
          title: 'Counterparty Registry',
          subtitle:
              'Record who holds each obligation against you and who you hold obligations against. '
              'Linking counterparties to commitments makes it easy to spot conflicts of interest or overlapping duties.',
          icon: Icons.handshake_outlined,
        ),
        SampleContentItem(
          title: 'Breach & Risk Alerts',
          subtitle:
              'Set thresholds that trigger warnings before a deadline is missed or a condition is violated. '
              'Early alerts give you time to renegotiate, escalate, or remediate before a breach becomes costly.',
          icon: Icons.warning_amber_rounded,
        ),
        SampleContentItem(
          title: 'Compliance Evidence',
          subtitle:
              'Attach documents, receipts, and audit trails that prove each obligation has been met. '
              'Structured evidence chains make regulatory reviews and legal disputes far less stressful.',
          icon: Icons.folder_copy_outlined,
        ),
        SampleContentItem(
          title: 'Obligation Lifecycle',
          subtitle:
              'Track how each commitment was created, amended, fulfilled, or discharged over time. '
              'A full lifecycle view prevents disputes about what was agreed and when changes were made.',
          icon: Icons.timeline,
        ),
        SampleContentItem(
          title: 'Moral & Informal Duties',
          subtitle:
              'Capture non-legal obligations — personal promises, community commitments, and ethical pledges. '
              'Treating informal duties with the same rigor as contracts builds trust and personal integrity.',
          icon: Icons.volunteer_activism,
        ),
        SampleContentItem(
          title: 'Obligation Dashboard',
          subtitle:
              'See all commitments ranked by urgency, risk level, and counterparty importance on a single screen. '
              'The dashboard highlights overdue items in red and upcoming deadlines in amber so nothing is overlooked.',
          icon: Icons.dashboard_outlined,
        ),
      ],
    );
  }
}
