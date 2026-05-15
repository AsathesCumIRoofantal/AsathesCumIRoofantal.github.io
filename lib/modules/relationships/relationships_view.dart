import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'relationships_controller.dart';

class RelationshipsView extends GetView<RelationshipsController> {
  const RelationshipsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Relationships',
      subtitle:
          'Map every important tie — mentors, peers, dependents, allies, and adversaries — so you understand your full network. '
          'AIR helps you nurture high-value connections and spot gaps before they become liabilities.',
      icon: Icons.hub_outlined,
      items: const [
        SampleContentItem(
          title: 'Relationship Map',
          subtitle:
              'Visualise your network as a graph of nodes and edges, colour-coded by relationship type and strength. '
              'Seeing the whole picture at once reveals clusters, bridges, and isolated contacts that need attention.',
          icon: Icons.account_tree_outlined,
        ),
        SampleContentItem(
          title: 'Mentors & Sponsors',
          subtitle:
              'Record the people who invest in your growth — their areas of expertise, how often you connect, and what you owe them. '
              'Tracking mentor relationships ensures you reciprocate value and keep the connection alive.',
          icon: Icons.school_outlined,
        ),
        SampleContentItem(
          title: 'Peers & Collaborators',
          subtitle:
              'Log colleagues and co-creators you work alongside regularly, including shared projects and communication cadence. '
              'Strong peer ties are often the fastest path to new opportunities and honest feedback.',
          icon: Icons.group_outlined,
        ),
        SampleContentItem(
          title: 'Dependents & Responsibilities',
          subtitle:
              'Identify people who rely on you — team members, family, or community members — and what they need from you. '
              'Clarity about dependents helps you allocate time and energy without dropping anyone.',
          icon: Icons.family_restroom,
        ),
        SampleContentItem(
          title: 'Allies & Advocates',
          subtitle:
              'Track individuals who actively champion your work or share your goals in different arenas. '
              'Allies amplify your reach; knowing who they are lets you coordinate and support them in return.',
          icon: Icons.diversity_3,
        ),
        SampleContentItem(
          title: 'Relationship Health Score',
          subtitle:
              'Rate each relationship on recency, reciprocity, and depth to surface connections that are fading or one-sided. '
              'A health score nudges you to reach out before a valuable tie goes cold.',
          icon: Icons.favorite_border,
        ),
        SampleContentItem(
          title: 'Interaction Log',
          subtitle:
              'Keep a timestamped record of meaningful conversations, favours exchanged, and commitments made with each contact. '
              'The log becomes invaluable context before important meetings or when resolving misunderstandings.',
          icon: Icons.chat_bubble_outline,
        ),
      ],
    );
  }
}
