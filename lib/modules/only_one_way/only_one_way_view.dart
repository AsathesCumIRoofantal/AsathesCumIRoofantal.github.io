import 'package:air_app/widgets/sample_content_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'only_one_way_controller.dart';
import 'only_one_way_enhanced_view.dart';

class OnlyOneWayPage extends GetView<OnlyOneWayController> {
  const OnlyOneWayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const BouncingScrollPhysics(),
      children: const [OnlyOneWayEnhancedView(), OnlyOneWayView()],
    );
  }
}

class OnlyOneWayView extends StatelessWidget {
  const OnlyOneWayView({super.key});

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Only One Way',
      subtitle:
          'Commit to present-moment focus and the single truthful path forward — no hedging, no parallel stories. '
          'AIR helps you identify the one honest next step and hold yourself to it.',
      icon: Icons.arrow_forward_ios_rounded,
      items: const [
        SampleContentItem(
          title: 'Present-Moment Anchor',
          subtitle:
              'Record what is true right now — your actual situation, not the story you wish were true. '
              'Anchoring to the present prevents decisions built on outdated assumptions or wishful thinking.',
          icon: Icons.center_focus_strong_outlined,
        ),
        SampleContentItem(
          title: 'Single Next Action',
          subtitle:
              'Identify the one concrete action that moves you forward from where you actually are. '
              'Committing to a single next action cuts through overwhelm and eliminates the paralysis of too many options.',
          icon: Icons.looks_one_outlined,
        ),
        SampleContentItem(
          title: 'Competing Path Audit',
          subtitle:
              'List every alternative path you are tempted to pursue and honestly assess why you are avoiding the true one. '
              'Naming competing paths exposes avoidance patterns and makes the cost of indecision visible.',
          icon: Icons.alt_route,
        ),
        SampleContentItem(
          title: 'Commitment Record',
          subtitle:
              'Write down your chosen path and the reasoning behind it so you can hold yourself accountable later. '
              'A written commitment is far harder to quietly abandon than a mental note.',
          icon: Icons.edit_note,
        ),
        SampleContentItem(
          title: 'Distraction Log',
          subtitle:
              'Track the distractions, detours, and rationalizations that pulled you off the committed path. '
              'Patterns in the distraction log reveal your most persistent avoidance strategies.',
          icon: Icons.do_not_disturb_on_outlined,
        ),
        SampleContentItem(
          title: 'Truth Check',
          subtitle:
              'Before acting, run a brief truth check — is this action aligned with what you said you would do? '
              'A consistent truth check builds the habit of integrity between intention and action.',
          icon: Icons.fact_check_outlined,
        ),
        SampleContentItem(
          title: 'Progress Reflection',
          subtitle:
              'Review how faithfully you followed the one way over the past period and what you learned from deviations. '
              'Honest reflection without self-punishment is the engine of sustainable improvement.',
          icon: Icons.self_improvement,
        ),
      ],
    );
  }
}
