import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'maintenance_controller.dart';

class MaintenanceView extends GetView<MaintenanceController> {
  const MaintenanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SampleContentPage(
      title: 'Maintenance',
      subtitle:
          'Run health checks, schedule upkeep tasks, and set reminders so nothing in your AIR environment silently drifts into disrepair. '
          'Maintenance is the discipline of keeping things working well before they break — and AIR makes it easy to stay ahead of the curve rather than always reacting to it.',
      icon: Icons.build_circle_rounded,
      items: [
        SampleContentItem(
          title: 'Health Check Dashboard',
          subtitle:
              'View the current health status of all systems, assets, and processes under your care — green for healthy, amber for attention needed, red for immediate action required. '
              'The dashboard is updated in real time and designed to surface problems at the earliest possible stage, when they are still cheap to fix.',
          icon: Icons.monitor_heart_rounded,
        ),
        SampleContentItem(
          title: 'Scheduled Upkeep Tasks',
          subtitle:
              'Browse and manage all scheduled maintenance tasks — routine checks, periodic reviews, software updates, and physical inspections — with due dates and assigned owners. '
              'Scheduled tasks are the backbone of preventive maintenance; they exist precisely so you do not have to remember everything yourself.',
          icon: Icons.event_repeat_rounded,
        ),
        SampleContentItem(
          title: 'Maintenance Requests',
          subtitle:
              'Log and track maintenance requests raised by you or your team — each with a priority level, description, assigned technician, and current status. '
              'Requests are never lost in a chat thread; they live in a structured queue that is visible to everyone with a stake in the outcome.',
          icon: Icons.report_problem_rounded,
        ),
        SampleContentItem(
          title: 'Drift Alerts',
          subtitle:
              'Receive proactive alerts when AIR detects that a system, process, or asset is drifting from its expected baseline — before the drift becomes a failure. '
              'Drift alerts are the early-warning system that turns reactive maintenance into proactive stewardship.',
          icon: Icons.notifications_active_rounded,
        ),
        SampleContentItem(
          title: 'Maintenance History',
          subtitle:
              'Review the complete maintenance history for every asset and system — what was done, when, by whom, and what the outcome was — in a searchable, timestamped log. '
              'History is the foundation of good maintenance planning; patterns in past failures predict where future attention is most needed.',
          icon: Icons.history_rounded,
        ),
        SampleContentItem(
          title: 'Vendor & Service Contacts',
          subtitle:
              'Keep a curated directory of vendors, service providers, and technical contacts relevant to your maintenance responsibilities — with response-time ratings and contract details. '
              'Having the right contact at your fingertips when something breaks is the difference between a two-hour fix and a two-day outage.',
          icon: Icons.contacts_rounded,
        ),
      ],
    );
  }
}
