import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'beliefs_values_controller.dart';

class BeliefsValuesView extends GetView<BeliefsValuesController> {
  const BeliefsValuesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SampleContentPage(
      title: 'Beliefs & Values',
      subtitle:
          'Articulate what you genuinely stand for so AIR can align its coaching, matching, and recommendations with your actual principles — not generic defaults. '
          'Declared values are not a performance; they are the compass AIR uses to surface opportunities and flag misalignments before they become problems.',
      icon: Icons.balance_rounded,
      items: [
        SampleContentItem(
          title: 'Core Values Declaration',
          subtitle:
              'State the three to five values that guide your decisions — integrity, curiosity, service, excellence, or whatever is authentically yours — and explain what each means in practice. '
              'AIR uses your declaration to filter recommendations and flag when a proposed action conflicts with what you say you stand for.',
          icon: Icons.star_rounded,
        ),
        SampleContentItem(
          title: 'Belief Mapping',
          subtitle:
              'Map your beliefs about people, systems, and progress — the assumptions that shape how you interpret situations and make choices. '
              'Surfacing beliefs explicitly helps you spot blind spots, challenge outdated assumptions, and communicate your worldview to collaborators more clearly.',
          icon: Icons.account_tree_rounded,
        ),
        SampleContentItem(
          title: 'Values-in-Action Log',
          subtitle:
              'Track moments where you acted in alignment with your stated values — and moments where you did not — to build an honest picture of the gap between intention and behaviour. '
              'The log is private by default; it is a tool for self-awareness, not a public scorecard.',
          icon: Icons.fact_check_rounded,
        ),
        SampleContentItem(
          title: 'Alignment Check',
          subtitle:
              'Run a periodic alignment check that compares your recent activity, decisions, and commitments against your declared values to surface any drift. '
              'Drift is normal; catching it early and course-correcting is what separates people who live their values from those who only list them.',
          icon: Icons.compass_calibration_rounded,
        ),
        SampleContentItem(
          title: 'Ethical Boundaries',
          subtitle:
              'Define the lines you will not cross — the actions, partnerships, or compromises that are off the table regardless of incentive or pressure. '
              'Clear ethical boundaries protect you from gradual erosion and give AIR the context to decline matching you with opportunities that violate them.',
          icon: Icons.shield_rounded,
        ),
        SampleContentItem(
          title: 'Values Coaching',
          subtitle:
              'Receive AIR-guided coaching prompts that help you deepen your understanding of your own values, resolve internal conflicts between competing principles, and grow your ethical clarity over time. '
              'Coaching is not prescriptive — it asks questions that help you find your own answers.',
          icon: Icons.psychology_rounded,
        ),
      ],
    );
  }
}
