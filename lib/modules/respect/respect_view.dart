import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'respect_controller.dart';

class RespectView extends GetView<RespectController> {
  const RespectView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Respect',
      subtitle:
          'Respect in AIR is about establishing clear baselines — how you address people, honor their boundaries, and protect their dignity by default. It\'s not earned once; it\'s practiced consistently.',
      icon: Icons.balance_outlined,
      items: const [
        SampleContentItem(
          title: 'Titles & Forms of Address',
          subtitle:
              'Using someone\'s preferred name and title is the smallest possible act of respect — and skipping it is a loud signal. Log the preferences of people you interact with regularly and honor them without being reminded.',
          icon: Icons.badge_outlined,
        ),
        SampleContentItem(
          title: 'Boundary Awareness',
          subtitle:
              'Boundaries are not obstacles — they are the terms under which someone can engage with you safely. Learn the stated and unstated limits of the people around you and treat them as hard constraints.',
          icon: Icons.do_not_disturb_alt_outlined,
        ),
        SampleContentItem(
          title: 'Dignity Defaults',
          subtitle:
              'Every person deserves basic dignity regardless of their status, performance, or relationship to you. Define your dignity defaults — how you speak about people when they\'re not in the room.',
          icon: Icons.shield_outlined,
        ),
        SampleContentItem(
          title: 'Listening as Respect',
          subtitle:
              'Interrupting, checking your phone, or half-listening signals that your thoughts matter more than theirs. Practice full-presence listening as a concrete act of respect in every conversation.',
          icon: Icons.hearing_outlined,
        ),
        SampleContentItem(
          title: 'Disagreement with Dignity',
          subtitle:
              'You can challenge an idea without diminishing the person who holds it. Log how you handle disagreements — are you attacking the argument or the person? Respect survives conflict when the distinction is clear.',
          icon: Icons.forum_outlined,
        ),
        SampleContentItem(
          title: 'Respect Under Hierarchy',
          subtitle:
              'Respect flows in all directions — not just upward to authority. How you treat people with less power than you is the truest measure of your character. Track your behavior with subordinates and service workers.',
          icon: Icons.swap_vert_outlined,
        ),
        SampleContentItem(
          title: 'Repair After Disrespect',
          subtitle:
              'Everyone slips. What matters is whether you notice, own it, and repair it. Log instances where you fell short of your respect standards and the steps you took to make it right.',
          icon: Icons.build_circle_outlined,
        ),
      ],
    );
  }
}
