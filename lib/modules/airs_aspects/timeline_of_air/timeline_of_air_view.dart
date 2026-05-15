import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'timeline_of_air_controller.dart';

class TimelineOfAirView extends GetView<TimelineOfAirController> {
  const TimelineOfAirView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SampleContentPage(
      title: 'Timeline of AIR',
      subtitle:
          'Explore the historical milestones and upcoming beats of the organisation on a single, navigable timeline that connects past decisions to future direction. '
          'Understanding where AIR has been is essential context for understanding where it is going and why.',
      icon: Icons.timeline_rounded,
      items: [
        SampleContentItem(
          title: 'Founding Story',
          subtitle:
              'Read the origin story of AIR — the problem it was created to solve, the people who started it, and the first principles that have guided it since day one. '
              'Origin stories are not nostalgia; they are the clearest statement of an organisation\'s deepest purpose.',
          icon: Icons.auto_stories_rounded,
        ),
        SampleContentItem(
          title: 'Key Milestones Archive',
          subtitle:
              'Browse the major milestones in AIR\'s history — launches, pivots, partnerships, and community achievements — with context for why each one mattered. '
              'The archive is a living document, updated as new milestones are reached and historical significance becomes clearer.',
          icon: Icons.emoji_events_rounded,
        ),
        SampleContentItem(
          title: 'Decision Log',
          subtitle:
              'Access a transparent log of significant organisational decisions — what was decided, who decided it, and the reasoning behind it. '
              'A public decision log is a rare act of institutional honesty that builds the kind of trust that survives disagreement.',
          icon: Icons.history_edu_rounded,
        ),
        SampleContentItem(
          title: 'Upcoming Roadmap',
          subtitle:
              'See the planned milestones, feature releases, and community events on the AIR roadmap for the next 12 months. '
              'The roadmap is a commitment, not a guarantee — it is shared publicly to invite accountability and community input.',
          icon: Icons.map_rounded,
        ),
        SampleContentItem(
          title: 'Community Growth Chart',
          subtitle:
              'Track the growth of the AIR community over time — membership numbers, geographic spread, and engagement depth — to understand the scale of what has been built. '
              'Growth data is shared transparently because the community\'s size and health belong to the community, not just its leaders.',
          icon: Icons.trending_up_rounded,
        ),
        SampleContentItem(
          title: 'Era Summaries',
          subtitle:
              'Read concise summaries of each major era in AIR\'s development — the founding era, the growth era, the consolidation era — and what defined each one. '
              'Era summaries give new members a fast, accurate mental model of the organisation\'s evolution without requiring them to read every historical document.',
          icon: Icons.summarize_rounded,
        ),
      ],
    );
  }
}
