import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'world_controller.dart';

class WorldView extends GetView<WorldController> {
  const WorldView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'World',
      subtitle:
          'Maintain a clear-eyed view of global context — regions, active crises, and emerging opportunities at planetary scale. '
          'AIR connects your local decisions to the wider world so you are never blindsided by macro shifts.',
      icon: Icons.public,
      items: const [
        SampleContentItem(
          title: 'Regional Profiles',
          subtitle:
              'Build structured profiles for every region relevant to your work — political climate, economic conditions, and key actors. '
              'Regional profiles give you the context needed to interpret news and assess risk without starting from scratch each time.',
          icon: Icons.map_outlined,
        ),
        SampleContentItem(
          title: 'Active Crises',
          subtitle:
              'Track ongoing conflicts, humanitarian emergencies, and political crises with their current status and trajectory. '
              'Knowing which crises are escalating versus stabilising shapes everything from supply-chain decisions to travel safety.',
          icon: Icons.crisis_alert,
        ),
        SampleContentItem(
          title: 'Geopolitical Shifts',
          subtitle:
              'Monitor changes in alliances, trade agreements, sanctions regimes, and power dynamics between major actors. '
              'Geopolitical shifts often move slowly until they move fast — early tracking prevents being caught off guard.',
          icon: Icons.swap_horiz,
        ),
        SampleContentItem(
          title: 'Emerging Opportunities',
          subtitle:
              'Identify regions or sectors where conditions are improving and new partnerships or investments may be viable. '
              'Opportunity mapping ensures you are not so focused on risk that you miss the moments when doors open.',
          icon: Icons.explore_outlined,
        ),
        SampleContentItem(
          title: 'Global Risk Register',
          subtitle:
              'Maintain a register of macro risks — climate events, pandemic threats, financial contagion — and their potential impact on your work. '
              'A global risk register forces you to think beyond the immediate horizon and build appropriate buffers.',
          icon: Icons.travel_explore,
        ),
        SampleContentItem(
          title: 'International Actors',
          subtitle:
              'Profile the governments, multilateral bodies, NGOs, and corporations that shape the global environment you operate in. '
              'Understanding key actors — their interests, constraints, and relationships — is essential for effective global navigation.',
          icon: Icons.account_balance_outlined,
        ),
        SampleContentItem(
          title: 'World Events Timeline',
          subtitle:
              'Maintain a chronological log of significant global events and their downstream effects on your context. '
              'A timeline makes it easy to see cause-and-effect chains and to brief others on how the world got to where it is.',
          icon: Icons.timeline,
        ),
      ],
    );
  }
}
