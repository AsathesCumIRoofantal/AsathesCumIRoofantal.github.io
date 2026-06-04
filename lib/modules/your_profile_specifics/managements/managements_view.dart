import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'managements_controller.dart';

class ManagementsView extends GetView<ManagementsController> {
  final bool isEmbedded;
  const ManagementsView({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Managements',
      subtitle:
          'Exercise operational control over everything you steward — teams, assets, programmes, and processes — from a single, structured interface. '
          'Managements gives you the oversight tools to delegate clearly, track progress honestly, and intervene early when something is drifting off course.',
      icon: Icons.manage_accounts_rounded,
      items: [
        SampleContentItem(
          title: 'Team Oversight',
          subtitle:
              'View the current status of every team under your stewardship — active members, open assignments, blockers, and recent activity — in a single consolidated view. '
              'Oversight is not micromanagement; it is the situational awareness that lets you support your team without hovering over them.',
          icon: Icons.groups_rounded,
        ),
        SampleContentItem(
          title: 'Asset Registry',
          subtitle:
              'Maintain a live registry of all assets you are responsible for — physical, digital, or financial — with current status, assigned custodians, and maintenance schedules. '
              'A well-kept asset registry prevents the silent drift that turns manageable problems into expensive surprises.',
          icon: Icons.inventory_2_rounded,
        ),
        SampleContentItem(
          title: 'Programme Dashboard',
          subtitle:
              'Track the health of every programme you manage — milestones reached, risks flagged, resources consumed, and outcomes delivered — against the original plan. '
              'The dashboard is designed for honest reporting, not optimistic spin; it shows what is actually happening so you can act on reality.',
          icon: Icons.dashboard_rounded,
        ),
        SampleContentItem(
          title: 'Delegation Log',
          subtitle:
              'Record every task, decision, or responsibility you have delegated — to whom, with what authority, by what deadline, and with what expected outcome. '
              'A clear delegation log prevents the ambiguity that causes dropped balls and makes accountability conversations straightforward rather than contentious.',
          icon: Icons.assignment_ind_rounded,
        ),
        SampleContentItem(
          title: 'Escalation Pathways',
          subtitle:
              'Define and document the escalation pathways for issues that exceed your authority or require cross-functional input — so your team always knows where to go when something is beyond their scope. '
              'Clear escalation paths reduce decision paralysis and ensure problems reach the right level without unnecessary delay.',
          icon: Icons.escalator_warning_rounded,
        ),
        SampleContentItem(
          title: 'Performance Reviews',
          subtitle:
              'Schedule, conduct, and document performance reviews for the people and programmes you manage — with structured templates, historical context, and forward-looking development plans. '
              'Reviews are most valuable when they are regular and honest; AIR makes the logistics easy so the conversation can stay focused on substance.',
          icon: Icons.rate_review_rounded,
        ),
      ],
    );
  }
}
