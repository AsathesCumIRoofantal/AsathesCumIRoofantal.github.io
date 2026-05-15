import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'skills_talents_controller.dart';

class SkillsTalentsView extends GetView<SkillsTalentsController> {
  const SkillsTalentsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SampleContentPage(
      title: 'Skills & Talents',
      subtitle:
          'Build a clear inventory of your strengths — technical skills, soft skills, and natural talents — so AIR can pair them with the opportunities most likely to let them shine. '
          'An honest skills profile is the foundation of every meaningful match, recommendation, and growth plan AIR generates for you.',
      icon: Icons.workspace_premium_rounded,
      items: [
        SampleContentItem(
          title: 'Skills Inventory',
          subtitle:
              'Catalogue your skills across categories — technical, interpersonal, creative, analytical, and leadership — with self-assessed proficiency levels and supporting evidence. '
              'The inventory is a living document; update it as you grow and AIR will automatically recalibrate the opportunities it surfaces for you.',
          icon: Icons.checklist_rounded,
        ),
        SampleContentItem(
          title: 'Talent Spotlight',
          subtitle:
              'Identify and articulate your natural talents — the things you do effortlessly that others find difficult — and understand how they translate into professional value. '
              'Talents are distinct from skills: skills are learned, talents are innate, and knowing the difference helps you position yourself more accurately.',
          icon: Icons.auto_awesome_rounded,
        ),
        SampleContentItem(
          title: 'Skill Gap Analysis',
          subtitle:
              'Compare your current skills against the requirements of roles, projects, or opportunities you are targeting to identify the specific gaps worth closing. '
              'Gap analysis turns vague ambition into a concrete development plan with clear priorities and measurable milestones.',
          icon: Icons.analytics_rounded,
        ),
        SampleContentItem(
          title: 'Opportunity Matching',
          subtitle:
              'See AIR-curated opportunities — projects, roles, collaborations, and challenges — that are specifically matched to your skills and talents profile. '
              'Matching is not just about what you can do; it accounts for what energises you, so the opportunities surfaced are ones you will actually want to pursue.',
          icon: Icons.connect_without_contact_rounded,
        ),
        SampleContentItem(
          title: 'Endorsements & Validation',
          subtitle:
              'Collect endorsements from collaborators, managers, and peers that validate your self-assessed skills with real-world evidence and named sources. '
              'Endorsed skills carry more weight in AIR\'s matching algorithm and signal credibility to anyone reviewing your profile.',
          icon: Icons.verified_rounded,
        ),
        SampleContentItem(
          title: 'Growth Trajectory',
          subtitle:
              'Track how your skills have evolved over time — which areas have grown, which have plateaued, and which are emerging — with a visual timeline of your development. '
              'Seeing your trajectory builds confidence and helps you make informed decisions about where to invest your learning energy next.',
          icon: Icons.trending_up_rounded,
        ),
        SampleContentItem(
          title: 'Skill-Building Resources',
          subtitle:
              'Access AIR-recommended resources — courses, mentors, practice projects, and reading lists — tailored to the specific skills you are working to develop. '
              'Resources are ranked by effectiveness and time investment so you can choose the right learning path for your current situation.',
          icon: Icons.school_rounded,
        ),
      ],
    );
  }
}
