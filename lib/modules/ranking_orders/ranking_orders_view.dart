import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'ranking_orders_controller.dart';

class RankingOrdersView extends GetView<RankingOrdersController> {
  const RankingOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Ranking & Orders',
      subtitle:
          'Build ranked lists for priorities, leaderboards, and ordered decisions so the most important things always rise to the top. '
          'AIR makes ranking criteria explicit and keeps ordered lists current as conditions change.',
      icon: Icons.format_list_numbered,
      items: const [
        SampleContentItem(
          title: 'Priority Stack',
          subtitle:
              'Rank your current initiatives, tasks, or goals in strict order so there is never ambiguity about what comes first. '
              'A single priority stack eliminates the "everything is urgent" trap and forces honest trade-offs.',
          icon: Icons.low_priority,
        ),
        SampleContentItem(
          title: 'Ranking Criteria',
          subtitle:
              'Define the weighted criteria used to rank items — impact, urgency, effort, strategic alignment, and risk. '
              'Explicit criteria make rankings defensible and allow others to challenge or update them with evidence.',
          icon: Icons.rule_folder_outlined,
        ),
        SampleContentItem(
          title: 'Leaderboards',
          subtitle:
              'Track performance rankings across individuals, teams, or entities over time with configurable metrics. '
              'Transparent leaderboards motivate improvement and surface outliers — both high performers and those needing support.',
          icon: Icons.emoji_events_outlined,
        ),
        SampleContentItem(
          title: 'Decision Ordering',
          subtitle:
              'When multiple decisions are pending, rank them by dependency and urgency to determine the right sequence. '
              'Ordered decision queues prevent downstream work from starting before upstream choices are locked.',
          icon: Icons.reorder,
        ),
        SampleContentItem(
          title: 'Rank Change Log',
          subtitle:
              'Record every time an item moves up or down the ranking and the reason for the change. '
              'A change log reveals how priorities shift over time and prevents revisionist history about past decisions.',
          icon: Icons.swap_vert,
        ),
        SampleContentItem(
          title: 'Comparative Analysis',
          subtitle:
              'Compare two or more ranked items head-to-head across all criteria to validate their relative positions. '
              'Head-to-head comparison is especially useful when stakeholders disagree about the correct order.',
          icon: Icons.compare_arrows,
        ),
      ],
    );
  }
}
