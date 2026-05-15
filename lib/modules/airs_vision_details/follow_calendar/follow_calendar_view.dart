import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'follow_calendar_controller.dart';

class FollowCalendarView extends GetView<FollowCalendarController> {
  const FollowCalendarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SampleContentPage(
      title: 'Follow Calendar',
      subtitle:
          'Anchor your habits, commitments, and deadlines to a humane calendar that respects your energy and rhythm. '
          'A well-followed calendar is not a cage — it is the scaffold that makes consistent, sustainable progress possible.',
      icon: Icons.calendar_month_rounded,
      items: [
        SampleContentItem(
          title: 'Habit Anchors',
          subtitle:
              'Attach recurring habits to specific calendar slots so they become non-negotiable parts of your week. '
              'Habit anchors are colour-coded by domain — health, work, relationships — so your week is visually balanced at a glance.',
          icon: Icons.anchor_rounded,
        ),
        SampleContentItem(
          title: 'Deadline Tracker',
          subtitle:
              'Surface all upcoming deadlines in a single timeline view, sorted by urgency and linked to their parent commitments. '
              'Deadline proximity triggers automatic reminders at intervals you configure — not just the night before.',
          icon: Icons.event_busy_rounded,
        ),
        SampleContentItem(
          title: 'Energy-Aware Scheduling',
          subtitle:
              'Schedule demanding tasks during your self-reported peak energy windows and lighter tasks during recovery periods. '
              'The calendar learns your patterns over time and suggests optimal slots for new commitments.',
          icon: Icons.bolt_rounded,
        ),
        SampleContentItem(
          title: 'Cadence Reviews',
          subtitle:
              'Set up weekly, monthly, and quarterly review sessions that automatically populate with the right agenda items. '
              'Cadence reviews ensure you zoom out regularly and do not get permanently lost in the day-to-day.',
          icon: Icons.repeat_rounded,
        ),
        SampleContentItem(
          title: 'Buffer & Rest Blocks',
          subtitle:
              'Protect deliberate buffer time between commitments so unexpected tasks do not cascade into a crisis. '
              'Rest blocks are treated as first-class calendar entries and are not automatically overwritten by new bookings.',
          icon: Icons.self_improvement_rounded,
        ),
        SampleContentItem(
          title: 'Calendar Sync & Export',
          subtitle:
              'Sync your AIR calendar with external tools — Google Calendar, Outlook, or iCal — so everything stays in one place. '
              'Export any date range as a structured report for performance reviews or accountability check-ins.',
          icon: Icons.sync_alt_rounded,
        ),
      ],
    );
  }
}
