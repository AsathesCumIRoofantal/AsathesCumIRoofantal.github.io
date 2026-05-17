import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'engagements_controller.dart';

class EngagementsView extends GetView<EngagementsController> {
  final bool isEmbedded;
  const EngagementsView({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Engagements',
      subtitle:
          'Track every event, RSVP, and follow-up task that keeps your team connected. '
          'Stay on top of engagement metrics to measure participation and drive accountability.',
      icon: Icons.event_available,
      items: const [
        SampleContentItem(
          title: 'Upcoming Events',
          subtitle:
              'Browse all scheduled engagements with date, venue, and organiser details. '
              'Filter by category to quickly find the events most relevant to your role.',
          icon: Icons.calendar_today,
        ),
        SampleContentItem(
          title: 'RSVP Management',
          subtitle:
              'Confirm or decline attendance for any event directly from this module. '
              'Your RSVP status is synced in real time so organisers always have an accurate headcount.',
          icon: Icons.how_to_reg,
        ),
        SampleContentItem(
          title: 'Attendance Records',
          subtitle:
              'View a complete history of events you attended, missed, or were excused from. '
              'Attendance data feeds into your overall engagement score visible to supervisors.',
          icon: Icons.checklist_rtl,
        ),
        SampleContentItem(
          title: 'Follow-Up Tasks',
          subtitle:
              'Each engagement can generate action items assigned to specific individuals. '
              'Track task status, due dates, and completion evidence all in one place.',
          icon: Icons.task_alt,
        ),
        SampleContentItem(
          title: 'Engagement Analytics',
          subtitle:
              'Visualise participation trends across teams, departments, or time periods. '
              'Use these insights to identify low-engagement areas and plan targeted interventions.',
          icon: Icons.bar_chart,
        ),
        SampleContentItem(
          title: 'Notifications & Reminders',
          subtitle:
              'Receive timely push alerts for upcoming events and overdue follow-up tasks. '
              'Customise reminder frequency so nothing slips through the cracks.',
          icon: Icons.notifications_active,
        ),
        SampleContentItem(
          title: 'Create New Engagement',
          subtitle:
              'Schedule a new event, set the agenda, and invite participants in minutes. '
              'Attach supporting documents and link related tasks before publishing.',
          icon: Icons.add_circle_outline,
        ),
      ],
    );
  }
}



