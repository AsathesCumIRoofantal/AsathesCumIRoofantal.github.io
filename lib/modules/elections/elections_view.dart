import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'elections_controller.dart';

class ElectionsView extends GetView<ElectionsController> {
  const ElectionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Elections',
      subtitle:
          'Build election literacy by exploring candidate platforms, key timelines, and voter responsibilities. '
          'An informed electorate is the foundation of a healthy democratic process.',
      icon: Icons.how_to_vote,
      items: const [
        SampleContentItem(
          title: 'Candidate Profiles',
          subtitle:
              'Review structured profiles for each candidate including background, platform, and key positions. '
              'Profiles are sourced from official declarations and updated as new information is published.',
          icon: Icons.person,
        ),
        SampleContentItem(
          title: 'Election Timeline',
          subtitle:
              'Follow the full election calendar from nomination deadlines through to results certification. '
              'Key milestones are highlighted so voters and officials never miss a critical date.',
          icon: Icons.calendar_today,
        ),
        SampleContentItem(
          title: 'Voter Registration',
          subtitle:
              'Check registration status, find polling station details, and understand eligibility requirements. '
              'Step-by-step guidance helps first-time voters navigate the registration process confidently.',
          icon: Icons.app_registration,
        ),
        SampleContentItem(
          title: 'Policy Comparisons',
          subtitle:
              'Compare candidate positions side by side across key policy areas relevant to your community. '
              'Objective comparisons are drawn directly from official manifestos and public statements.',
          icon: Icons.compare,
        ),
        SampleContentItem(
          title: 'Voter Responsibilities',
          subtitle:
              'Understand your rights and obligations as a voter, including conduct at polling stations. '
              'Clear guidance on what is and is not permitted helps maintain the integrity of the process.',
          icon: Icons.verified_user,
        ),
        SampleContentItem(
          title: 'Results & Analysis',
          subtitle:
              'Access official election results as they are declared, broken down by constituency and candidate. '
              'Post-election analysis highlights turnout trends and shifts in voter sentiment.',
          icon: Icons.bar_chart,
        ),
        SampleContentItem(
          title: 'Electoral Education',
          subtitle:
              'Explore articles, videos, and quizzes that explain how the electoral system works. '
              'Educational content is tailored to different literacy levels to maximise accessibility.',
          icon: Icons.school,
        ),
      ],
    );
  }
}
