import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';

class DrawerItem {
  final String title;
  final IconData icon;
  final String route;

  DrawerItem({required this.title, required this.icon, required this.route});
}

class DrawerSection {
  final String title;
  final List<DrawerItem> items;

  DrawerSection({required this.title, required this.items});
}

class HomeController extends GetxController {
  var currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
  }

  final List<DrawerSection> drawerSections = [
    DrawerSection(
      title: "EXPLORE - ALIFIYAS",
      items: [
        DrawerItem(
          title: 'Learn And Fun',
          icon: Icons.school,
          route: AppRoutes.LEARN_FUN,
        ),
        DrawerItem(
          title: 'Ask Any Thing',
          icon: Icons.question_answer,
          route: AppRoutes.QUERIES,
        ),
      ],
    ),
    DrawerSection(
      title: "RULE - MAZEASTA",
      items: [
        DrawerItem(title: 'Wisdom', icon: Icons.book, route: AppRoutes.WISDOM),
        DrawerItem(
          title: 'Ask Any Thing',
          icon: Icons.question_answer,
          route: AppRoutes.QUERIES,
        ),
      ],
    ),
    DrawerSection(
      title: "BE-YOU & EARN LIVING",
      items: [
        DrawerItem(
          title: 'Share Experience',
          icon: Icons.share,
          route: AppRoutes.SHARE_EXPERIENCE,
        ),
        DrawerItem(
          title: 'Record Your Post',
          icon: Icons.post_add,
          route: AppRoutes.RECORD_POST,
        ),
        DrawerItem(
          title: 'Identities Cum Earnings',
          icon: Icons.format_list_numbered,
          route: AppRoutes.IDENTITIES_EARNINGS,
        ),
      ],
    ),
    DrawerSection(
      title: "Use AIR's Space & Resources",
      items: [
        DrawerItem(
          title: 'Knowledge Center',
          icon: Icons.unarchive,
          route: AppRoutes.KNOWLEDGE_CENTER,
        ),
        DrawerItem(
          title: 'Products & Services',
          icon: Icons.output,
          route: AppRoutes.PRODUCTS_SERVICES,
        ),
        DrawerItem(
          title: 'Query & Discussion',
          icon: Icons.question_answer,
          route: AppRoutes.QUERY_DISCUSSION,
        ),
        DrawerItem(
          title: 'Utilities as Guest',
          icon: Icons.extension_outlined,
          route: AppRoutes.UTILITIES_GUEST,
        ),
      ],
    ),
    DrawerSection(
      title: "Your Profile Specifics",
      items: [
        DrawerItem(title: 'Events', icon: Icons.event, route: AppRoutes.EVENTS),
        DrawerItem(
          title: 'Managements',
          icon: Icons.manage_accounts,
          route: AppRoutes.MANAGEMENTS,
        ),
        DrawerItem(
          title: 'Maintenance',
          icon: Icons.build_outlined,
          route: AppRoutes.MAINTENANCE,
        ),
        DrawerItem(
          title: 'Connect & Collaborate',
          icon: Icons.connect_without_contact,
          route: AppRoutes.CONNECT_COLLABORATE,
        ),
        DrawerItem(
          title: 'Notices',
          icon: Icons.notifications_none,
          route: AppRoutes.NOTICES,
        ),
        DrawerItem(
          title: 'Tracks & Traces',
          icon: Icons.track_changes,
          route: AppRoutes.TRACKS_TRACES,
        ),
        DrawerItem(
          title: 'Your Business',
          icon: Icons.business_sharp,
          route: AppRoutes.YOUR_BUSINESS,
        ),
        DrawerItem(
          title: 'Rewards/Credits',
          icon: Icons.diamond,
          route: AppRoutes.REWARDS_CREDITS,
        ),
        DrawerItem(
          title: 'Approval of Appeals',
          icon: Icons.approval,
          route: AppRoutes.APPROVAL_APPEALS,
        ),
        DrawerItem(
          title: 'Network(APIs) Stuff',
          icon: Icons.api,
          route: AppRoutes.NETWORK_APIS,
        ),
        DrawerItem(
          title: 'Private/Confidential Stuff',
          icon: Icons.public_off,
          route: AppRoutes.PRIVATE_CONFIDENTIAL,
        ),
        DrawerItem(
          title: 'Public Stuff',
          icon: Icons.public,
          route: AppRoutes.PUBLIC_STUFF,
        ),
      ],
    ),
    DrawerSection(
      title: "AIR's - Aspects",
      items: [
        DrawerItem(
          title: "Let's resume your tour",
          icon: Icons.travel_explore,
          route: AppRoutes.RESUME_TOUR,
        ),
        DrawerItem(
          title: "Be the part of AIR",
          icon: Icons.grade,
          route: AppRoutes.BE_PART_OF_AIR,
        ),
        DrawerItem(
          title: "Contribute to AIR",
          icon: Icons.add_box,
          route: AppRoutes.CONTRIBUTE_TO_AIR,
        ),
        DrawerItem(
          title: "Timeline of AIR",
          icon: Icons.timeline,
          route: AppRoutes.TIMELINE_OF_AIR,
        ),
        DrawerItem(
          title: "New in AIR",
          icon: Icons.new_releases,
          route: AppRoutes.NEW_IN_AIR,
        ),
        DrawerItem(
          title: 'Checked Space Anomalies',
          icon: Icons.check_circle_outline_rounded,
          route: AppRoutes.CHECKED_ANOMALIES,
        ),
        DrawerItem(
          title: 'Un-Checked Space Anomalies',
          icon: Icons.question_mark_outlined,
          route: AppRoutes.UNCHECKED_ANOMALIES,
        ),
        DrawerItem(
          title: 'Limits (0 or 1)',
          icon: Icons.calculate_outlined,
          route: AppRoutes.LIMITS_0_1,
        ),
        DrawerItem(
          title: 'Communication',
          icon: Icons.transform_rounded,
          route: AppRoutes.COMMUNICATION,
        ),
        DrawerItem(
          title: 'Imagination & Features',
          icon: Icons.featured_play_list_outlined,
          route: AppRoutes.IMAGINATION_FEATURES,
        ),
        DrawerItem(
          title: 'Beliefs & Values',
          icon: Icons.flag_outlined,
          route: AppRoutes.BELIEFS_VALUES,
        ),
        DrawerItem(
          title: 'Entertainment',
          icon: Icons.play_circle_outline_rounded,
          route: AppRoutes.ENTERTAINMENT,
        ),
        DrawerItem(
          title: 'Skills & Talents',
          icon: Icons.star_border_rounded,
          route: AppRoutes.SKILLS_TALENTS,
        ),
        DrawerItem(
          title: "Being Recorded & Rewarded",
          icon: Icons.data_object_rounded,
          route: AppRoutes.BEING_RECORDED_REWARDED,
        ),
        DrawerItem(
          title: "Training",
          icon: Icons.lens_blur_rounded,
          route: AppRoutes.TRAINING,
        ),
        DrawerItem(
          title: "System All Together",
          icon: Icons.all_inclusive_rounded,
          route: AppRoutes.SYSTEM_ALL_TOGETHER,
        ),
      ],
    ),
    DrawerSection(
      title: "SERVICE & PRODUCTION",
      items: [
        DrawerItem(
          title: "Input in Process",
          icon: Icons.arrow_forward_ios_rounded,
          route: AppRoutes.INPUT_IN_PROCESS,
        ),
        DrawerItem(
          title: "Process",
          icon: Icons.gavel_rounded,
          route: AppRoutes.PROCESS,
        ),
        DrawerItem(
          title: "Outcome of Processed",
          icon: Icons.computer_sharp,
          route: AppRoutes.OUTCOME_PROCESSED,
        ),
      ],
    ),
    DrawerSection(
      title: "AIR'S VISION",
      items: [
        DrawerItem(
          title: "AIR's Vision",
          icon: Icons.visibility_outlined,
          route: AppRoutes.AIR_VISION,
        ),
        DrawerItem(
          title: "AIR's Mission",
          icon: Icons.music_note_sharp,
          route: AppRoutes.AIRS_MISSION,
        ),
        DrawerItem(
          title: "AIR's Show Case",
          icon: Icons.show_chart,
          route: AppRoutes.AIRS_SHOWCASE,
        ),
        DrawerItem(
          title: "Let's Windup Else",
          icon: Icons.wrap_text,
          route: AppRoutes.WINDUP_ELSE,
        ),
        DrawerItem(
          title: "Follow like Calender",
          icon: Icons.calendar_month_outlined,
          route: AppRoutes.FOLLOW_CALENDAR,
        ),
        DrawerItem(
          title: "Pick Your Good Going",
          icon: Icons.golf_course,
          route: AppRoutes.PICK_GOOD_GOING,
        ),
      ],
    ),
    DrawerSection(
      title: "MOTIVATION & CONNECTIVITY",
      items: [
        DrawerItem(
          title: "Revise & Improve",
          icon: Icons.icecream_rounded,
          route: AppRoutes.REVISE_IMPROVE,
        ),
        DrawerItem(
          title: "Practice & Expertise",
          icon: Icons.hail_outlined,
          route: AppRoutes.PRACTICE_EXPERTISE,
        ),
        DrawerItem(
          title: "Share & Care",
          icon: Icons.handshake_rounded,
          route: AppRoutes.SHARE_CARE,
        ),
        DrawerItem(
          title: "Finnally All is Blessings",
          icon: Icons.widgets,
          route: AppRoutes.FINALLY_BLESSINGS,
        ),
        DrawerItem(
          title: "A Word of Motivation",
          icon: Icons.elderly_sharp,
          route: AppRoutes.MOTIVATION,
        ),
        DrawerItem(
          title: "Never Give Up",
          icon: Icons.window,
          route: AppRoutes.NEVER_GIVE_UP,
        ),
        DrawerItem(
          title: "Innovation is Key",
          icon: Icons.lightbulb_outline,
          route: AppRoutes.INNOVATION_KEY,
        ),
        DrawerItem(
          title: "You Got All of it Accountable",
          icon: Icons.account_balance_wallet,
          route: AppRoutes.ACCOUNTABLE,
        ),
        DrawerItem(
          title: "Live Life to the Fullest",
          icon: Icons.favorite,
          route: AppRoutes.LIVE_FULLEST,
        ),
        DrawerItem(
          title: "Get Connected",
          icon: Icons.groups_2_rounded,
          route: AppRoutes.GET_CONNECTED_SOCIAL,
        ),
        DrawerItem(
          title: "Being Together is Unison",
          icon: Icons.compare_arrows,
          route: AppRoutes.TOGETHER_UNISON,
        ),
        DrawerItem(
          title: "Great to Have You Onboard",
          icon: Icons.airplanemode_active,
          route: AppRoutes.ONBOARD,
        ),
        DrawerItem(
          title: "All Greetings",
          icon: Icons.waving_hand,
          route: AppRoutes.GREETINGS,
        ),
        DrawerItem(
          title: "Be Liable to Responsibilities",
          icon: Icons.home_work_rounded,
          route: AppRoutes.RESPONSIBILITIES,
        ),
      ],
    ),
    DrawerSection(
      title: "SETUP A-ONE",
      items: [
        DrawerItem(
          title: "Product & Record (DIGITALIZE)",
          icon: Icons.all_inclusive_rounded,
          route: AppRoutes.digitalize_records,
        ),
        DrawerItem(
          title: "Projects & Assessments",
          icon: Icons.assessment,
          route: AppRoutes.projects_assessments,
        ),
        DrawerItem(
          title: "Category Tree",
          icon: Icons.local_florist,
          route: AppRoutes.category_tree,
        ),
        DrawerItem(
          title: "Ease Tools",
          icon: Icons.handyman,
          route: AppRoutes.ease_tools,
        ),
      ],
    ),
    DrawerSection(
      title: "SYSTEM CORE",
      items: [
        DrawerItem(
          title: 'App Setting',
          icon: Icons.settings,
          route: AppRoutes.SETTINGS,
        ),
        DrawerItem(
          title: 'About AIR-APP',
          icon: Icons.air,
          route: AppRoutes.ABOUT_APP,
        ),
        DrawerItem(
          title: 'About AIR Organization',
          icon: Icons.info,
          route: AppRoutes.ABOUT_ORG,
        ),
        DrawerItem(
          title: 'Sign Out',
          icon: Icons.logout_rounded,
          route: AppRoutes.LOGOUT,
        ),
      ],
    ),
  ];
}
