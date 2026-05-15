import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'onboard_controller.dart';

class OnboardView extends GetView<OnboardController> {
  const OnboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SampleContentPage(
      title: 'Onboarding',
      subtitle:
          'Guide new members through a structured welcome path — first tasks, key contacts, and essential context — so they feel oriented and capable from day one. '
          'A great onboarding experience is the fastest way to convert a newcomer into a confident, contributing member of AIR.',
      icon: Icons.rocket_launch_rounded,
      items: [
        SampleContentItem(
          title: 'Welcome Checklist',
          subtitle:
              'Complete a short sequence of first-day tasks — profile setup, community introduction, and a quick orientation quiz — to establish your presence in AIR. '
              'The checklist is designed to take under 30 minutes and leaves you with everything you need to participate immediately.',
          icon: Icons.checklist_rounded,
        ),
        SampleContentItem(
          title: 'Orientation Map',
          subtitle:
              'Explore a visual map of AIR\'s modules, communities, and key resources so you know where to go for what you need. '
              'The map is interactive — tap any area to get a plain-language description of its purpose and a suggested first action.',
          icon: Icons.map_rounded,
        ),
        SampleContentItem(
          title: 'Buddy Assignment',
          subtitle:
              'Get matched with an experienced AIR member who will answer your first questions, make introductions, and check in during your first two weeks. '
              'Buddy relationships reduce the anxiety of being new and dramatically accelerate the time to feeling genuinely at home.',
          icon: Icons.person_add_rounded,
        ),
        SampleContentItem(
          title: 'First Contribution Prompt',
          subtitle:
              'Receive a personalised prompt for your first meaningful contribution — matched to your skills and interests — so you can add value before you feel fully settled. '
              'Early contribution is the fastest path to belonging; the prompt removes the paralysis of not knowing where to start.',
          icon: Icons.lightbulb_rounded,
        ),
        SampleContentItem(
          title: 'Culture & Norms Primer',
          subtitle:
              'Read a concise guide to how AIR communicates, makes decisions, handles disagreement, and celebrates wins. '
              'Understanding the culture early prevents the accidental missteps that make new members feel like outsiders long after they have joined.',
          icon: Icons.menu_book_rounded,
        ),
        SampleContentItem(
          title: 'Onboarding Progress Tracker',
          subtitle:
              'See your onboarding completion percentage and the specific steps remaining so you always know how close you are to being fully oriented. '
              'The tracker also unlocks access to advanced features as you complete each stage, rewarding progress with expanded capability.',
          icon: Icons.track_changes_rounded,
        ),
      ],
    );
  }
}
