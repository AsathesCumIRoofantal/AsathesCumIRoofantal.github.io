import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'self_discipline_controller.dart';

class SelfDisciplineView extends GetView<SelfDisciplineController> {
  const SelfDisciplineView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Self Discipline',
      subtitle:
          'Self-discipline in AIR is a systems problem, not a willpower problem. This module helps you design habits, track streaks, and build consequence structures that make the right behavior the path of least resistance.',
      icon: Icons.fitness_center_outlined,
      items: const [
        SampleContentItem(
          title: 'Habit Stack',
          subtitle:
              'A habit stack is a sequence of behaviors anchored to a trigger. Define your morning, work, and evening stacks so discipline becomes automatic rather than a daily negotiation with yourself.',
          icon: Icons.stacked_line_chart_outlined,
        ),
        SampleContentItem(
          title: 'Streak Tracker',
          subtitle:
              'Streaks create momentum — breaking a 30-day run feels costly enough to keep you going. Log your active streaks for key habits and use the visual record as a commitment device.',
          icon: Icons.local_fire_department_outlined,
        ),
        SampleContentItem(
          title: 'Consequence Design',
          subtitle:
              'If breaking a commitment has no cost, it will be broken. Design meaningful consequences for your most important habits — a donation, a public declaration, a forfeit — and log them here.',
          icon: Icons.gavel_outlined,
        ),
        SampleContentItem(
          title: 'Temptation Audit',
          subtitle:
              'Discipline is easier when temptations are removed from the environment. Audit what pulls you off track — apps, environments, people — and log the friction you\'ve added to make slipping harder.',
          icon: Icons.block_outlined,
        ),
        SampleContentItem(
          title: 'Recovery Protocol',
          subtitle:
              'Missing once is an accident; missing twice is the start of a new habit. Define your recovery protocol — what you do the day after a slip — so a single failure doesn\'t cascade into abandonment.',
          icon: Icons.restart_alt_outlined,
        ),
        SampleContentItem(
          title: 'Energy Management',
          subtitle:
              'Discipline depletes with decision fatigue. Protect your highest-discipline hours for your hardest tasks and automate or batch low-stakes decisions to preserve your willpower budget.',
          icon: Icons.battery_charging_full_outlined,
        ),
        SampleContentItem(
          title: 'Weekly Review',
          subtitle:
              'A weekly review closes the loop on your discipline system. Score each habit, note what worked and what didn\'t, and make one small adjustment to your system before the next week starts.',
          icon: Icons.event_note_outlined,
        ),
      ],
    );
  }
}
