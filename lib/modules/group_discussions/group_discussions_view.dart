import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'group_discussions_controller.dart';

class GroupDiscussionsView extends GetView<GroupDiscussionsController> {
  final bool isEmbedded;
  const GroupDiscussionsView({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Group Discussions',
      subtitle:
          'Facilitate structured group conversations with shared agendas, live notes, and clear action items. '
          'Every discussion is documented so decisions and commitments are never lost.',
      icon: Icons.forum,
      items: const [
        SampleContentItem(
          title: 'Create Discussion',
          subtitle:
              'Start a new facilitated discussion by setting the topic, participants, and time slot. '
              'Attach a pre-built agenda template or draft a custom one from scratch.',
          icon: Icons.add_comment,
        ),
        SampleContentItem(
          title: 'Agenda Builder',
          subtitle:
              'Structure your discussion with timed agenda items and designated speakers. '
              'Reorder items via drag-and-drop and share the agenda with participants before the session.',
          icon: Icons.format_list_bulleted,
        ),
        SampleContentItem(
          title: 'Live Notes',
          subtitle:
              'Capture key points, decisions, and quotes in real time during the discussion. '
              'Notes are auto-saved and visible to all participants immediately after the session.',
          icon: Icons.edit_note,
        ),
        SampleContentItem(
          title: 'Action Items',
          subtitle:
              'Convert discussion outcomes into trackable action items with owners and due dates. '
              'Action items sync with the Engagements module so nothing falls through the cracks.',
          icon: Icons.assignment_turned_in,
        ),
        SampleContentItem(
          title: 'Discussion Archive',
          subtitle:
              'Search and review all past group discussions by date, topic, or participant. '
              'Full transcripts and action-item completion rates are available for audit purposes.',
          icon: Icons.archive,
        ),
        SampleContentItem(
          title: 'Participant Insights',
          subtitle:
              'See contribution metrics for each participant across multiple discussion sessions. '
              'Use these insights to encourage balanced participation and identify quiet voices.',
          icon: Icons.insights,
        ),
      ],
    );
  }
}



