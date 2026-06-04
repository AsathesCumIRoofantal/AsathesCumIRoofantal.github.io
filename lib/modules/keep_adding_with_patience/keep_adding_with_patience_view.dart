import 'package:air_app/modules/keep_adding_with_patience/keep_adding_with_patiencecontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';

class KeepAddingWithPatienceView
    extends GetView<KeepAddingWithPatienceController> {
  final bool isEmbedded;
  const KeepAddingWithPatienceView({super.key, this.isEmbedded = false});

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Keep Adding With Patience',
      subtitle:
          'Build long-horizon capacity by adding small, deliberate increments and letting compound growth do the heavy lifting. '
          'AIR tracks your slow additions so you can see the cumulative effect that daily impatience makes invisible.',
      icon: Icons.hourglass_bottom,
      items: const [
        SampleContentItem(
          title: 'Incremental Additions Log',
          subtitle:
              'Record every small addition — a skill practised, a relationship deepened, a system improved — with its date and context. '
              'The log makes invisible progress visible and provides motivation during the long stretches before results appear.',
          icon: Icons.add_circle_outline,
        ),
        SampleContentItem(
          title: 'Compound Growth Tracker',
          subtitle:
              'Visualise how small consistent additions accumulate over weeks, months, and years using compound growth curves. '
              'Seeing the curve makes it easier to stay patient during the early flat phase when progress feels imperceptible.',
          icon: Icons.trending_up,
        ),
        SampleContentItem(
          title: 'Patience Anchors',
          subtitle:
              'Define the long-term outcomes you are building toward and revisit them whenever urgency tempts you to cut corners. '
              'Patience anchors reconnect daily effort to meaningful purpose and reduce the pull of short-term thinking.',
          icon: Icons.anchor,
        ),
        SampleContentItem(
          title: 'Capacity Inventory',
          subtitle:
              'Maintain a current inventory of the capabilities, resources, and relationships you have built so far. '
              'Knowing what you already have prevents the trap of always starting over and helps you build on existing foundations.',
          icon: Icons.inventory_outlined,
        ),
        SampleContentItem(
          title: 'Kindness Ledger',
          subtitle:
              'Track acts of generosity, support given, and goodwill extended — the social capital that compounds most reliably. '
              'A kindness ledger reminds you that the most durable growth is built on relationships, not just skills or assets.',
          icon: Icons.favorite_border,
        ),
        SampleContentItem(
          title: 'Impatience Journal',
          subtitle:
              'Log moments when impatience led you to skip steps, rush decisions, or abandon long-term plans prematurely. '
              'Naming impatience patterns is the first step to interrupting them before they erode compounding gains.',
          icon: Icons.timer_off_outlined,
        ),
        SampleContentItem(
          title: 'Milestone Celebrations',
          subtitle:
              'Mark meaningful milestones in your long-horizon journey — not just outcomes, but sustained effort and consistency. '
              'Celebrating process milestones reinforces the behaviours that produce results, not just the results themselves.',
          icon: Icons.celebration_outlined,
        ),
      ],
    );
  }
}



