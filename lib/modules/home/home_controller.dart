import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';

class DrawerActualItem {
  int indexTab = 0;
  final String title;
  final IconData icon;
  final String route;
  GlobalKey? key;
  DrawerActualItem({
    required this.title,
    required this.icon,
    required this.route,
    this.key,
    this.indexTab = 0,
  });
}

class DrawerResultItem {
  final String title;
  final IconData icon;
  final String route;
  GlobalKey? key;
  DrawerResultItem({
    required this.title,
    required this.icon,
    required this.route,
    this.key,
  });
}

class DrawerActualSection {
  int indexSection = 0;
  final String title;
  final List<DrawerActualItem> items;

  DrawerActualSection({
    required this.title,
    required this.items,
    this.indexSection = 0,
  });
}

class DrawerResultSection {
  final String title;
  final List<DrawerResultItem> items;
  DrawerResultSection({required this.title, required this.items});
}

class HomeController extends GetxController {
  var currentIndex = 0.obs;
  RxList<DrawerResultSection> results = <DrawerResultSection>[].obs;

  void changePage(int index) {
    currentIndex.value = index;
  }

  final RxBool isDrawerSearchVisible = false.obs;

  final RxString drawerSearchText = ''.obs;

  final TextEditingController drawerSearchController = TextEditingController();

  // final ScrollController drawerScrollController = ScrollController();

  @override
  void onReady() {
    super.onReady();

    for (final section in drawerSections) {
      section.indexSection = drawerSections.indexOf(section);
      for (final item in section.items) {
        item.key = GlobalKey(debugLabel: "Actual_${item.route}");

        item.indexTab = section.items.indexOf(item);
        results.value.add(
          DrawerResultSection(
            title: section.title,
            items: section.items
                .map<DrawerResultItem>(
                  (item) => DrawerResultItem(
                    title: item.title,
                    icon: item.icon,
                    route: item.route,
                    key: GlobalKey(debugLabel: item.route),
                  ),
                )
                .toList(),
          ),
        );
      }
    }
    // drawerSearchController.text = "Sign";
    // getFilteredResults();
  }

  void getFilteredResults() {
    final query = drawerSearchText.value.trim().toLowerCase();
    results.value = [];
    if (query.isNotEmpty) {}

    for (final section in drawerSections) {
      List<DrawerResultItem> existingItemsPerSection = [];
      for (final item in section.items) {
        if ((item.title.toLowerCase().contains(query)) && query.isNotEmpty) {
          existingItemsPerSection = [
            ...existingItemsPerSection,
            DrawerResultItem(
              title: item.title,
              icon: item.icon,
              route: item.route,
              key: GlobalKey(debugLabel: item.route),
            ),
          ];
        }
      }
      if (existingItemsPerSection.isNotEmpty) {
        results.value = [
          ...results.value,
          DrawerResultSection(
            title: section.title,
            items: existingItemsPerSection,
          ),
        ];
      }
    }

    // return results;
  }

  /// =====================================================
  /// DRAWER DATA
  /// =====================================================
  // final ItemScrollController itemScrollSectionController =
  //     ItemScrollController();

  final ScrollController scrollController = ScrollController();
  final Map<String, double> itemOffsets = {
    "EXPLORE - ALIFIYAS": 0,
    "RULE - MAZEASTA": 620,
    "BE-YOU & EARN LIVING": 1180,
    "Use AIR's Space & Resources": 1620,
    "Your Profile Specifics": 2180,
    "AIR's - Aspects": 3920,
    "SERVICE & PRODUCTION": 6180,
    "AIR'S VISION": 6620,
    "MOTIVATION & CONNECTIVITY": 7460,
    "SETUP A-ONE": 9460,
    "SYSTEM CORE": 9880,
  };

