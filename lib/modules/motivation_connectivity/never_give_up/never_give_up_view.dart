import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'never_give_up_controller.dart';

class NeverGiveUpView extends GetView<NeverGiveUpController> {
  const NeverGiveUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SampleContentPage(
      title: 'Never Give Up',
      subtitle:
          'Build the mental frameworks and practical tools to hold the line when progress is hard — and to pivot smartly when holding the line becomes stubbornness. '
          'Persistence is a skill, not a personality trait, and it can be trained with the right framing.',
      icon: Icons.shield_rounded,
      items: [
        SampleContentItem(
          title: 'Hold vs. Pivot Decision',
          subtitle:
              'When you feel like quitting, use the structured hold-or-pivot framework to distinguish genuine resilience from sunk-cost thinking. '
              'The framework asks three questions: Is the goal still valid? Is the path still viable? Is the cost still acceptable?',
          icon: Icons.fork_right_rounded,
        ),
        SampleContentItem(
          title: 'Obstacle Reframe Tool',
          subtitle:
              'Transform the way you interpret setbacks by reframing obstacles as data points rather than verdicts on your worth. '
              'Each reframe is logged so you can look back and see how many "impossible" moments you actually moved through.',
          icon: Icons.psychology_rounded,
        ),
        SampleContentItem(
          title: 'Resilience Evidence Bank',
          subtitle:
              'Build a personal bank of evidence — past challenges you overcame, hard things you finished, moments you did not quit. '
              'When doubt strikes, the evidence bank provides concrete proof that you have been here before and made it through.',
          icon: Icons.savings_rounded,
        ),
        SampleContentItem(
          title: 'Persistence Streak Tracker',
          subtitle:
              'Track consecutive days of showing up for your most important commitments, even imperfectly. '
              'The streak is not about perfection — it is about the identity-building power of consistent effort over time.',
          icon: Icons.local_fire_department_rounded,
        ),
        SampleContentItem(
          title: 'Smart Pivot Planner',
          subtitle:
              'When a genuine pivot is the right call, plan it deliberately rather than reactively — preserving what was learned and redirecting energy wisely. '
              'A smart pivot is not giving up; it is applying hard-won insight to a better path.',
          icon: Icons.pivot_table_chart_rounded,
        ),
        SampleContentItem(
          title: 'Inspiration Archive',
          subtitle:
              'Curate quotes, stories, and personal memories that reliably reignite your motivation when the tank runs low. '
              'The archive is searchable by mood and context so you can find the right fuel for the specific challenge you face.',
          icon: Icons.bookmark_rounded,
        ),
        SampleContentItem(
          title: 'Accountability Partner Link',
          subtitle:
              'Connect with an accountability partner who will check in on your persistence commitments without judgment. '
              'Partners are matched by domain and communication style to maximise the quality of the support exchange.',
          icon: Icons.people_alt_rounded,
        ),
      ],
    );
  }
}
