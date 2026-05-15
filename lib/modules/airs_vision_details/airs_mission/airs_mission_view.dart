import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'airs_mission_controller.dart';

class AirsMissionView extends GetView<AirsMissionController> {
  const AirsMissionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SampleContentPage(
      title: "AIR's Mission",
      subtitle:
          'Understand the non-negotiable commitments and strategic priorities that define what AIR stands for and why it exists. '
          'The mission is not a slogan — it is the decision filter applied every time AIR faces a trade-off.',
      icon: Icons.flag_rounded,
      items: [
        SampleContentItem(
          title: 'Core Mission Statement',
          subtitle:
              'AIR exists to revolutionise industrial coordination through autonomous digitisation and community-driven verification. '
              'Every feature, policy, and partnership is evaluated against this statement before it is approved.',
          icon: Icons.stars_rounded,
        ),
        SampleContentItem(
          title: 'Strategic Priorities',
          subtitle:
              'A ranked list of the three to five outcomes AIR is optimising for in the current operating period. '
              'Priorities are reviewed quarterly and updated transparently so every team member knows where to focus energy.',
          icon: Icons.format_list_numbered_rounded,
        ),
        SampleContentItem(
          title: 'Non-Negotiable Commitments',
          subtitle:
              'Certain principles — data integrity, user privacy, and equitable access — are never traded away for speed or profit. '
              'This section documents those commitments explicitly so they cannot be quietly eroded over time.',
          icon: Icons.gavel_rounded,
        ),
        SampleContentItem(
          title: 'Mission Alignment Check',
          subtitle:
              'Before launching any new initiative, run it through the mission alignment checklist to confirm it serves the core purpose. '
              'Misaligned initiatives are redirected or shelved, keeping the roadmap coherent and focused.',
          icon: Icons.checklist_rounded,
        ),
        SampleContentItem(
          title: 'Stakeholder Commitments',
          subtitle:
              'Document the specific promises AIR has made to users, partners, and communities — and track delivery against each one. '
              'Transparency about commitments builds the trust that makes long-term collaboration possible.',
          icon: Icons.handshake_rounded,
        ),
        SampleContentItem(
          title: 'Mission History & Evolution',
          subtitle:
              'A versioned record of how the mission statement has evolved since AIR\'s founding, with the reasoning behind each change. '
              'Understanding the evolution prevents revisionism and helps new members grasp the depth of the current direction.',
          icon: Icons.history_edu_rounded,
        ),
      ],
    );
  }
}
