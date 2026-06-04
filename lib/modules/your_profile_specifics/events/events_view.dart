import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'events_controller.dart';

class EventsView extends GetView<EventsController> {
  final bool isEmbedded;
  const EventsView({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Events',
      subtitle:
          'Manage your full schedule of AIR and profile-linked events — plan ahead, confirm attendance, and follow up on outcomes so nothing slips through the cracks. '
          'Events are more than calendar entries here; they are structured commitments with context, participants, and post-event accountability built in.',
      icon: Icons.event_available_rounded,
      items: [
        SampleContentItem(
          title: 'Upcoming Events',
          subtitle:
              'See all events on your horizon — meetings, workshops, reviews, community gatherings, and AIR milestones — sorted by date with full context on purpose and participants. '
              'Upcoming events are flagged with preparation reminders so you arrive ready, not scrambling.',
          icon: Icons.upcoming_rounded,
        ),
        SampleContentItem(
          title: 'Event Registration',
          subtitle:
              'Browse open events across the AIR network and register your attendance with a single tap — capacity limits, prerequisites, and joining instructions are shown upfront. '
              'Registration is confirmed instantly and added to your calendar with all the details you need to show up prepared.',
          icon: Icons.how_to_reg_rounded,
        ),
        SampleContentItem(
          title: 'Event Creation',
          subtitle:
              'Create and publish your own events — set the purpose, invite participants, define the agenda, and choose whether the event is open to the broader AIR community or restricted to a specific group. '
              'Well-structured events attract the right people and produce better outcomes; AIR\'s creation tools guide you through every field that matters.',
          icon: Icons.add_circle_rounded,
        ),
        SampleContentItem(
          title: 'Confirmations & RSVPs',
          subtitle:
              'Track who has confirmed attendance for your events and send reminders to those who have not yet responded — with one-tap follow-up for pending RSVPs. '
              'Confirmation data helps you plan logistics accurately and signals to participants that their commitment is expected and valued.',
          icon: Icons.check_circle_rounded,
        ),
        SampleContentItem(
          title: 'Event Follow-Up',
          subtitle:
              'After each event, log outcomes, share notes, assign action items, and collect feedback from participants — all linked to the original event record. '
              'Follow-up is where events generate lasting value; without it, even the best session fades into a vague memory within a week.',
          icon: Icons.assignment_turned_in_rounded,
        ),
        SampleContentItem(
          title: 'Event History',
          subtitle:
              'Review a complete archive of past events you attended or hosted — with notes, outcomes, participant lists, and any action items that were generated. '
              'History is searchable and filterable, making it easy to find the context from a specific event months or years after it happened.',
          icon: Icons.history_rounded,
        ),
      ],
    );
  }
}
