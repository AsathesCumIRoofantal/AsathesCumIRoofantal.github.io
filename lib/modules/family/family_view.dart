import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'family_controller.dart';

class FamilyView extends GetView<FamilyController> {
  const FamilyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Family',
      subtitle:
          'Family in AIR is about being intentional with the people who matter most — defining roles, protecting rituals, and keeping shared life organized. Strong families run on clarity, not just love.',
      icon: Icons.family_restroom_outlined,
      items: const [
        SampleContentItem(
          title: 'Family Roles',
          subtitle:
              'Every family member plays a role — provider, nurturer, planner, peacemaker. Making these roles explicit reduces resentment and helps everyone know where they contribute most.',
          icon: Icons.people_outline,
        ),
        SampleContentItem(
          title: 'Shared Calendar',
          subtitle:
              'A family without a shared calendar is a family that surprises each other with conflicts. Sync key dates — school events, appointments, travel — so no one is caught off guard.',
          icon: Icons.calendar_month_outlined,
        ),
        SampleContentItem(
          title: 'Family Rituals',
          subtitle:
              'Rituals are the glue of family identity — Sunday dinners, bedtime routines, annual trips. Log your rituals, protect them from schedule creep, and add new ones as the family evolves.',
          icon: Icons.celebration_outlined,
        ),
        SampleContentItem(
          title: 'Communication Norms',
          subtitle:
              'How your family communicates under stress determines how well it holds together. Define your norms — no phones at dinner, weekly check-ins, a signal word for when someone needs space.',
          icon: Icons.chat_bubble_outline,
        ),
        SampleContentItem(
          title: 'Household Responsibilities',
          subtitle:
              'Chores and responsibilities assigned clearly prevent the invisible labor problem. Use AIR to map who owns what at home and rotate tasks fairly as circumstances change.',
          icon: Icons.home_outlined,
        ),
        SampleContentItem(
          title: 'Family Goals',
          subtitle:
              'Families that set goals together — a vacation, a savings target, a home project — build shared purpose. Log your family goals and track progress so everyone feels invested.',
          icon: Icons.flag_outlined,
        ),
        SampleContentItem(
          title: 'One-on-One Time',
          subtitle:
              'Individual attention within a family is as important as group time. Schedule dedicated one-on-one time with each family member and log what you talked about to deepen the connection.',
          icon: Icons.favorite_border_outlined,
        ),
      ],
    );
  }
}
