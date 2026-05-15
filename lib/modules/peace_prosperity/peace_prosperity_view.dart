import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'peace_prosperity_controller.dart';

class PeaceProsperityView extends GetView<PeaceProsperityController> {
  const PeaceProsperityView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Peace & Prosperity',
      subtitle:
          'Monitor community-level wellbeing through peace and prosperity indicators that go beyond GDP. '
          'AIR surfaces the human signals — safety, dignity, opportunity, and cohesion — that define a thriving community.',
      icon: Icons.spa_outlined,
      items: const [
        SampleContentItem(
          title: 'Safety Index',
          subtitle:
              'Track indicators of physical and psychological safety across the communities you serve or belong to. '
              'Safety is the foundation of prosperity; without it, every other indicator is fragile.',
          icon: Icons.shield_outlined,
        ),
        SampleContentItem(
          title: 'Economic Wellbeing',
          subtitle:
              'Measure income distribution, employment rates, and access to basic needs rather than aggregate wealth alone. '
              'Prosperity that reaches the bottom of the distribution is more durable than prosperity concentrated at the top.',
          icon: Icons.attach_money,
        ),
        SampleContentItem(
          title: 'Social Cohesion',
          subtitle:
              'Assess trust levels, civic participation, and the strength of community bonds through qualitative and quantitative signals. '
              'High social cohesion predicts resilience during crises and reduces the cost of governance.',
          icon: Icons.diversity_2,
        ),
        SampleContentItem(
          title: 'Conflict Early Warning',
          subtitle:
              'Monitor tension indicators — grievance levels, resource scarcity, and political polarisation — before they escalate. '
              'Early warning gives communities and leaders time to address root causes rather than manage consequences.',
          icon: Icons.warning_outlined,
        ),
        SampleContentItem(
          title: 'Opportunity Access',
          subtitle:
              'Track whether education, healthcare, legal recourse, and economic opportunity are equitably distributed. '
              'Unequal access to opportunity is one of the most reliable predictors of future instability.',
          icon: Icons.open_in_new,
        ),
        SampleContentItem(
          title: 'Reconciliation Tracker',
          subtitle:
              'Log active reconciliation processes, their participants, milestones reached, and outstanding grievances. '
              'Structured reconciliation tracking prevents peace processes from stalling quietly without anyone noticing.',
          icon: Icons.handshake_outlined,
        ),
        SampleContentItem(
          title: 'Prosperity Scorecard',
          subtitle:
              'Aggregate all indicators into a single scorecard that shows overall community health at a glance. '
              'The scorecard is designed to be shared publicly, building accountability and community ownership of outcomes.',
          icon: Icons.leaderboard_outlined,
        ),
      ],
    );
  }
}
