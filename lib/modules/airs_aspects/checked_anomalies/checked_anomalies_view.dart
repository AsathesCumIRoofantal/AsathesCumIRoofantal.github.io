import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'anomalies_controller.dart';

class CheckedAnomaliesView extends GetView<AnomaliesController> {
  const CheckedAnomaliesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SampleContentPage(
      title: 'Checked Anomalies',
      subtitle:
          'Review irregularities that have been fully investigated, resolved, and closed — each with a documented rationale, named owner, and outcome record. '
          'Checked anomalies are not just closed tickets; they are institutional memory that prevents the same issues from recurring.',
      icon: Icons.verified_user_rounded,
      items: [
        SampleContentItem(
          title: 'Resolution Summary',
          subtitle:
              'Read a plain-language summary of how each anomaly was resolved — what was found, what was changed, and what was learned in the process. '
              'Summaries are written for future readers, not just the team that resolved the issue, so the knowledge transfers across time.',
          icon: Icons.summarize_rounded,
        ),
        SampleContentItem(
          title: 'Owner & Accountability Record',
          subtitle:
              'See who owned each anomaly through its lifecycle — who reported it, who investigated it, and who signed off on the resolution. '
              'Named ownership is not about blame; it is about creating a clear chain of responsibility that makes future accountability easier.',
          icon: Icons.assignment_ind_rounded,
        ),
        SampleContentItem(
          title: 'Root Cause Archive',
          subtitle:
              'Browse the documented root causes of resolved anomalies to identify systemic patterns that might require structural fixes rather than case-by-case responses. '
              'Root cause data is the most valuable output of any anomaly process — it is where prevention begins.',
          icon: Icons.account_tree_rounded,
        ),
        SampleContentItem(
          title: 'Resolution Timeline',
          subtitle:
              'Review the time-to-resolution data for closed anomalies to understand response speed, identify bottlenecks, and set realistic expectations for future cases. '
              'Timeline data is shared transparently to drive continuous improvement in the anomaly management process.',
          icon: Icons.schedule_rounded,
        ),
        SampleContentItem(
          title: 'Preventive Actions Log',
          subtitle:
              'Track the preventive actions taken after each resolution — process changes, guardrails added, or training delivered — to confirm that learning was applied. '
              'A resolution without a preventive action is a closed loop that will reopen; the log ensures follow-through.',
          icon: Icons.security_rounded,
        ),
        SampleContentItem(
          title: 'Anomaly Pattern Report',
          subtitle:
              'View aggregated reports that surface recurring anomaly types, high-risk areas, and seasonal patterns across the full history of checked cases. '
              'Pattern reports turn individual incidents into strategic intelligence that informs system design and risk management.',
          icon: Icons.analytics_rounded,
        ),
      ],
    );
  }
}
