import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'control_coordination_controller.dart';

class ControlCoordinationView extends GetView<ControlCoordinationController> {
  final bool isEmbedded;
  const ControlCoordinationView({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Control & Coordination',
      subtitle:
          'Define who pulls which levers, when, and under what conditions — so authority is clear and action is swift. '
          'AIR maps control structures and coordination protocols to eliminate confusion during critical moments.',
      icon: Icons.settings_suggest_outlined,
      items: const [
        SampleContentItem(
          title: 'Authority Matrix',
          subtitle:
              'Document who has decision-making authority for each domain, resource, or action type. '
              'A clear authority matrix prevents both paralysis from unclear ownership and reckless unilateral action.',
          icon: Icons.account_balance_outlined,
        ),
        SampleContentItem(
          title: 'Control Points',
          subtitle:
              'Identify the specific levers, gates, and checkpoints that govern key processes or systems. '
              'Mapping control points makes it easy to see where bottlenecks form and where single points of failure exist.',
          icon: Icons.tune,
        ),
        SampleContentItem(
          title: 'Coordination Protocols',
          subtitle:
              'Define how teams or individuals synchronise their actions — handoff procedures, communication channels, and timing rules. '
              'Explicit protocols reduce coordination overhead and prevent costly misalignments during execution.',
          icon: Icons.sync_alt,
        ),
        SampleContentItem(
          title: 'Delegation Register',
          subtitle:
              'Track every delegated authority — who delegated what, to whom, under which conditions, and for how long. '
              'A delegation register prevents authority gaps when key people are unavailable and supports audit trails.',
          icon: Icons.transfer_within_a_station_outlined,
        ),
        SampleContentItem(
          title: 'Conflict Resolution Rules',
          subtitle:
              'Pre-agree how conflicting instructions or competing priorities are resolved when two controllers disagree. '
              'Clear tiebreaker rules keep operations moving and prevent escalation into personal disputes.',
          icon: Icons.balance_outlined,
        ),
        SampleContentItem(
          title: 'Control Effectiveness Review',
          subtitle:
              'Periodically test whether controls are actually working as designed and whether coordination is happening as intended. '
              'Regular reviews catch drift between documented procedures and real-world behaviour before it causes harm.',
          icon: Icons.verified_outlined,
        ),
        SampleContentItem(
          title: 'Incident Command Log',
          subtitle:
              'During incidents, log every command issued, by whom, at what time, and what outcome it produced. '
              'A real-time command log is invaluable for post-incident review and for keeping distributed teams aligned.',
          icon: Icons.crisis_alert,
        ),
      ],
    );
  }
}



