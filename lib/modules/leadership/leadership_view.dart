import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:air_app/widgets/sample_content_page.dart';
import 'leadership_controller.dart';

class LeadershipView extends GetView<LeadershipController> {
  const LeadershipView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SampleContentPage(
      title: 'Leadership',
      subtitle:
          'Leadership in AIR is about setting clear direction and following through with accountability. This module helps you define your leadership posture — from vision-casting to delegation and execution.',
      icon: Icons.military_tech_outlined,
      items: const [
        SampleContentItem(
          title: 'Vision Setting',
          subtitle:
              'A leader without a written vision is just reacting. Define your 90-day and 1-year north stars so every decision has a reference point. AIR tracks your vision statements and flags when actions drift from them.',
          icon: Icons.track_changes_outlined,
        ),
        SampleContentItem(
          title: 'Delegation Map',
          subtitle:
              'Delegation is not abdication — it requires matching task complexity to the right person\'s skill level. Log who owns what, at what authority level, and when you expect a status update back.',
          icon: Icons.account_tree_outlined,
        ),
        SampleContentItem(
          title: 'Decision Log',
          subtitle:
              'Great leaders document why they decided, not just what they decided. Capture key decisions with context, alternatives considered, and the expected outcome so you can review and learn.',
          icon: Icons.fact_check_outlined,
        ),
        SampleContentItem(
          title: 'Follow-Through Tracker',
          subtitle:
              'Commitments made in meetings evaporate without a system. AIR lets you log promises you made to your team and surfaces them before the next check-in so nothing slips.',
          icon: Icons.checklist_outlined,
        ),
        SampleContentItem(
          title: 'Feedback Cadence',
          subtitle:
              'Regular, specific feedback is the fastest way to grow the people around you. Set a rhythm — weekly, bi-weekly — and use AIR to draft honest, constructive notes before each session.',
          icon: Icons.rate_review_outlined,
        ),
        SampleContentItem(
          title: 'Leadership Principles',
          subtitle:
              'Your personal leadership principles are the rules you refuse to break under pressure. Write them down, review them quarterly, and let them guide how you handle conflict and ambiguity.',
          icon: Icons.menu_book_outlined,
        ),
        SampleContentItem(
          title: 'Energy & Presence',
          subtitle:
              'How you show up sets the tone for everyone around you. Track your energy levels, note what drains versus fuels you, and design your schedule to protect your highest-impact hours.',
          icon: Icons.bolt_outlined,
        ),
      ],
    );
  }
}
