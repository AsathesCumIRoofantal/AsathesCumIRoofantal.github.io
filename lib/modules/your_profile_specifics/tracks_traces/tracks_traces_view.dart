import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'tracks_traces_controller.dart';

class TracksTracesView extends GetView<TracksTracesController> {
  final bool isEmbedded;
  const TracksTracesView({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    return const SampleContentPage(
      title: 'Tracks & Traces',
      subtitle:
          'Maintain audit-style trails that record who did what, when, and why — so accountability stays crisp and nothing can be quietly revised after the fact. '
          'Tracks and traces are not surveillance; they are the shared memory that makes trust possible in complex, multi-party environments.',
      icon: Icons.manage_search_rounded,
      items: [
        SampleContentItem(
          title: 'Activity Audit Trail',
          subtitle:
              'Review a timestamped, tamper-evident log of all significant actions taken within your AIR environment — by you, your team, or anyone with access to shared resources. '
              'The audit trail is the ground truth of what happened; it resolves disputes, supports investigations, and provides the context that memory alone cannot.',
          icon: Icons.receipt_long_rounded,
        ),
        SampleContentItem(
          title: 'Change History',
          subtitle:
              'Track every change made to documents, settings, records, and configurations — with the original value, the new value, the person who made the change, and the timestamp. '
              'Change history makes it possible to understand how a situation evolved and to reverse a change if it turns out to have been a mistake.',
          icon: Icons.history_rounded,
        ),
        SampleContentItem(
          title: 'Access Logs',
          subtitle:
              'See who accessed which resources, when, and from where — a clear record of every interaction with sensitive data, restricted areas, or shared assets. '
              'Access logs are the first line of defence against both accidental misuse and deliberate misconduct.',
          icon: Icons.lock_clock_rounded,
        ),
        SampleContentItem(
          title: 'Decision Trace',
          subtitle:
              'Document the reasoning behind significant decisions — what information was available, what options were considered, and why the chosen path was taken. '
              'Decision traces are invaluable when a choice is later questioned; they show that the decision was made thoughtfully, not arbitrarily.',
          icon: Icons.account_tree_rounded,
        ),
        SampleContentItem(
          title: 'Anomaly Detection',
          subtitle:
              'Receive alerts when AIR detects unusual patterns in your tracks and traces — unexpected access, out-of-hours activity, or actions that deviate from established norms. '
              'Anomaly detection turns passive logging into active protection, surfacing concerns before they become incidents.',
          icon: Icons.warning_amber_rounded,
        ),
        SampleContentItem(
          title: 'Trace Export & Reporting',
          subtitle:
              'Export trace data in structured formats for compliance reporting, external audits, or internal reviews — with filtering options to scope the export to exactly what is needed. '
              'Exportable traces mean you are always ready for an audit, not scrambling to reconstruct a timeline when one is requested.',
          icon: Icons.file_download_rounded,
        ),
      ],
    );
  }
}
