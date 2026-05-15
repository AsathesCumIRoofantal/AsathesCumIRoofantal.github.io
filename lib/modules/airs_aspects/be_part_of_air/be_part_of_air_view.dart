import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'be_part_of_air_controller.dart';

class BePartOfAirView extends GetView<BePartOfAirController> {
  const BePartOfAirView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SampleContentPage(
      title: 'Be Part of AIR',
      subtitle:
          'Discover the pathways to genuine belonging in AIR — the roles available, the expectations attached to each, and how to plug in at the level that fits your life right now. '
          'Membership is not a status; it is an active practice of showing up, contributing, and growing alongside the community.',
      icon: Icons.group_add_rounded,
      items: [
        SampleContentItem(
          title: 'Membership Tiers Explained',
          subtitle:
              'Understand the different levels of AIR membership — Observer, Participant, Contributor, and Steward — and what each one asks of you and offers in return. '
              'Tiers are not a hierarchy of worth; they are a map of commitment levels so you can choose the depth of involvement that is honest and sustainable.',
          icon: Icons.layers_rounded,
        ),
        SampleContentItem(
          title: 'Role Finder',
          subtitle:
              'Answer a short set of questions about your skills, interests, and available time to receive a personalised list of roles where you would add the most value. '
              'The right role is the one where your strengths meet the community\'s needs — the finder makes that match explicit.',
          icon: Icons.manage_search_rounded,
        ),
        SampleContentItem(
          title: 'Community Expectations Charter',
          subtitle:
              'Read the clear, honest charter of what AIR expects from every member — in terms of conduct, communication, and contribution. '
              'Expectations are not restrictions; they are the shared agreements that make a community worth belonging to.',
          icon: Icons.gavel_rounded,
        ),
        SampleContentItem(
          title: 'Joining Ceremony',
          subtitle:
              'Complete a brief, meaningful joining ceremony that marks your formal entry into AIR and introduces you to the community. '
              'The ceremony is designed to feel significant without being burdensome — a moment of intention-setting that anchors your commitment.',
          icon: Icons.celebration_rounded,
        ),
        SampleContentItem(
          title: 'Active Participation Guide',
          subtitle:
              'Learn the practical habits of active AIR membership — how to engage in discussions, support others, flag issues, and grow your influence over time. '
              'Participation is a skill that improves with practice; the guide gives you the specific behaviours that make membership feel alive.',
          icon: Icons.record_voice_over_rounded,
        ),
        SampleContentItem(
          title: 'Membership Benefits Overview',
          subtitle:
              'See the full range of benefits that come with active AIR membership — access, recognition, learning resources, and network effects. '
              'Benefits are not the reason to join, but understanding them helps you take full advantage of what the community has built.',
          icon: Icons.card_membership_rounded,
        ),
      ],
    );
  }
}
