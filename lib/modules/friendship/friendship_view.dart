import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'friendship_controller.dart';

class FriendshipView extends GetView<FriendshipController> {
  const FriendshipView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Friendship',
      subtitle:
          'Friendships decay without maintenance — not from malice, but from neglect. This module helps you track reach-outs, check reciprocity, and ensure your closest relationships get the attention they deserve.',
      icon: Icons.group_outlined,
      items: const [
        SampleContentItem(
          title: 'Friend Roster',
          subtitle:
              'Know who your actual friends are versus acquaintances. Categorize your relationships by depth — close, casual, professional — so you can allocate your social energy intentionally.',
          icon: Icons.contacts_outlined,
        ),
        SampleContentItem(
          title: 'Reach-Out Log',
          subtitle:
              'Log every meaningful reach-out — a call, a message, a coffee. Seeing the last contact date for each friend makes it obvious who you\'ve been neglecting before the relationship fades.',
          icon: Icons.phone_outlined,
        ),
        SampleContentItem(
          title: 'Reciprocity Check',
          subtitle:
              'Healthy friendships flow both ways. Track who initiates contact and notice patterns — if you\'re always the one reaching out, it\'s worth a conversation or a quiet recalibration.',
          icon: Icons.compare_arrows_outlined,
        ),
        SampleContentItem(
          title: 'Depth Conversations',
          subtitle:
              'Surface-level chat keeps friendships alive but doesn\'t deepen them. Log the last time you had a real conversation — about fears, goals, struggles — and schedule the next one.',
          icon: Icons.record_voice_over_outlined,
        ),
        SampleContentItem(
          title: 'Shared Experiences',
          subtitle:
              'Shared experiences are the fastest way to strengthen a friendship. Plan activities together — a trip, a project, a challenge — and log them as anchors in your shared history.',
          icon: Icons.explore_outlined,
        ),
        SampleContentItem(
          title: 'Support Given & Received',
          subtitle:
              'Note when a friend showed up for you and when you showed up for them. Gratitude for support received keeps you from taking friendships for granted during easy times.',
          icon: Icons.handshake_outlined,
        ),
      ],
    );
  }
}
