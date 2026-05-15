import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'fingers_are_crossed_controller.dart';

class FingersAreCrossedView extends GetView<FingersAreCrossedController> {
  const FingersAreCrossedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Fingers Are Crossed',
      subtitle:
          'Track pending outcomes and hopeful bets without losing agency or momentum. '
          'Log what you\'re waiting on, set follow-up nudges, and stay grounded while the answer is still in the air.',
      icon: Icons.hourglass_top_rounded,
      items: const [
        SampleContentItem(
          title: 'Pending Outcomes Tracker',
          subtitle:
              'Log every decision, proposal, or application you\'re waiting on with a clear status. '
              'Attach context notes so you remember exactly what\'s at stake when the answer arrives.',
          icon: Icons.pending_actions_outlined,
        ),
        SampleContentItem(
          title: 'Follow-Up Nudges',
          subtitle:
              'Set smart reminders to follow up if you haven\'t heard back by a chosen date. '
              'Avoid the awkward silence — a well-timed nudge keeps momentum without seeming pushy.',
          icon: Icons.notifications_active_outlined,
        ),
        SampleContentItem(
          title: 'Probability & Confidence Log',
          subtitle:
              'Rate your confidence level for each pending outcome so you can plan contingencies. '
              'Revisiting your estimates over time sharpens your intuition about what\'s likely to land.',
          icon: Icons.bar_chart_rounded,
        ),
        SampleContentItem(
          title: 'Parallel Paths',
          subtitle:
              'While one door is closed, keep others open — document your backup plans and alternatives. '
              'Healthy waiting means pursuing parallel options rather than freezing until one answer comes.',
          icon: Icons.alt_route_outlined,
        ),
        SampleContentItem(
          title: 'Outcome Archive',
          subtitle:
              'When results arrive, record what happened and what you learned from the wait. '
              'A growing archive of resolved outcomes becomes a personal calibration tool for future bets.',
          icon: Icons.archive_outlined,
        ),
        SampleContentItem(
          title: 'Emotional Check-In',
          subtitle:
              'Waiting can be draining — log how you\'re feeling about each pending item to stay self-aware. '
              'Spotting anxiety spikes early lets you redirect energy toward what you can actually control.',
          icon: Icons.self_improvement_rounded,
        ),
        SampleContentItem(
          title: 'Shared Hopes Board',
          subtitle:
              'Invite teammates to add their own pending outcomes to a shared board for visibility. '
              'When the team knows what everyone is waiting on, support and celebration happen naturally.',
          icon: Icons.group_outlined,
        ),
      ],
    );
  }
}
