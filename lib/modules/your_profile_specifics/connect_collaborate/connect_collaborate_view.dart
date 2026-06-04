import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'connect_collaborate_controller.dart';

class ConnectCollaborateView extends GetView<ConnectCollaborateController> {
  final bool isEmbedded;
  const ConnectCollaborateView({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    return const SampleContentPage(
      title: 'Connect & Collaborate',
      subtitle:
          'Find the right partners, co-create with purpose, and keep every collaboration visible and accountable in one place. '
          'AIR surfaces people whose skills, values, and goals complement yours — so connections lead to real work, not just a growing contact list.',
      icon: Icons.handshake_rounded,
      items: [
        SampleContentItem(
          title: 'Partner Discovery',
          subtitle:
              'Browse AIR-curated profiles of potential collaborators — filtered by skills, interests, availability, and alignment with your current goals. '
              'Discovery is not random; AIR uses your profile to surface people who are genuinely likely to produce something valuable with you.',
          icon: Icons.person_search_rounded,
        ),
        SampleContentItem(
          title: 'Collaboration Proposals',
          subtitle:
              'Send and receive structured collaboration proposals — each with a clear purpose, defined roles, expected timeline, and mutual commitments. '
              'Structured proposals replace vague "let\'s work together" messages with agreements that both parties actually understand before they start.',
          icon: Icons.send_rounded,
        ),
        SampleContentItem(
          title: 'Active Collaborations',
          subtitle:
              'Track all your live collaborations in one view — current status, recent activity, open tasks, and any blockers that need attention. '
              'Visibility keeps collaborations healthy; when both parties can see the same picture, misalignment surfaces early and gets resolved quickly.',
          icon: Icons.group_work_rounded,
        ),
        SampleContentItem(
          title: 'Co-Creation Workspace',
          subtitle:
              'Access a shared workspace for each active collaboration — documents, task boards, decision logs, and communication threads all in one place. '
              'A dedicated workspace prevents the fragmentation that kills most collaborations; everything lives together so nothing gets lost.',
          icon: Icons.workspaces_rounded,
        ),
        SampleContentItem(
          title: 'Collaboration Outcomes',
          subtitle:
              'Document and publish the outcomes of completed collaborations — what was built, what was learned, and what each party contributed. '
              'Outcomes are the proof of collaboration; they build your reputation, validate your partners, and create a record that future collaborators can trust.',
          icon: Icons.task_alt_rounded,
        ),
        SampleContentItem(
          title: 'Network Map',
          subtitle:
              'Visualise your collaboration network — who you have worked with, how those connections are linked, and where the strongest relationships in your network cluster. '
              'The map reveals the shape of your professional world and highlights the gaps where new connections could open new possibilities.',
          icon: Icons.hub_rounded,
        ),
      ],
    );
  }
}
