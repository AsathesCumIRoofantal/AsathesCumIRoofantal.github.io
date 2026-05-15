import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'empathy_sympathy_controller.dart';

class EmpathySympathyView extends GetView<EmpathySympathyController> {
  const EmpathySympathyView({super.key});

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Empathy & Sympathy',
      subtitle:
          'Empathy means feeling with someone — stepping into their frame before offering your own. This module builds your emotional intelligence through deliberate drills that train you to understand others\' experience, not just acknowledge it.',
      icon: Icons.psychology_outlined,
      items: const [
        SampleContentItem(
          title: 'Empathy vs. Sympathy',
          subtitle:
              'Sympathy says "I feel sorry for you." Empathy says "I understand what this feels like from where you stand." Learn to distinguish the two in your responses and practice shifting from sympathy to genuine empathy.',
          icon: Icons.compare_outlined,
        ),
        SampleContentItem(
          title: 'Perspective-Taking Drills',
          subtitle:
              'Before responding to someone in distress, pause and ask: what is this situation like from inside their experience? Log your perspective-taking attempts and note when your initial read was wrong.',
          icon: Icons.swap_horiz_outlined,
        ),
        SampleContentItem(
          title: 'Emotional Vocabulary',
          subtitle:
              'You can\'t empathize with emotions you can\'t name. Expand your emotional vocabulary beyond "sad," "angry," and "happy" — the more precisely you can label feelings, the more accurately you can connect with others.',
          icon: Icons.spellcheck_outlined,
        ),
        SampleContentItem(
          title: 'Listening Without Fixing',
          subtitle:
              'Most people in pain need to be heard before they need solutions. Practice listening to completion — no advice, no silver linings, no pivoting to your own experience — and log how it changes the conversation.',
          icon: Icons.hearing_outlined,
        ),
        SampleContentItem(
          title: 'Empathy Fatigue',
          subtitle:
              'Sustained empathy without recovery leads to burnout. Monitor your emotional bandwidth, recognize when you\'re running low, and build in recovery practices so you can keep showing up for others.',
          icon: Icons.battery_alert_outlined,
        ),
        SampleContentItem(
          title: 'Empathy in Conflict',
          subtitle:
              'Conflict is where empathy is hardest and most needed. Practice naming the other person\'s perspective before stating your own — "I think you\'re feeling X because Y" — and watch how it changes the dynamic.',
          icon: Icons.people_alt_outlined,
        ),
        SampleContentItem(
          title: 'Compassionate Action',
          subtitle:
              'Empathy without action is just observation. When you understand someone\'s pain, ask what they need — don\'t assume — and then follow through on what you offer. Log the gap between your intentions and your actions.',
          icon: Icons.volunteer_activism_outlined,
        ),
      ],
    );
  }
}
