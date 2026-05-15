import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'together_unison_controller.dart';

class TogetherUnisonView extends GetView<TogetherUnisonController> {
  const TogetherUnisonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SampleContentPage(
      title: 'Together in Unison',
      subtitle:
          'Create harmony in groups by clarifying roles, establishing shared rhythms, and building the repair skills that keep teams intact through inevitable friction. '
          'Unison is not uniformity — it is the disciplined coordination of different strengths toward a common beat.',
      icon: Icons.groups_rounded,
      items: [
        SampleContentItem(
          title: 'Role Clarity Map',
          subtitle:
              'Define each team member\'s primary role, decision authority, and the interfaces where their work touches others. '
              'Role ambiguity is the single most common source of team friction — a clear map eliminates most conflicts before they start.',
          icon: Icons.account_tree_rounded,
        ),
        SampleContentItem(
          title: 'Shared Rhythm Calendar',
          subtitle:
              'Establish the recurring cadences — standups, reviews, retrospectives, and social touchpoints — that give the group a predictable heartbeat. '
              'Rhythm reduces coordination overhead and creates the psychological safety that comes from knowing when and how the group will connect.',
          icon: Icons.calendar_month_rounded,
        ),
        SampleContentItem(
          title: 'Conflict Repair Protocol',
          subtitle:
              'When tension surfaces, use the structured repair protocol to move from positions to interests and find solutions that honour everyone\'s core needs. '
              'Groups that repair well are stronger after conflict than before it — the protocol turns friction into a trust-building event.',
          icon: Icons.handshake_rounded,
        ),
        SampleContentItem(
          title: 'Contribution Visibility Board',
          subtitle:
              'Make each member\'s contributions visible to the whole group so recognition is accurate, timely, and not dependent on self-promotion. '
              'Invisible contributions breed resentment; a visibility board ensures that quiet contributors are seen and valued.',
          icon: Icons.leaderboard_rounded,
        ),
        SampleContentItem(
          title: 'Group Decision Framework',
          subtitle:
              'Choose the right decision mode — consent, consensus, or authority — for each type of choice the group faces, and document the rationale. '
              'Mismatched decision modes are a hidden source of group dysfunction; the framework aligns expectations before the decision is made.',
          icon: Icons.how_to_vote_rounded,
        ),
        SampleContentItem(
          title: 'Unison Health Pulse',
          subtitle:
              'Run a brief anonymous pulse survey after each major group event to measure psychological safety, clarity, and energy levels. '
              'The pulse gives leaders early warning of harmony erosion so they can intervene before small cracks become structural fractures.',
          icon: Icons.favorite_rounded,
        ),
      ],
    );
  }
}
