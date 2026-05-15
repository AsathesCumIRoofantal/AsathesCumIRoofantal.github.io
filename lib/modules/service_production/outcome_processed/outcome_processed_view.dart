import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'outcome_processed_controller.dart';

class OutcomeProcessedView extends GetView<OutcomeProcessedController> {
  const OutcomeProcessedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SampleContentPage(
      title: 'Outcome Processed',
      subtitle:
          'Access the finished artefacts, receipts, and verified records produced once a work item completes processing. '
          'Every outcome is signed, timestamped, and stored so stakeholders can retrieve proof of completion at any time.',
      icon: Icons.task_alt_rounded,
      items: [
        SampleContentItem(
          title: 'Completed Artefact Library',
          subtitle:
              'Browse all processed outputs — reports, datasets, certificates, and documents — organised by date and category. '
              'Full-text search and tag filters make it fast to locate any specific artefact across thousands of records.',
          icon: Icons.folder_special_rounded,
        ),
        SampleContentItem(
          title: 'Completion Receipts',
          subtitle:
              'Every finished job generates a tamper-evident receipt capturing who processed it, when, and what the output was. '
              'Receipts can be shared with clients or auditors as proof of service delivery without exposing raw data.',
          icon: Icons.receipt_long_rounded,
        ),
        SampleContentItem(
          title: 'Output Quality Score',
          subtitle:
              'Each processed outcome is automatically scored against predefined quality criteria before it is released. '
              'Items that fall below the threshold are flagged for human review rather than silently passed downstream.',
          icon: Icons.verified_rounded,
        ),
        SampleContentItem(
          title: 'Delivery Confirmation',
          subtitle:
              'Track whether each completed output has been delivered to its intended recipient and acknowledged. '
              'Unacknowledged deliveries trigger a follow-up reminder after a configurable grace period.',
          icon: Icons.mark_email_read_rounded,
        ),
        SampleContentItem(
          title: 'Export & Download Centre',
          subtitle:
              'Download processed artefacts in PDF, CSV, JSON, or XML format with a single tap. '
              'Bulk export lets authorised users package an entire date range of outcomes for archival or handover.',
          icon: Icons.download_for_offline_rounded,
        ),
        SampleContentItem(
          title: 'Outcome Analytics',
          subtitle:
              'Review aggregate statistics on processed volumes, average turnaround times, and quality pass rates. '
              'Trend charts reveal whether output quality is improving or degrading across successive processing cycles.',
          icon: Icons.bar_chart_rounded,
        ),
      ],
    );
  }
}
