import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'pick_good_going_controller.dart';

class PickGoodGoingView extends GetView<PickGoodGoingController> {
  const PickGoodGoingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SampleContentPage(
      title: 'Pick Good Going',
      subtitle:
          'Choose constructive next steps with intention instead of drifting into whatever feels easiest or most urgent. '
          'Picking good going means evaluating options against your values and priorities before committing your time and energy.',
      icon: Icons.explore_rounded,
      items: [
        SampleContentItem(
          title: 'Next-Step Decision Tool',
          subtitle:
              'When facing multiple possible directions, use the structured decision tool to weigh each option against your current priorities. '
              'The tool surfaces trade-offs clearly so you choose with eyes open rather than defaulting to habit.',
          icon: Icons.fork_right_rounded,
        ),
        SampleContentItem(
          title: 'Constructive Options Board',
          subtitle:
              'Maintain a curated list of high-value next steps you could take at any given moment, ready to pick from when you have capacity. '
              'Options are tagged by domain, effort level, and expected impact so you can match them to your current state.',
          icon: Icons.view_list_rounded,
        ),
        SampleContentItem(
          title: 'Drift Detection',
          subtitle:
              'Identify patterns where you consistently choose low-value activities over high-impact ones — the subtle drift that erodes progress. '
              'Drift alerts are gentle and non-judgmental, designed to prompt reflection rather than induce guilt.',
          icon: Icons.warning_amber_rounded,
        ),
        SampleContentItem(
          title: 'Values Alignment Filter',
          subtitle:
              'Before committing to any next step, run it through your personal values filter to confirm it is genuinely constructive for you. '
              'The filter is customisable and evolves as your understanding of your own priorities deepens.',
          icon: Icons.filter_alt_rounded,
        ),
        SampleContentItem(
          title: 'Momentum Builder',
          subtitle:
              'When energy is low, the momentum builder suggests small, achievable next steps that create forward motion without overwhelm. '
              'Small wins compound — even a five-minute constructive action is better than paralysis.',
          icon: Icons.rocket_launch_rounded,
        ),
        SampleContentItem(
          title: 'Good Going Journal',
          subtitle:
              'Reflect on the choices you made today — which were genuinely constructive and which were avoidance in disguise. '
              'The journal builds self-awareness over time and makes it progressively easier to pick good going by default.',
          icon: Icons.menu_book_rounded,
        ),
      ],
    );
  }
}
