import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'ground_task_controller.dart';

class GroundTaskView extends GetView<GroundTaskController> {
  const GroundTaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Ground Task',
      subtitle:
          'Manage on-site field work orders from assignment through to verified completion. '
          'Proof of completion — photos, signatures, and GPS stamps — is captured directly in the app.',
      icon: Icons.construction,
      items: const [
        SampleContentItem(
          title: 'Active Work Orders',
          subtitle:
              'View all field tasks currently assigned to you, sorted by priority and due date. '
              'Each work order includes location details, required tools, and safety briefing notes.',
          icon: Icons.assignment,
        ),
        SampleContentItem(
          title: 'Task Check-In',
          subtitle:
              'Check in at the task site using GPS verification to log your arrival time. '
              'Check-in data is automatically attached to the work order for supervisor review.',
          icon: Icons.location_on,
        ),
        SampleContentItem(
          title: 'Photo Evidence',
          subtitle:
              'Capture before-and-after photos directly within the task record. '
              'Images are geo-tagged and timestamped to provide tamper-evident proof of completion.',
          icon: Icons.add_a_photo,
        ),
        SampleContentItem(
          title: 'Digital Sign-Off',
          subtitle:
              'Obtain a digital signature from the on-site supervisor to confirm task acceptance. '
              'Sign-off is recorded with a timestamp and stored against the work order permanently.',
          icon: Icons.draw,
        ),
        SampleContentItem(
          title: 'Incident Reporting',
          subtitle:
              'Log any safety incidents, near-misses, or equipment issues encountered during the task. '
              'Incident reports are escalated automatically to the relevant safety officer.',
          icon: Icons.report_problem,
        ),
        SampleContentItem(
          title: 'Task History',
          subtitle:
              'Review all completed and cancelled work orders with their full audit trail. '
              'Filter by date range, location, or task type to generate compliance reports.',
          icon: Icons.history,
        ),
      ],
    );
  }
}
