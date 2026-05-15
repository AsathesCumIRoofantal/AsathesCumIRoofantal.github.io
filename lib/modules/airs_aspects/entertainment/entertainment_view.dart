import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'entertainment_controller.dart';

class EntertainmentView extends GetView<EntertainmentController> {
  const EntertainmentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SampleContentPage(
      title: 'Entertainment',
      subtitle:
          'Balance the seriousness of AIR\'s work with light cultural content that restores energy, sparks creativity, and keeps the human side of the platform alive. '
          'Entertainment here is intentional — curated to refresh rather than distract, and always easy to step away from when focus is needed.',
      icon: Icons.celebration_rounded,
      items: [
        SampleContentItem(
          title: 'Curated Content Feed',
          subtitle:
              'Browse a personalised feed of short-form cultural content — articles, videos, podcasts, and creative works — filtered to match your interests and available time. '
              'Content is refreshed regularly and tagged by mood so you can choose restoration, inspiration, or pure fun depending on what you need.',
          icon: Icons.play_circle_rounded,
        ),
        SampleContentItem(
          title: 'Community Highlights',
          subtitle:
              'Discover what the AIR community is watching, reading, and enjoying — trending picks, staff recommendations, and member-submitted favourites. '
              'Community highlights surface shared cultural touchpoints that make conversations richer and connections more genuine.',
          icon: Icons.groups_rounded,
        ),
        SampleContentItem(
          title: 'Creative Challenges',
          subtitle:
              'Participate in short creative challenges — writing prompts, design briefs, photography themes, or music snippets — that stretch your imagination in low-stakes ways. '
              'Challenges are optional, time-boxed, and designed to be fun; they are a reminder that creativity is a skill that needs regular exercise.',
          icon: Icons.emoji_events_rounded,
        ),
        SampleContentItem(
          title: 'Trivia & Knowledge Games',
          subtitle:
              'Test your knowledge across domains — history, science, culture, and AIR-specific topics — through quick trivia rounds that are competitive but never stressful. '
              'Games are designed to be played in under five minutes, making them a perfect micro-break between focused work sessions.',
          icon: Icons.quiz_rounded,
        ),
        SampleContentItem(
          title: 'Restoration Playlists',
          subtitle:
              'Access curated audio and visual playlists designed to help you decompress, reset focus, or transition between work modes — ambient soundscapes, instrumental music, and guided breathing. '
              'Restoration is not a luxury; it is a performance tool, and AIR treats it as one.',
          icon: Icons.headphones_rounded,
        ),
        SampleContentItem(
          title: 'Cultural Calendar',
          subtitle:
              'Stay aware of cultural events, observances, and celebrations relevant to your community and the broader AIR network — with context on their significance and suggested ways to acknowledge them. '
              'Cultural awareness builds empathy and makes collaboration across diverse teams noticeably smoother.',
          icon: Icons.calendar_month_rounded,
        ),
      ],
    );
  }
}
