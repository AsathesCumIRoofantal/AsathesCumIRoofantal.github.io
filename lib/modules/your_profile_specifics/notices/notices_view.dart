import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'notices_controller.dart';

class NoticesView extends GetView<NoticesController> {
  final bool isEmbedded;
  const NoticesView({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Notices',
      subtitle:
          'Stay on top of official notices that affect you — read them, acknowledge receipt, and archive them so you always have a record of what you were informed and when. '
          'Notices in AIR carry weight; they are not marketing messages but formal communications that may require action, compliance, or a documented response.',
      icon: Icons.announcement_rounded,
      items: [
        SampleContentItem(
          title: 'Unread Notices',
          subtitle:
              'View all notices that have been issued to you and not yet read — sorted by urgency, with the most time-sensitive items surfaced at the top. '
              'Unread notices are flagged prominently because missing an official communication is never a neutral act in AIR.',
          icon: Icons.mark_email_unread_rounded,
        ),
        SampleContentItem(
          title: 'Acknowledgement Required',
          subtitle:
              'See notices that require a formal acknowledgement — your confirmation that you have read, understood, and accepted the content. '
              'Acknowledgement creates a mutual record; it protects you as much as it protects the issuing party by establishing a clear baseline of shared understanding.',
          icon: Icons.how_to_reg_rounded,
        ),
        SampleContentItem(
          title: 'Action Items from Notices',
          subtitle:
              'Track any actions required by notices you have received — deadlines, forms to complete, decisions to make, or responses to submit. '
              'Action items are extracted automatically from notice content and added to your task list so nothing falls through the cracks.',
          icon: Icons.checklist_rounded,
        ),
        SampleContentItem(
          title: 'Notice Archive',
          subtitle:
              'Browse your complete archive of past notices — searchable by date, category, issuer, and keyword — so you can always retrieve the original communication. '
              'The archive is your permanent record of what you were told and when; it is the first place to look when a dispute arises about prior communication.',
          icon: Icons.archive_rounded,
        ),
        SampleContentItem(
          title: 'Notice Categories',
          subtitle:
              'Filter notices by category — policy updates, compliance requirements, system changes, community announcements, and personal notifications — to find what is relevant quickly. '
              'Categories help you triage your inbox and ensure that high-priority notice types never get buried under lower-stakes communications.',
          icon: Icons.category_rounded,
        ),
        SampleContentItem(
          title: 'Issue a Notice',
          subtitle:
              'Compose and issue official notices to individuals, teams, or the broader AIR community — with delivery confirmation, read tracking, and acknowledgement requests. '
              'Issuing a notice through AIR creates a formal record that is harder to dispute and easier to reference than an informal message.',
          icon: Icons.notification_add_rounded,
        ),
      ],
    );
  }
}
