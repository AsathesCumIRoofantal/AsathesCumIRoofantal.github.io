import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'contribute_to_air_controller.dart';

class ContributeToAirView extends GetView<ContributeToAirController> {
  const ContributeToAirView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SampleContentPage(
      title: 'Contribute to AIR',
      subtitle:
          'Channel your ideas, skills, content, or time into AIR through structured pathways that ensure every contribution lands responsibly and creates real value. '
          'Great communities are built by contributors who give thoughtfully — this module shows you how to do exactly that.',
      icon: Icons.volunteer_activism_rounded,
      items: [
        SampleContentItem(
          title: 'Idea Submission Portal',
          subtitle:
              'Submit ideas for new features, content, or community initiatives through a structured form that captures context, rationale, and expected impact. '
              'Structured submissions are more likely to be acted on — the form helps you think through your idea before sharing it.',
          icon: Icons.lightbulb_rounded,
        ),
        SampleContentItem(
          title: 'Content Contribution Guidelines',
          subtitle:
              'Understand the standards for contributing articles, guides, templates, and media to the AIR knowledge base. '
              'Guidelines exist to protect quality and consistency — they are not gatekeeping, they are the shared craft standards of the community.',
          icon: Icons.article_rounded,
        ),
        SampleContentItem(
          title: 'Code & Patch Submissions',
          subtitle:
              'Contribute technical improvements — bug fixes, feature patches, or performance enhancements — through the AIR development workflow. '
              'Technical contributions are reviewed by maintainers who provide constructive feedback, making the process a learning opportunity as well as a contribution.',
          icon: Icons.code_rounded,
        ),
        SampleContentItem(
          title: 'Time & Skill Volunteering',
          subtitle:
              'Offer your time and expertise to specific AIR projects, working groups, or community support roles that need your particular skills. '
              'Volunteering your time is one of the most direct ways to shape AIR — and it builds relationships that outlast any single project.',
          icon: Icons.access_time_rounded,
        ),
        SampleContentItem(
          title: 'Contribution Impact Tracker',
          subtitle:
              'See the downstream impact of your contributions — how many people used your content, which ideas were implemented, and what changed as a result. '
              'Impact visibility is a powerful motivator; knowing your work matters makes it easier to keep contributing.',
          icon: Icons.insights_rounded,
        ),
        SampleContentItem(
          title: 'Responsible Contribution Principles',
          subtitle:
              'Learn the principles that guide responsible contribution — accuracy, attribution, scope awareness, and the discipline of finishing what you start. '
              'Responsible contribution is what separates a thriving community from a chaotic one; these principles are the shared contract.',
          icon: Icons.verified_rounded,
        ),
      ],
    );
  }
}
