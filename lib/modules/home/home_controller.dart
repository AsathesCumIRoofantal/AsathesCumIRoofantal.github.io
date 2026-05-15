import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';

class DrawerItem {
  final String title;
  final IconData icon;
  final String route;

  DrawerItem({required this.title, required this.icon, required this.route});
}

class DrawerResultItem {
  final String title;
  final IconData icon;
  final String route;

  DrawerResultItem({
    required this.title,
    required this.icon,
    required this.route,
  });
}

class DrawerSection {
  final String title;
  final List<DrawerItem> items;

  DrawerSection({required this.title, required this.items});
}

class DrawerSearchResult {
  final String sectionTitle;
  final DrawerResultItem item;

  DrawerSearchResult({required this.sectionTitle, required this.item});
}

class HomeController extends GetxController {
  var currentIndex = 0.obs;
  RxList<DrawerSearchResult> results = <DrawerSearchResult>[].obs;

  void changePage(int index) {
    currentIndex.value = index;
  }

  final RxBool isDrawerSearchVisible = false.obs;

  final RxString drawerSearchText = ''.obs;

  final TextEditingController drawerSearchController = TextEditingController();

  final ScrollController drawerScrollController = ScrollController();

  /// SAFE KEYS
  final Map<String, GlobalKey> itemKeys = {};

  @override
  void onInit() {
    super.onInit();

    for (final section in drawerSections) {
      for (final item in section.items) {
        // if (item.route == null) {
        //   // itemKeys[item.route!] = GlobalKey(
        //   //   debugLabel: "FilterItems_${item.title}",
        //   // ); //wont come to this
        // } else {
        itemKeys[item.route!] = GlobalKey(
          debugLabel: "${section.title}_${item.route}",
        );
        // }
      }
    }
  }

  /// =====================================================
  /// DRAWER DATA
  /// =====================================================

