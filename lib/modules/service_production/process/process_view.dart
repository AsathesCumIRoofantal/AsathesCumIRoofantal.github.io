import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'process_controller.dart';

class ProcessView extends GetView<ProcessController> {
  const ProcessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SampleContentPage(
      title: 'Process',
      subtitle:
          'Govern the middle state of every AIR work item — defining rules, assigning owners, and enforcing SLAs while work is actively underway. '
          'A well-managed process stage is the difference between predictable delivery and chaotic firefighting.',
      icon: Icons.settings_suggest_rounded,
      items: [
        SampleContentItem(
          title: 'Active Job Dashboard',
          subtitle:
              'See every work item currently in flight, with real-time progress bars, assigned owners, and elapsed time. '
              'Colour-coded urgency bands make it instantly clear which jobs need attention before their SLA expires.',
          icon: Icons.dashboard_rounded,
        ),
        SampleContentItem(
          title: 'Process Rules Engine',
          subtitle:
              'Define the conditional logic that governs how items move through each stage — approvals, escalations, and auto-routing. '
              'Rules are version-controlled so changes are auditable and rollbacks are one click away.',
          icon: Icons.account_tree_rounded,
        ),
        SampleContentItem(
          title: 'Owner Assignment',
          subtitle:
              'Allocate each in-flight item to a responsible individual or team with a clear mandate and deadline. '
              'Workload balancing suggestions surface automatically when any owner is approaching capacity.',
          icon: Icons.person_pin_rounded,
        ),
        SampleContentItem(
          title: 'SLA Tracker',
          subtitle:
              'Monitor service-level agreement compliance for every active job in real time. '
              'Breach predictions are raised 20 % before the deadline so owners can act before a miss is recorded.',
          icon: Icons.timer_rounded,
        ),
        SampleContentItem(
          title: 'Throughput Optimiser',
          subtitle:
              'Analyse bottlenecks across the current process stage and surface recommendations to redistribute load. '
              'One-tap optimisation rebalances queues without interrupting jobs already in progress.',
          icon: Icons.tune_rounded,
        ),
        SampleContentItem(
          title: 'Escalation Pathways',
          subtitle:
              'Configure multi-tier escalation chains so stalled or high-risk items automatically reach the right decision-maker. '
              'Each escalation is logged with reason, timestamp, and resolution outcome for future process improvement.',
          icon: Icons.escalator_warning_rounded,
        ),
      ],
    );
  }
}
