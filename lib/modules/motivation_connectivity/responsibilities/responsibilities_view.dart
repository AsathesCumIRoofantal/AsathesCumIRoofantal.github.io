import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'responsibilities_controller.dart';

class ResponsibilitiesView extends GetView<ResponsibilitiesController> {
  const ResponsibilitiesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SampleContentPage(
      title: 'Responsibilities',
      subtitle:
          'Map the full landscape of what you owe — to yourself, your family, your work, and your community — so nothing important falls through the cracks. '
          'Duty mapping is not about guilt or obligation; it is about living with integrity by knowing your commitments and honouring them deliberately.',
      icon: Icons.assignment_rounded,
      items: [
        SampleContentItem(
          title: 'Self-Responsibility Inventory',
          subtitle:
              'Identify the core duties you hold toward your own health, growth, finances, and mental wellbeing — the foundation everything else rests on. '
              'You cannot reliably fulfil responsibilities to others if the responsibilities to yourself are chronically neglected.',
          icon: Icons.person_rounded,
        ),
        SampleContentItem(
          title: 'Family Duty Map',
          subtitle:
              'Clarify the specific responsibilities you carry within your family — care, presence, financial contribution, emotional support, and shared decisions. '
              'Making these explicit prevents the resentment that builds when family members have different assumptions about who owes what.',
          icon: Icons.family_restroom_rounded,
        ),
        SampleContentItem(
          title: 'Professional Obligations Tracker',
          subtitle:
              'List your active professional commitments — deliverables, relationships, and role-specific duties — and track their status in one place. '
              'Professional responsibilities are often the most visible, but they are also the most likely to expand beyond sustainable limits without active management.',
          icon: Icons.work_rounded,
        ),
        SampleContentItem(
          title: 'Community Contribution Planner',
          subtitle:
              'Define how you will contribute to your community — AIR, local, or broader — in ways that are meaningful, sustainable, and matched to your capacity. '
              'Community responsibility is the outermost ring of duty, and it is where individual integrity becomes collective strength.',
          icon: Icons.groups_rounded,
        ),
        SampleContentItem(
          title: 'Responsibility Conflict Resolver',
          subtitle:
              'When duties in different domains collide — work versus family, self versus community — use the resolver to make a principled choice and communicate it clearly. '
              'Conflicts between responsibilities are inevitable; having a framework for resolving them prevents paralysis and preserves relationships.',
          icon: Icons.balance_rounded,
        ),
        SampleContentItem(
          title: 'Duty Delegation Guide',
          subtitle:
              'Identify responsibilities that can be shared, delegated, or renegotiated without abandoning your core obligations. '
              'Carrying every duty alone is not virtue — it is a path to burnout that ultimately harms the people who depend on you.',
          icon: Icons.share_rounded,
        ),
        SampleContentItem(
          title: 'Responsibility Review Cycle',
          subtitle:
              'Schedule a quarterly review of your full duty map to add new responsibilities, retire completed ones, and rebalance as your life evolves. '
              'Responsibilities change as circumstances change — a regular review keeps your map accurate and your commitments realistic.',
          icon: Icons.loop_rounded,
        ),
      ],
    );
  }
}
