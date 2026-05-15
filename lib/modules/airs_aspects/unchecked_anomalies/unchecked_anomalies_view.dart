import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import '../checked_anomalies/anomalies_controller.dart';

class UncheckedAnomaliesView extends GetView<AnomaliesController> {
  const UncheckedAnomaliesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SampleContentPage(
      title: 'Unchecked Anomalies',
      subtitle:
          'Manage open irregularities that still need triage, an assigned owner, or verification before they can be resolved and closed. '
          'Every unchecked anomaly is a potential risk — this module ensures nothing stays in limbo longer than necessary.',
      icon: Icons.report_problem_rounded,
      items: [
        SampleContentItem(
          title: 'Triage Queue',
          subtitle:
              'Review newly reported anomalies that have not yet been assessed for severity, urgency, or ownership. '
              'Triage is the first and most time-sensitive step — an untriaged anomaly is an unknown risk, and unknown risks compound.',
          icon: Icons.sort_rounded,
        ),
        SampleContentItem(
          title: 'Severity Classification',
          subtitle:
              'Assign a severity level — Critical, High, Medium, or Low — to each open anomaly based on its potential impact and the urgency of resolution. '
              'Accurate severity classification ensures that limited attention goes to the highest-risk items first.',
          icon: Icons.priority_high_rounded,
        ),
        SampleContentItem(
          title: 'Owner Assignment',
          subtitle:
              'Assign a named owner to each open anomaly so there is always a clear person responsible for driving it to resolution. '
              'Unowned anomalies are the most dangerous kind — they exist in the system but belong to no one, and they tend to stay open indefinitely.',
          icon: Icons.person_pin_rounded,
        ),
        SampleContentItem(
          title: 'Verification Checklist',
          subtitle:
              'Work through the verification checklist for each anomaly to confirm that the reported issue is real, reproducible, and correctly described before investigation begins. '
              'Verification prevents wasted effort on phantom issues and ensures that the investigation starts with accurate information.',
          icon: Icons.checklist_rounded,
        ),
        SampleContentItem(
          title: 'Escalation Protocol',
          subtitle:
              'Escalate anomalies that exceed the current owner\'s authority, require cross-team coordination, or have been open beyond the acceptable response window. '
              'Escalation is not failure — it is the responsible act of matching the problem to the right level of attention and authority.',
          icon: Icons.arrow_upward_rounded,
        ),
        SampleContentItem(
          title: 'Report New Anomaly',
          subtitle:
              'Submit a new anomaly report with a structured description, supporting evidence, and an initial severity estimate to start the resolution process. '
              'Clear, well-documented reports are resolved faster — the submission form guides you through the information that investigators need most.',
          icon: Icons.add_alert_rounded,
        ),
      ],
    );
  }
}
