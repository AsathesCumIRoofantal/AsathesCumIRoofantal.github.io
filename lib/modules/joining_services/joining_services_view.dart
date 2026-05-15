import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'joining_services_controller.dart';

class JoiningServicesView extends GetView<JoiningServicesController> {
  const JoiningServicesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Joining Services',
      subtitle:
          'Guide new members through every step of onboarding — from contracts and oaths to first-week plans. '
          'A structured joining process sets the right tone and ensures nothing is missed.',
      icon: Icons.how_to_reg,
      items: const [
        SampleContentItem(
          title: 'Joining Checklist',
          subtitle:
              'A comprehensive onboarding checklist that tracks every required step for a new joiner. '
              'Items are marked complete in real time so both the joiner and their supervisor stay aligned.',
          icon: Icons.checklist,
        ),
        SampleContentItem(
          title: 'Contract & Documentation',
          subtitle:
              'Upload, review, and digitally sign all joining contracts and service agreements. '
              'Documents are stored securely and accessible to authorised personnel at any time.',
          icon: Icons.article,
        ),
        SampleContentItem(
          title: 'Oath of Service',
          subtitle:
              'Record the formal oath or affirmation taken by the new member, including witness details. '
              'The oath record is timestamped and stored as a permanent part of the service file.',
          icon: Icons.handshake,
        ),
        SampleContentItem(
          title: 'First-Week Plan',
          subtitle:
              'Assign a structured first-week schedule covering orientation, introductions, and initial training. '
              'The plan is shared with the new joiner and their buddy or mentor before day one.',
          icon: Icons.today,
        ),
        SampleContentItem(
          title: 'Equipment & Access Issuance',
          subtitle:
              'Track the issuance of uniforms, equipment, ID cards, and system access credentials. '
              'Each item requires a digital acknowledgement from the recipient to confirm receipt.',
          icon: Icons.inventory,
        ),
        SampleContentItem(
          title: 'Buddy & Mentor Assignment',
          subtitle:
              'Pair each new joiner with an experienced buddy or mentor to support their transition. '
              'Buddy assignments are logged and check-in milestones are tracked over the first month.',
          icon: Icons.people,
        ),
        SampleContentItem(
          title: 'Joining Status Overview',
          subtitle:
              'Administrators can view the onboarding progress of all new joiners on a single dashboard. '
              'Overdue checklist items are highlighted so supervisors can intervene promptly.',
          icon: Icons.manage_accounts,
        ),
      ],
    );
  }
}
