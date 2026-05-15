import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'affection_love_controller.dart';

class AffectionLoveView extends GetView<AffectionLoveController> {
  const AffectionLoveView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Affection & Love',
      subtitle:
          'Healthy affection holds warmth and boundaries in the same frame — it is generous without being intrusive, and consistent without being performative. This module helps you express love in ways that land well for the people you care about.',
      icon: Icons.favorite_outlined,
      items: const [
        SampleContentItem(
          title: 'Love Languages',
          subtitle:
              'People receive love differently — words, acts, gifts, time, or touch. Know your own love language and the languages of the people closest to you so your affection actually reaches them.',
          icon: Icons.translate_outlined,
        ),
        SampleContentItem(
          title: 'Affection Boundaries',
          subtitle:
              'Affection without consent is intrusion. Log the comfort levels of the people in your life — who welcomes physical warmth, who prefers verbal affirmation — and honor those preferences every time.',
          icon: Icons.do_not_disturb_outlined,
        ),
        SampleContentItem(
          title: 'Consistent Small Gestures',
          subtitle:
              'Grand gestures are memorable but rare. Consistent small gestures — a check-in text, a remembered detail, a moment of undivided attention — build the deepest sense of being loved.',
          icon: Icons.emoji_emotions_outlined,
        ),
        SampleContentItem(
          title: 'Expressing Appreciation',
          subtitle:
              'Telling someone specifically what you love about them is more powerful than a general "I love you." Practice naming the exact quality or action you appreciate and log the moments that matter.',
          icon: Icons.record_voice_over_outlined,
        ),
        SampleContentItem(
          title: 'Affection in Conflict',
          subtitle:
              'Withdrawing affection during conflict is a punishment, not a boundary. Learn to stay warm even when you\'re hurt — separate the disagreement from the relationship and keep the connection intact.',
          icon: Icons.healing_outlined,
        ),
        SampleContentItem(
          title: 'Quality Time',
          subtitle:
              'Presence is the most irreplaceable form of affection. Schedule protected time with the people you love — no phones, no agenda — and log what you did together to build a shared memory bank.',
          icon: Icons.access_time_outlined,
        ),
      ],
    );
  }
}
