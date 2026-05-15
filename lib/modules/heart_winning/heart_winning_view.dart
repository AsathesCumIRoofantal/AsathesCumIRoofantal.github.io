import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'heart_winning_controller.dart';

class HeartWinningView extends GetView<HeartWinningController> {
  const HeartWinningView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Heart Winning',
      subtitle:
          'Explore the intersection of sound policy and genuine empathy in public-facing leadership roles. '
          'Winning hearts means delivering results while treating every person with dignity and respect.',
      icon: Icons.volunteer_activism,
      items: const [
        SampleContentItem(
          title: 'Empathetic Leadership',
          subtitle:
              'Learn frameworks for leading with emotional intelligence alongside operational authority. '
              'Case studies show how empathetic decisions build long-term trust with communities and teams.',
          icon: Icons.favorite,
        ),
        SampleContentItem(
          title: 'Community Engagement',
          subtitle:
              'Plan and record outreach activities that connect leaders directly with the people they serve. '
              'Engagement logs capture feedback and commitments made during community interactions.',
          icon: Icons.groups,
        ),
        SampleContentItem(
          title: 'Policy with Purpose',
          subtitle:
              'Review policies through a human-centred lens to identify where rules can be applied with compassion. '
              'Annotate policies with empathy notes that guide frontline staff in sensitive situations.',
          icon: Icons.policy,
        ),
        SampleContentItem(
          title: 'Listening Sessions',
          subtitle:
              'Schedule and document structured listening sessions where leaders hear concerns without agenda. '
              'Session summaries are shared back with participants to demonstrate that voices were heard.',
          icon: Icons.hearing,
        ),
        SampleContentItem(
          title: 'Recognition & Gratitude',
          subtitle:
              'Acknowledge the contributions of individuals and communities through formal and informal recognition. '
              'Gratitude expressed publicly reinforces a culture where people feel valued and seen.',
          icon: Icons.star_outline,
        ),
        SampleContentItem(
          title: 'Conflict Resolution',
          subtitle:
              'Apply principled negotiation techniques to resolve disputes in a way that preserves relationships. '
              'Resolution templates guide leaders through structured dialogue toward mutually acceptable outcomes.',
          icon: Icons.handshake,
        ),
        SampleContentItem(
          title: 'Impact Stories',
          subtitle:
              'Capture and share stories of positive change that resulted from heart-centred leadership decisions. '
              'Stories inspire others and build an evidence base for the value of empathetic governance.',
          icon: Icons.auto_stories,
        ),
      ],
    );
  }
}
