import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'kindness_controller.dart';

class KindnessView extends GetView<KindnessController> {
  const KindnessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Kindness',
      subtitle:
          'Kindness in AIR is treated as an operational habit, not a personality trait. This module helps you build consistent, deliberate acts of consideration into your daily interactions — not as performance, but as practice.',
      icon: Icons.volunteer_activism_outlined,
      items: const [
        SampleContentItem(
          title: 'Daily Kindness Habit',
          subtitle:
              'One intentional act of kindness per day compounds into a reputation and a character. Log small acts — holding a door, a genuine compliment, a helpful message — to build the habit through visibility.',
          icon: Icons.wb_sunny_outlined,
        ),
        SampleContentItem(
          title: 'Politeness Defaults',
          subtitle:
              'Politeness is the baseline — please, thank you, eye contact, full attention. Define your non-negotiable politeness defaults so they operate automatically even when you\'re tired or stressed.',
          icon: Icons.sentiment_satisfied_alt_outlined,
        ),
        SampleContentItem(
          title: 'Kindness Under Pressure',
          subtitle:
              'Anyone can be kind when things are easy. The real test is how you treat people when you\'re frustrated, rushed, or disappointed. Log moments where you chose kindness under pressure.',
          icon: Icons.self_improvement_outlined,
        ),
        SampleContentItem(
          title: 'Noticing Others',
          subtitle:
              'Kindness starts with noticing — who looks tired, who needs help, who hasn\'t spoken in a while. Train your attention to scan for others\' needs before they have to ask.',
          icon: Icons.visibility_outlined,
        ),
        SampleContentItem(
          title: 'Words That Land Well',
          subtitle:
              'Some words open people up; others shut them down. Keep a personal list of phrases that have landed well in difficult conversations and revisit them before high-stakes interactions.',
          icon: Icons.chat_outlined,
        ),
        SampleContentItem(
          title: 'Kindness to Yourself',
          subtitle:
              'You cannot sustain kindness toward others if you\'re running on self-criticism. Log moments of self-compassion — rest taken without guilt, mistakes forgiven, progress acknowledged.',
          icon: Icons.spa_outlined,
        ),
      ],
    );
  }
}
