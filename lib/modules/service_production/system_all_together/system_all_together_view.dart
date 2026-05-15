import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'system_all_together_controller.dart';

class SystemAllTogetherView extends GetView<SystemAllTogetherController> {
  const SystemAllTogetherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SampleContentPage(
      title: 'System All Together',
      subtitle:
          'Step back and see the entire AIR operation as one interconnected system — inputs, processes, outcomes, people, and feedback loops all in one view. '
          'Understanding how every part interlocks is the foundation for making changes that improve the whole rather than just one corner.',
      icon: Icons.hub_rounded,
      items: [
        SampleContentItem(
          title: 'System Health Overview',
          subtitle:
              'A single-screen health score aggregates the status of every AIR component — pipeline, people, data, and delivery. '
              'Drill into any component to see its individual metrics without losing sight of the overall picture.',
          icon: Icons.monitor_heart_rounded,
        ),
        SampleContentItem(
          title: 'Component Dependency Map',
          subtitle:
              'Visualise how each module depends on others so you can predict the blast radius of any change or failure. '
              'Dependency paths are automatically updated whenever a new integration or workflow is added.',
          icon: Icons.account_tree_rounded,
        ),
        SampleContentItem(
          title: 'Cross-Module Data Flow',
          subtitle:
              'Trace how a single input travels through classification, processing, and delivery across multiple modules. '
              'Flow diagrams highlight handoff points where delays or data loss most commonly occur.',
          icon: Icons.swap_horiz_rounded,
        ),
        SampleContentItem(
          title: 'Global Sync Control',
          subtitle:
              'Trigger a coordinated synchronisation across all AIR subsystems to resolve drift and ensure consistency. '
              'Sync events are scheduled during low-traffic windows and logged for post-sync verification.',
          icon: Icons.sync_rounded,
        ),
        SampleContentItem(
          title: 'Capacity & Load Balance',
          subtitle:
              'View aggregate resource utilisation across all active components and identify where headroom is thin. '
              'Automated load-balancing recommendations help distribute work before any single node becomes a bottleneck.',
          icon: Icons.balance_rounded,
        ),
        SampleContentItem(
          title: 'Incident Impact Analyser',
          subtitle:
              'When something goes wrong, instantly see which downstream components are affected and in what order. '
              'Impact scores help prioritise the recovery sequence so the most critical services are restored first.',
          icon: Icons.crisis_alert_rounded,
        ),
        SampleContentItem(
          title: 'System Changelog',
          subtitle:
              'A chronological record of every structural change made to the AIR system — new integrations, rule updates, and configuration edits. '
              'Each entry links to the responsible operator and the business reason behind the change.',
          icon: Icons.history_rounded,
        ),
      ],
    );
  }
}