  final List<DrawerSection> drawerSections = [
    DrawerSection(
      title: "EXPLORE - ALIFIYAS",
      items: [
        DrawerItem(
          title: 'Learn And Fun',
          icon: Icons.lightbulb_outline,
          route: AppRoutes.LEARN_FUN,
        ),
        DrawerItem(
          title: 'Learn Docs (by category)',
          icon: Icons.menu_book_outlined,
          route: AppRoutes.LEARN_DOCS,
        ),
        DrawerItem(
          title: 'Heigher Studies',
          icon: Icons.school_outlined,
          route: AppRoutes.HEIGHER_STUDIES,
        ),
        DrawerItem(
          title: 'Doctorate',
          icon: Icons.local_hospital,
          route: AppRoutes.DOCTORATE,
        ),
        DrawerItem(
          title: 'Life Hacks',
          icon: Icons.heat_pump_rounded,
          route: AppRoutes.LIFE_HACKS,
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
        DrawerItem(
          title: "Vocabulary",
          icon: Icons.wordpress,
          route: AppRoutes.vocabulary,
        ),
        DrawerItem(
          title: "Code & Conduct",
          icon: Icons.code,
          route: AppRoutes.code_conduct,
        ),
        DrawerItem(
          title: "Script & Strategy",
          icon: Icons.video_collection,
          route: AppRoutes.script_strategy,
        ),
        DrawerItem(
          title: "Safety",
          icon: Icons.safety_check,
          route: AppRoutes.SAFETY,
        ),
        DrawerItem(
          title: "Hospitality & Care",
          icon: Icons.self_improvement_rounded,
          route: AppRoutes.HOSPITALITY_CARE,
        ),
        DrawerItem(
          title: "Utility & Facilities",
          icon: Icons.amp_stories_rounded,
          route: AppRoutes.UTILITY_FACILITIES,
        ),
        DrawerItem(
          title: "Commerce",
          icon: Icons.cabin,
          route: AppRoutes.COMMERCE,
        ),
        DrawerItem(
          title: "Social",
          icon: Icons.social_distance,
          route: AppRoutes.SOCIAL,
        ),
        DrawerItem(
          title: "Research & Development",
          icon: Icons.science_outlined,
          route: AppRoutes.RESEARCH_DEVELOPMENT,
        ),
        DrawerItem(
          title: "Travel & Transport",
          icon: Icons.flight_land_outlined,
          route: AppRoutes.TRAVEL_TRANSPORT,
        ),
        DrawerItem(
          title: "Loop Hole",
          icon: Icons.loop,
          route: AppRoutes.LOOP_HOLE,
        ),
        DrawerItem(
          title: "Advantage",
          icon: Icons.star_border_rounded,
          route: AppRoutes.ADVANTAGE,
        ),
        DrawerItem(
          title: "Challenge",
          icon: Icons.flag_outlined,
          route: AppRoutes.CHALLENGE,
        ),
        DrawerItem(
          title: "Solution",
          icon: Icons.lightbulb_outline,
          route: AppRoutes.SOLUTION,
        ),
        DrawerItem(
          title: "Innovation",
          icon: Icons.new_label,
          route: AppRoutes.INNOVATION,
        ),
        DrawerItem(
          title: "Discovery",
          icon: Icons.search,
          route: AppRoutes.DISCOVERY,
        ),
        DrawerItem(
          title: "Enhancement",
          icon: Icons.auto_fix_high,
          route: AppRoutes.ENHANCEMENT,
        ),
        DrawerItem(
          title: "Hope",
          icon: Icons.cloud_rounded,
          route: AppRoutes.HOPE,
        ),
        DrawerItem(
          title: "Success & Failure",
          icon: Icons.star,
          route: AppRoutes.SUCCESS_FAILURE,
        ),
        DrawerItem(
          title: "Religion & Prayer",
          icon: Icons.auto_fix_high,
          route: AppRoutes.RELIGION_PRAYER,
        ),

        DrawerItem(
          title: "Feedback",
          icon: Icons.feedback,
          route: AppRoutes.FEEDBACK,
        ),
        DrawerItem(
          title: "Marketing & Promotion",
          icon: Icons.shop,
          route: AppRoutes.marketing_promotion,
        ),
        DrawerItem(
          title: "Serve",
          icon: Icons.volunteer_activism,
          route: AppRoutes.serve,
        ),
        DrawerItem(
          title: "Relationships",
          icon: Icons.group,
          route: AppRoutes.RELATIONSHIPS,
        ),
        DrawerItem(
          title: "Obligations",
          icon: Icons.rule,
          route: AppRoutes.OBLIGATIONS,
        ),
        DrawerItem(
          title: "Punctuality",
          icon: Icons.watch_later_outlined,
          route: AppRoutes.PUNCTUALITY,
        ),
        DrawerItem(
          title: "Loyalty",
          icon: Icons.verified_user,
          route: AppRoutes.LOYALTY,
        ),
        DrawerItem(
          title: "Appreciations & Thanks",
          icon: Icons.wallet_giftcard,
          route: AppRoutes.APPRECIATIONS_THANKS,
        ),
        DrawerItem(
          title: "Empathy & Sympathy",
          icon: Icons.heart_broken,
          route: AppRoutes.EMPATHY_SYMPATHY,
        ),
        DrawerItem(
          title: "Forgivness",
          icon: Icons.forest,
          route: AppRoutes.FORGIVNESS,
        ),
        DrawerItem(
          title: "Kindness & Politeness",
          icon: Icons.face,
          route: AppRoutes.KINDNESS,
        ),
        DrawerItem(
          title: "Respect",
          icon: Icons.account_circle_sharp,
          route: AppRoutes.RESPECT,
        ),
        DrawerItem(
          title: "Discipline",
          icon: Icons.architecture,
          route: AppRoutes.SELF_DISCIPLINE,
        ),
        DrawerItem(
          title: "Affection & Love",
          icon: Icons.favorite,
          route: AppRoutes.AFFECTION_LOVE,
        ),
        DrawerItem(
          title: "Family",
          icon: Icons.family_restroom,
          route: AppRoutes.FAMILY,
        ),
        DrawerItem(
          title: "Friendship",
          icon: Icons.people_outline,
          route: AppRoutes.FRIENDSHIP,
        ),
        DrawerItem(
          title: "Rivalry And War",
          icon: Icons.military_tech,
          route: AppRoutes.RIVALRY,
        ),
        DrawerItem(
          title: "Competition",
          icon: Icons.flag,
          route: AppRoutes.COMPITITION,
        ),
        DrawerItem(
          title: "Technology",
          icon: Icons.computer,
          route: AppRoutes.TECHNOLOGY,
        ),
        DrawerItem(
          title: "Language & Translation",
          icon: Icons.language,
          route: AppRoutes.LANGUAGE_TRANSLATION,
        ),
        DrawerItem(
          title: "Monitorship",
          icon: Icons.remove_red_eye,
          route: AppRoutes.MONITORSHIP,
        ),
        DrawerItem(
          title: "Survellence & Investigation",
          icon: Icons.security,
          route: AppRoutes.SURVELLENCE_INVESTIGATION,
        ),
        DrawerItem(
          title: "Leadership",
          icon: Icons.co_present_rounded,
          route: AppRoutes.LEADERSHIP,
        ),
        DrawerItem(
          title: "Control & Coordination",
          icon: Icons.pan_tool_alt_outlined,
          route: AppRoutes.CONTROL_COORDINATION,
        ),
        DrawerItem(
          title: "The Present - The Only One Way",
          icon: Icons.currency_rupee,
          route: AppRoutes.ONLY_ONE_WAY,
        ),
        DrawerItem(
          title: "Trade Import-Export",
          icon: Icons.import_export,
          route: AppRoutes.TRADE_IMPORT_EXPORT,
        ),
        DrawerItem(
          title: "Ranking Orders",
          icon: Icons.format_list_numbered,
          route: AppRoutes.RANKING_ORDERS,
        ),
        DrawerItem(
          title: "Statistics",
          icon: Icons.show_chart,
          route: AppRoutes.STATISTICS,
        ),
        DrawerItem(
          title: "Peace and Prosperity",
          icon: Icons.landscape_rounded,
          route: AppRoutes.PEACE_PROSPERITY,
        ),
        DrawerItem(title: "World", icon: Icons.public, route: AppRoutes.WORLD),
        DrawerItem(
          title: "Universal Peace Rule",
          icon: Icons.gavel,
          route: AppRoutes.UNIVERSAL_PEACE_RULE,
        ),
        DrawerItem(
          title: "Keep Adding With Patience",
          icon: Icons.add,
          route: AppRoutes.KEEP_ADDING_WITH_PATIENCE,
        ),
        DrawerItem(
          title: "Media & News",
          icon: Icons.newspaper,
          route: AppRoutes.MEDIA_NEWS,
        ),
        DrawerItem(
          title: "Engagements",
          icon: Icons.energy_savings_leaf,
          route: AppRoutes.ENGAGEMENTS,
        ),
        DrawerItem(
          title: "Demonstration",
          icon: Icons.engineering,
          route: AppRoutes.DEMONSTRATION,
        ),
        DrawerItem(
          title: "Group Discussions",
          icon: Icons.chat,
          route: AppRoutes.GROUP_DISCUSSIONS,
        ),
        DrawerItem(
          title: "Situation & Reaction",
          icon: Icons.announcement,
          route: AppRoutes.SITUATION_REACTION,
        ),
        DrawerItem(
          title: "Ground Task",
          icon: Icons.task_alt,
          route: AppRoutes.GROUND_TASK,
        ),
        DrawerItem(
          title: "Interviews",
          icon: Icons.record_voice_over,
          route: AppRoutes.INTERVIEWS,
        ),
        DrawerItem(
          title: "Merits and Demerits",
          icon: Icons.list_alt_rounded,
          route: AppRoutes.MERITS_DEMERITS,
        ),
        DrawerItem(
          title: "Medical Test",
          icon: Icons.medical_services,
          route: AppRoutes.MEDICAL,
        ),
        DrawerItem(
          title: "Joining Services",
          icon: Icons.join_right_rounded,
          route: AppRoutes.JOINING_SERVICES,
        ),
        DrawerItem(
          title: "Rules & Regulations",
          icon: Icons.rule_folder_rounded,
          route: AppRoutes.RULES_REGULATIONS,
        ),
        DrawerItem(
          title: "Court & Cases",
          icon: Icons.balance,
          route: AppRoutes.COURT_CASES,
        ),
        DrawerItem(
          title: "Elections",
          icon: Icons.how_to_vote,
          route: AppRoutes.ELECTIONS,
        ),
        DrawerItem(
          title: "Ruling & Heart Winning",
          icon: Icons.emoji_flags,
          route: AppRoutes.HEART_WINNING,
        ),
        DrawerItem(
          title: "Spirituality & Lord-Shiva",
          icon: Icons.temple_hindu,
          route: AppRoutes.SPIRITUALITY_LORD_SHIVA,
        ),
        DrawerItem(
          title: "Prayer For All",
          icon: Icons.volunteer_activism,
          route: AppRoutes.PRAYER_FOR_ALL,
        ),
        DrawerItem(
          title: "Fingers Are Crossed",
          icon: Icons.cruelty_free,
          route: AppRoutes.FINGERS_ARE_CROSSED,
        ),
        DrawerItem(
          title: "Counting Reports- Both Hindi & English",
          icon: Icons.read_more,
          route: AppRoutes.COUNTING_REPORTS,
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