  final List<DrawerActualSection> drawerSections = [
    DrawerActualSection(
      title: "EXPLORE - ALIFIYAS",
      items: [
        DrawerActualItem(
          title: 'Learn And Fun',
          icon: Icons.lightbulb_outline,
          route: AppRoutes.LEARN_FUN,
        ),
        DrawerActualItem(
          title: 'Learn Docs (by category)',
          icon: Icons.menu_book_outlined,
          route: AppRoutes.LEARN_DOCS,
        ),
        DrawerActualItem(
          title: 'Heigher Studies',
          icon: Icons.school_outlined,
          route: AppRoutes.HEIGHER_STUDIES,
        ),
        DrawerActualItem(
          title: 'Doctorate',
          icon: Icons.local_hospital,
          route: AppRoutes.DOCTORATE,
        ),
        DrawerActualItem(
          title: 'Life Hacks',
          icon: Icons.heat_pump_rounded,
          route: AppRoutes.LIFE_HACKS,
        ),
        DrawerActualItem(
          title: 'Ask Any Thing',
          icon: Icons.question_answer,
          route: AppRoutes.QUERIES,
        ),
      ],
    ),
    DrawerActualSection(
      title: "RULE - MAZEASTA",
      items: [
        DrawerActualItem(
          title: 'Wisdom',
          icon: Icons.book,
          route: AppRoutes.WISDOM,
        ),
        DrawerActualItem(
          title: 'Ask Any Thing',
          icon: Icons.question_answer,
          route: AppRoutes.QUERIES,
        ),
      ],
    ),
    DrawerActualSection(
      title: "BE-YOU & EARN LIVING",
      items: [
        DrawerActualItem(
          title: 'Share Experience',
          icon: Icons.share,
          route: AppRoutes.SHARE_EXPERIENCE,
        ),
        DrawerActualItem(
          title: 'Record Your Post',
          icon: Icons.post_add,
          route: AppRoutes.RECORD_POST,
        ),
        DrawerActualItem(
          title: 'Identities Cum Earnings',
          icon: Icons.format_list_numbered,
          route: AppRoutes.IDENTITIES_EARNINGS,
        ),
      ],
    ),
    DrawerActualSection(
      title: "Use AIR's Space & Resources",
      items: [
        DrawerActualItem(
          title: 'Knowledge Center',
          icon: Icons.unarchive,
          route: AppRoutes.KNOWLEDGE_CENTER,
        ),
        DrawerActualItem(
          title: 'Products & Services',
          icon: Icons.output,
          route: AppRoutes.PRODUCTS_SERVICES,
        ),
        DrawerActualItem(
          title: 'Query & Discussion',
          icon: Icons.question_answer,
          route: AppRoutes.QUERY_DISCUSSION,
        ),
        DrawerActualItem(
          title: 'Utilities as Guest',
          icon: Icons.extension_outlined,
          route: AppRoutes.UTILITIES_GUEST,
        ),
      ],
    ),
    DrawerActualSection(
      title: "Your Profile Specifics",
      items: [
        DrawerActualItem(
          title: 'Events',
          icon: Icons.event,
          route: AppRoutes.EVENTS,
        ),
        DrawerActualItem(
          title: 'Managements',
          icon: Icons.manage_accounts,
          route: AppRoutes.MANAGEMENTS,
        ),
        DrawerActualItem(
          title: 'Maintenance',
          icon: Icons.build_outlined,
          route: AppRoutes.MAINTENANCE,
        ),
        DrawerActualItem(
          title: 'Connect & Collaborate',
          icon: Icons.connect_without_contact,
          route: AppRoutes.CONNECT_COLLABORATE,
        ),
        DrawerActualItem(
          title: 'Notices',
          icon: Icons.notifications_none,
          route: AppRoutes.NOTICES,
        ),
        DrawerActualItem(
          title: 'Tracks & Traces',
          icon: Icons.track_changes,
          route: AppRoutes.TRACKS_TRACES,
        ),
        DrawerActualItem(
          title: 'Your Business',
          icon: Icons.business_sharp,
          route: AppRoutes.YOUR_BUSINESS,
        ),
        DrawerActualItem(
          title: 'Rewards/Credits',
          icon: Icons.diamond,
          route: AppRoutes.REWARDS_CREDITS,
        ),
        DrawerActualItem(
          title: 'Approval of Appeals',
          icon: Icons.approval,
          route: AppRoutes.APPROVAL_APPEALS,
        ),
        DrawerActualItem(
          title: 'Network(APIs) Stuff',
          icon: Icons.api,
          route: AppRoutes.NETWORK_APIS,
        ),
        DrawerActualItem(
          title: 'Private/Confidential Stuff',
          icon: Icons.public_off,
          route: AppRoutes.PRIVATE_CONFIDENTIAL,
        ),
        DrawerActualItem(
          title: 'Public Stuff',
          icon: Icons.public,
          route: AppRoutes.PUBLIC_STUFF,
        ),
      ],
    ),
    DrawerActualSection(
      title: "AIR's - Aspects",
      items: [
        DrawerActualItem(
          title: "Let's resume your tour",
          icon: Icons.travel_explore,
          route: AppRoutes.RESUME_TOUR,
        ),
        DrawerActualItem(
          title: "Be the part of AIR",
          icon: Icons.grade,
          route: AppRoutes.BE_PART_OF_AIR,
        ),
        DrawerActualItem(
          title: "Contribute to AIR",
          icon: Icons.add_box,
          route: AppRoutes.CONTRIBUTE_TO_AIR,
        ),
        DrawerActualItem(
          title: "Timeline of AIR",
          icon: Icons.timeline,
          route: AppRoutes.TIMELINE_OF_AIR,
        ),
        DrawerActualItem(
          title: "New in AIR",
          icon: Icons.new_releases,
          route: AppRoutes.NEW_IN_AIR,
        ),
        DrawerActualItem(
          title: 'Checked Space Anomalies',
          icon: Icons.check_circle_outline_rounded,
          route: AppRoutes.CHECKED_ANOMALIES,
        ),
        DrawerActualItem(
          title: 'Un-Checked Space Anomalies',
          icon: Icons.question_mark_outlined,
          route: AppRoutes.UNCHECKED_ANOMALIES,
        ),
        DrawerActualItem(
          title: 'Limits (0 or 1)',
          icon: Icons.calculate_outlined,
          route: AppRoutes.LIMITS_0_1,
        ),
        DrawerActualItem(
          title: 'Communication',
          icon: Icons.transform_rounded,
          route: AppRoutes.COMMUNICATION,
        ),
        DrawerActualItem(
          title: 'Imagination & Features',
          icon: Icons.featured_play_list_outlined,
          route: AppRoutes.IMAGINATION_FEATURES,
        ),
        DrawerActualItem(
          title: 'Beliefs & Values',
          icon: Icons.flag_outlined,
          route: AppRoutes.BELIEFS_VALUES,
        ),
        DrawerActualItem(
          title: 'Entertainment',
          icon: Icons.play_circle_outline_rounded,
          route: AppRoutes.ENTERTAINMENT,
        ),
        DrawerActualItem(
          title: 'Skills & Talents',
          icon: Icons.star_border_rounded,
          route: AppRoutes.SKILLS_TALENTS,
        ),
        DrawerActualItem(
          title: "Being Recorded & Rewarded",
          icon: Icons.data_object_rounded,
          route: AppRoutes.BEING_RECORDED_REWARDED,
        ),
        DrawerActualItem(
          title: "Training",
          icon: Icons.lens_blur_rounded,
          route: AppRoutes.TRAINING,
        ),
        DrawerActualItem(
          title: "System All Together",
          icon: Icons.all_inclusive_rounded,
          route: AppRoutes.SYSTEM_ALL_TOGETHER,
        ),
      ],
    ),
    DrawerActualSection(
      title: "SERVICE & PRODUCTION",
      items: [
        DrawerActualItem(
          title: "Input in Process",
          icon: Icons.arrow_forward_ios_rounded,
          route: AppRoutes.INPUT_IN_PROCESS,
        ),
        DrawerActualItem(
          title: "Process",
          icon: Icons.gavel_rounded,
          route: AppRoutes.PROCESS,
        ),
        DrawerActualItem(
          title: "Outcome of Processed",
          icon: Icons.computer_sharp,
          route: AppRoutes.OUTCOME_PROCESSED,
        ),
      ],
    ),
    DrawerActualSection(
      title: "AIR'S VISION",
      items: [
        DrawerActualItem(
          title: "AIR's Vision",
          icon: Icons.visibility_outlined,
          route: AppRoutes.AIR_VISION,
        ),
        DrawerActualItem(
          title: "AIR's Mission",
          icon: Icons.music_note_sharp,
          route: AppRoutes.AIRS_MISSION,
        ),
        DrawerActualItem(
          title: "AIR's Show Case",
          icon: Icons.show_chart,
          route: AppRoutes.AIRS_SHOWCASE,
        ),
        DrawerActualItem(
          title: "Let's Windup Else",
          icon: Icons.wrap_text,
          route: AppRoutes.WINDUP_ELSE,
        ),
        DrawerActualItem(
          title: "Follow like Calender",
          icon: Icons.calendar_month_outlined,
          route: AppRoutes.FOLLOW_CALENDAR,
        ),
        DrawerActualItem(
          title: "Pick Your Good Going",
          icon: Icons.golf_course,
          route: AppRoutes.PICK_GOOD_GOING,
        ),
      ],
    ),
    DrawerActualSection(
      title: "MOTIVATION & CONNECTIVITY",
      items: [
        DrawerActualItem(
          title: "Revise & Improve",
          icon: Icons.icecream_rounded,
          route: AppRoutes.REVISE_IMPROVE,
        ),
        DrawerActualItem(
          title: "Practice & Expertise",
          icon: Icons.hail_outlined,
          route: AppRoutes.PRACTICE_EXPERTISE,
        ),
        DrawerActualItem(
          title: "Share & Care",
          icon: Icons.handshake_rounded,
          route: AppRoutes.SHARE_CARE,
        ),
        DrawerActualItem(
          title: "Finnally All is Blessings",
          icon: Icons.widgets,
          route: AppRoutes.FINALLY_BLESSINGS,
        ),
        DrawerActualItem(
          title: "A Word of Motivation",
          icon: Icons.elderly_sharp,
          route: AppRoutes.MOTIVATION,
        ),
        DrawerActualItem(
          title: "Never Give Up",
          icon: Icons.window,
          route: AppRoutes.NEVER_GIVE_UP,
        ),
        DrawerActualItem(
          title: "Innovation is Key",
          icon: Icons.lightbulb_outline,
          route: AppRoutes.INNOVATION_KEY,
        ),
        DrawerActualItem(
          title: "You Got All of it Accountable",
          icon: Icons.account_balance_wallet,
          route: AppRoutes.ACCOUNTABLE,
        ),
        DrawerActualItem(
          title: "Live Life to the Fullest",
          icon: Icons.favorite,
          route: AppRoutes.LIVE_FULLEST,
        ),
        DrawerActualItem(
          title: "Get Connected",
          icon: Icons.groups_2_rounded,
          route: AppRoutes.GET_CONNECTED_SOCIAL,
        ),
        DrawerActualItem(
          title: "Being Together is Unison",
          icon: Icons.compare_arrows,
          route: AppRoutes.TOGETHER_UNISON,
        ),
        DrawerActualItem(
          title: "Great to Have You Onboard",
          icon: Icons.airplanemode_active,
          route: AppRoutes.ONBOARD,
        ),
        DrawerActualItem(
          title: "All Greetings",
          icon: Icons.waving_hand,
          route: AppRoutes.GREETINGS,
        ),
        DrawerActualItem(
          title: "Be Liable to Responsibilities",
          icon: Icons.home_work_rounded,
          route: AppRoutes.RESPONSIBILITIES,
        ),
      ],
    ),
    DrawerActualSection(
      title: "SETUP A-ONE",
      items: [
        DrawerActualItem(
          title: "Product & Record (DIGITALIZE)",
          icon: Icons.all_inclusive_rounded,
          route: AppRoutes.digitalize_records,
        ),
        DrawerActualItem(
          title: "Projects & Assessments",
          icon: Icons.assessment,
          route: AppRoutes.projects_assessments,
        ),
        DrawerActualItem(
          title: "Category Tree",
          icon: Icons.local_florist,
          route: AppRoutes.category_tree,
        ),
        DrawerActualItem(
          title: "Ease Tools",
          icon: Icons.handyman,
          route: AppRoutes.ease_tools,
        ),
        DrawerActualItem(
          title: "Vocabulary",
          icon: Icons.wordpress,
          route: AppRoutes.vocabulary,
        ),
        DrawerActualItem(
          title: "Code & Conduct",
          icon: Icons.code,
          route: AppRoutes.code_conduct,
        ),
        DrawerActualItem(
          title: "Script & Strategy",
          icon: Icons.video_collection,
          route: AppRoutes.script_strategy,
        ),
        DrawerActualItem(
          title: "Safety",
          icon: Icons.safety_check,
          route: AppRoutes.SAFETY,
        ),
        DrawerActualItem(
          title: "Hospitality & Care",
          icon: Icons.self_improvement_rounded,
          route: AppRoutes.HOSPITALITY_CARE,
        ),
        DrawerActualItem(
          title: "Utility & Facilities",
          icon: Icons.amp_stories_rounded,
          route: AppRoutes.UTILITY_FACILITIES,
        ),
        DrawerActualItem(
          title: "Commerce",
          icon: Icons.cabin,
          route: AppRoutes.COMMERCE,
        ),
        DrawerActualItem(
          title: "Social",
          icon: Icons.social_distance,
          route: AppRoutes.SOCIAL,
        ),
        DrawerActualItem(
          title: "Research & Development",
          icon: Icons.science_outlined,
          route: AppRoutes.RESEARCH_DEVELOPMENT,
        ),
        DrawerActualItem(
          title: "Travel & Transport",
          icon: Icons.flight_land_outlined,
          route: AppRoutes.TRAVEL_TRANSPORT,
        ),
        DrawerActualItem(
          title: "Loop Hole",
          icon: Icons.loop,
          route: AppRoutes.LOOP_HOLE,
        ),
        DrawerActualItem(
          title: "Advantage",
          icon: Icons.star_border_rounded,
          route: AppRoutes.ADVANTAGE,
        ),
        DrawerActualItem(
          title: "Challenge",
          icon: Icons.flag_outlined,
          route: AppRoutes.CHALLENGE,
        ),
        DrawerActualItem(
          title: "Solution",
          icon: Icons.lightbulb_outline,
          route: AppRoutes.SOLUTION,
        ),
        DrawerActualItem(
          title: "Innovation",
          icon: Icons.new_label,
          route: AppRoutes.INNOVATION,
        ),
        DrawerActualItem(
          title: "Discovery",
          icon: Icons.search,
          route: AppRoutes.DISCOVERY,
        ),
        DrawerActualItem(
          title: "Enhancement",
          icon: Icons.auto_fix_high,
          route: AppRoutes.ENHANCEMENT,
        ),
        DrawerActualItem(
          title: "Hope",
          icon: Icons.cloud_rounded,
          route: AppRoutes.HOPE,
        ),
        DrawerActualItem(
          title: "Success & Failure",
          icon: Icons.star,
          route: AppRoutes.SUCCESS_FAILURE,
        ),
        DrawerActualItem(
          title: "Religion & Prayer",
          icon: Icons.auto_fix_high,
          route: AppRoutes.RELIGION_PRAYER,
        ),

        DrawerActualItem(
          title: "Feedback",
          icon: Icons.feedback,
          route: AppRoutes.FEEDBACK,
        ),
        DrawerActualItem(
          title: "Marketing & Promotion",
          icon: Icons.shop,
          route: AppRoutes.marketing_promotion,
        ),
        DrawerActualItem(
          title: "Serve",
          icon: Icons.volunteer_activism,
          route: AppRoutes.serve,
        ),
        DrawerActualItem(
          title: "Relationships",
          icon: Icons.group,
          route: AppRoutes.RELATIONSHIPS,
        ),
        DrawerActualItem(
          title: "Obligations",
          icon: Icons.rule,
          route: AppRoutes.OBLIGATIONS,
        ),
        DrawerActualItem(
          title: "Punctuality",
          icon: Icons.watch_later_outlined,
          route: AppRoutes.PUNCTUALITY,
        ),
        DrawerActualItem(
          title: "Loyalty",
          icon: Icons.verified_user,
          route: AppRoutes.LOYALTY,
        ),
        DrawerActualItem(
          title: "Appreciations & Thanks",
          icon: Icons.wallet_giftcard,
          route: AppRoutes.APPRECIATIONS_THANKS,
        ),
        DrawerActualItem(
          title: "Empathy & Sympathy",
          icon: Icons.heart_broken,
          route: AppRoutes.EMPATHY_SYMPATHY,
        ),
        DrawerActualItem(
          title: "Forgivness",
          icon: Icons.forest,
          route: AppRoutes.FORGIVNESS,
        ),
        DrawerActualItem(
          title: "Kindness & Politeness",
          icon: Icons.face,
          route: AppRoutes.KINDNESS,
        ),
        DrawerActualItem(
          title: "Respect",
          icon: Icons.account_circle_sharp,
          route: AppRoutes.RESPECT,
        ),
        DrawerActualItem(
          title: "Discipline",
          icon: Icons.architecture,
          route: AppRoutes.SELF_DISCIPLINE,
        ),
        DrawerActualItem(
          title: "Affection & Love",
          icon: Icons.favorite,
          route: AppRoutes.AFFECTION_LOVE,
        ),
        DrawerActualItem(
          title: "Family",
          icon: Icons.family_restroom,
          route: AppRoutes.FAMILY,
        ),
        DrawerActualItem(
          title: "Friendship",
          icon: Icons.people_outline,
          route: AppRoutes.FRIENDSHIP,
        ),
        DrawerActualItem(
          title: "Rivalry And War",
          icon: Icons.military_tech,
          route: AppRoutes.RIVALRY,
        ),
        DrawerActualItem(
          title: "Competition",
          icon: Icons.flag,
          route: AppRoutes.COMPITITION,
        ),
        DrawerActualItem(
          title: "Technology",
          icon: Icons.computer,
          route: AppRoutes.TECHNOLOGY,
        ),
        DrawerActualItem(
          title: "Language & Translation",
          icon: Icons.language,
          route: AppRoutes.LANGUAGE_TRANSLATION,
        ),
        DrawerActualItem(
          title: "Monitorship",
          icon: Icons.remove_red_eye,
          route: AppRoutes.MONITORSHIP,
        ),
        DrawerActualItem(
          title: "Survellence & Investigation",
          icon: Icons.security,
          route: AppRoutes.SURVELLENCE_INVESTIGATION,
        ),
        DrawerActualItem(
          title: "Leadership",
          icon: Icons.co_present_rounded,
          route: AppRoutes.LEADERSHIP,
        ),
        DrawerActualItem(
          title: "Control & Coordination",
          icon: Icons.pan_tool_alt_outlined,
          route: AppRoutes.CONTROL_COORDINATION,
        ),
        DrawerActualItem(
          title: "The Present - The Only One Way",
          icon: Icons.currency_rupee,
          route: AppRoutes.ONLY_ONE_WAY,
        ),
        DrawerActualItem(
          title: "Trade Import-Export",
          icon: Icons.import_export,
          route: AppRoutes.TRADE_IMPORT_EXPORT,
        ),
        DrawerActualItem(
          title: "Ranking Orders",
          icon: Icons.format_list_numbered,
          route: AppRoutes.RANKING_ORDERS,
        ),
        DrawerActualItem(
          title: "Statistics",
          icon: Icons.show_chart,
          route: AppRoutes.STATISTICS,
        ),
        DrawerActualItem(
          title: "Peace and Prosperity",
          icon: Icons.landscape_rounded,
          route: AppRoutes.PEACE_PROSPERITY,
        ),
        DrawerActualItem(
          title: "World",
          icon: Icons.public,
          route: AppRoutes.WORLD,
        ),
        DrawerActualItem(
          title: "Universal Peace Rule",
          icon: Icons.gavel,
          route: AppRoutes.UNIVERSAL_PEACE_RULE,
        ),
        DrawerActualItem(
          title: "Keep Adding With Patience",
          icon: Icons.add,
          route: AppRoutes.KEEP_ADDING_WITH_PATIENCE,
        ),
        DrawerActualItem(
          title: "Media & News",
          icon: Icons.newspaper,
          route: AppRoutes.MEDIA_NEWS,
        ),
        DrawerActualItem(
          title: "Engagements",
          icon: Icons.energy_savings_leaf,
          route: AppRoutes.ENGAGEMENTS,
        ),
        DrawerActualItem(
          title: "Demonstration",
          icon: Icons.engineering,
          route: AppRoutes.DEMONSTRATION,
        ),
        DrawerActualItem(
          title: "Group Discussions",
          icon: Icons.chat,
          route: AppRoutes.GROUP_DISCUSSIONS,
        ),
        DrawerActualItem(
          title: "Situation & Reaction",
          icon: Icons.announcement,
          route: AppRoutes.SITUATION_REACTION,
        ),
        DrawerActualItem(
          title: "Ground Task",
          icon: Icons.task_alt,
          route: AppRoutes.GROUND_TASK,
        ),
        DrawerActualItem(
          title: "Interviews",
          icon: Icons.record_voice_over,
          route: AppRoutes.INTERVIEWS,
        ),
        DrawerActualItem(
          title: "Merits and Demerits",
          icon: Icons.list_alt_rounded,
          route: AppRoutes.MERITS_DEMERITS,
        ),
        DrawerActualItem(
          title: "Medical Test",
          icon: Icons.medical_services,
          route: AppRoutes.MEDICAL,
        ),
        DrawerActualItem(
          title: "Joining Services",
          icon: Icons.join_right_rounded,
          route: AppRoutes.JOINING_SERVICES,
        ),
        DrawerActualItem(
          title: "Rules & Regulations",
          icon: Icons.rule_folder_rounded,
          route: AppRoutes.RULES_REGULATIONS,
        ),
        DrawerActualItem(
          title: "Court & Cases",
          icon: Icons.balance,
          route: AppRoutes.COURT_CASES,
        ),
        DrawerActualItem(
          title: "Elections",
          icon: Icons.how_to_vote,
          route: AppRoutes.ELECTIONS,
        ),
        DrawerActualItem(
          title: "Ruling & Heart Winning",
          icon: Icons.emoji_flags,
          route: AppRoutes.HEART_WINNING,
        ),
        DrawerActualItem(
          title: "Spirituality & Lord-Shiva",
          icon: Icons.temple_hindu,
          route: AppRoutes.SPIRITUALITY_LORD_SHIVA,
        ),
        DrawerActualItem(
          title: "Prayer For All",
          icon: Icons.volunteer_activism,
          route: AppRoutes.PRAYER_FOR_ALL,
        ),
        DrawerActualItem(
          title: "Fingers Are Crossed",
          icon: Icons.cruelty_free,
          route: AppRoutes.FINGERS_ARE_CROSSED,
        ),
        DrawerActualItem(
          title: "Counting Reports- Both Hindi & English",
          icon: Icons.read_more,
          route: AppRoutes.COUNTING_REPORTS,
        ),
      ],
    ),
    DrawerActualSection(
      title: "SYSTEM CORE",
      items: [
        DrawerActualItem(
          title: 'App Setting',
          icon: Icons.settings,
          route: AppRoutes.SETTINGS,
        ),
        DrawerActualItem(
          title: 'About AIR-APP',
          icon: Icons.air,
          route: AppRoutes.ABOUT_APP,
        ),
        DrawerActualItem(
          title: 'About AIR Organization',
          icon: Icons.info,
          route: AppRoutes.ABOUT_ORG,
        ),
        DrawerActualItem(
          title: 'Sign Out',
          icon: Icons.logout_rounded,
          route: AppRoutes.LOGOUT,
        ),
      ],
    ),
  ];
}
