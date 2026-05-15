import 'package:air_app/modules/advantage/advantage_binding.dart';
import 'package:air_app/modules/advantage/advantage_view.dart';
import 'package:air_app/modules/challenge/challenge_binding.dart';
import 'package:air_app/modules/challenge/challenge_view.dart';
import 'package:air_app/modules/commerce/commerce_binding.dart';
import 'package:air_app/modules/commerce/commerce_enhanced_view.dart';
import 'package:air_app/modules/digitalize_records/digitalize_records_binding.dart';
import 'package:air_app/modules/discovery/discovery_binding.dart';
import 'package:air_app/modules/discovery/discovery_enhanced_view.dart';
import 'package:air_app/modules/doctorate/doctorate_binding.dart';
import 'package:air_app/modules/doctorate/doctorate_enhanced_view.dart';
import 'package:air_app/modules/enhancement/enhancement_binding.dart';
import 'package:air_app/modules/enhancement/enhancement_enhanced_view.dart';
import 'package:air_app/modules/feedback/feedback_binding.dart';
import 'package:air_app/modules/feedback/feedback_enhanced_view.dart';
import 'package:air_app/modules/heigher_studies/heigher_studies_binding.dart';
import 'package:air_app/modules/heigher_studies/heigher_studies_enhanced_view.dart';
import 'package:air_app/modules/hope/hope_binding.dart';
import 'package:air_app/modules/hope/hope_enhanced_view.dart';
import 'package:air_app/modules/hospitality_care/hospitality_care_binding.dart';
import 'package:air_app/modules/hospitality_care/hospitality_care_enhanced_view.dart';
import 'package:air_app/modules/innovation/innovation_binding.dart';
import 'package:air_app/modules/innovation/innovation_enhanced_view.dart';
import 'package:air_app/modules/life_hacks/life_hacks_binding.dart';
import 'package:air_app/modules/life_hacks/life_hacks_enhanced_view.dart';
import 'package:air_app/modules/loop_hole/loop_hole_binding.dart';
import 'package:air_app/modules/loop_hole/loop_hole_enhanced_view.dart';
import 'package:air_app/modules/marketing_promotion/marketing_promotion_binding.dart';
import 'package:air_app/modules/marketing_promotion/marketing_promotion_enhanced_view.dart';
import 'package:air_app/modules/obligations/obligations_binding.dart';
import 'package:air_app/modules/obligations/obligations_enhanced_view.dart';
import 'package:air_app/modules/relationships/relationships_binding.dart';
import 'package:air_app/modules/relationships/relationships_enhanced_view.dart';
import 'package:air_app/modules/religion_prayer/religion_prayer_binding.dart';
import 'package:air_app/modules/religion_prayer/religion_prayer_enhanced_view.dart';
import 'package:air_app/modules/research_development/research_development_binding.dart';
import 'package:air_app/modules/research_development/research_development_enhanced_view.dart';
import 'package:air_app/modules/safety/safety_binding.dart';
import 'package:air_app/modules/safety/safety_enhanced_view.dart';
import 'package:air_app/modules/serve/serve_binding.dart';
import 'package:air_app/modules/serve/serve_enhanced_view.dart';
import 'package:air_app/modules/signup/signup_binding.dart';
import 'package:air_app/modules/signup/signup_enhanced_view.dart';
import 'package:air_app/modules/social/social_binding.dart';
import 'package:air_app/modules/social/social_enhanced_view.dart';
import 'package:air_app/modules/solution/solution_binding.dart';
import 'package:air_app/modules/solution/solution_enhanced_view.dart';
import 'package:air_app/modules/splash/spash_binding.dart';
import 'package:air_app/modules/splash/splash_screen.dart';
import 'package:air_app/modules/success_failure/success_failure_binding.dart';
import 'package:air_app/modules/success_failure/success_failure_enhanced_view.dart';
import 'package:air_app/modules/travel_transport/travel_transport_binding.dart';
import 'package:air_app/modules/travel_transport/travel_transport_enhanced_view.dart';
import 'package:air_app/modules/utility_facilities/utility_facilities_binding.dart';
import 'package:air_app/modules/utility_facilities/utility_facilities_enhanced_view.dart';
import 'package:get/get.dart';

import '../modules/about_app/about_app_binding.dart';
import '../modules/about_app/about_app_view.dart';
import '../modules/about_org/about_org_binding.dart';
import '../modules/about_org/about_org_view.dart';
import '../modules/affection_love/affection_love_binding.dart';
import '../modules/affection_love/affection_love_view.dart';
import '../modules/air_vision/air_vision_binding.dart';
import '../modules/air_vision/air_vision_view.dart';
import '../modules/airs_aspects/be_part_of_air/be_part_of_air_binding.dart';
import '../modules/airs_aspects/be_part_of_air/be_part_of_air_enhanced_view.dart';
import '../modules/airs_aspects/being_recorded_rewarded/being_recorded_rewarded_binding.dart';
import '../modules/airs_aspects/being_recorded_rewarded/being_recorded_rewarded_enhanced_view.dart';
import '../modules/airs_aspects/beliefs_values/beliefs_values_binding.dart';
import '../modules/airs_aspects/beliefs_values/beliefs_values_enhanced_view.dart';
import '../modules/airs_aspects/checked_anomalies/checked_anomalies_binding.dart';
import '../modules/airs_aspects/checked_anomalies/checked_anomalies_enhanced_view.dart';
import '../modules/airs_aspects/communication/communication_binding.dart';
import '../modules/airs_aspects/communication/communication_enhanced_view.dart';
import '../modules/airs_aspects/contribute_to_air/contribute_to_air_binding.dart';
import '../modules/airs_aspects/contribute_to_air/contribute_to_air_enhanced_view.dart';
import '../modules/airs_aspects/entertainment/entertainment_binding.dart';
import '../modules/airs_aspects/entertainment/entertainment_enhanced_view.dart';
import '../modules/airs_aspects/imagination_features/imagination_features_binding.dart';
import '../modules/airs_aspects/imagination_features/imagination_features_enhanced_view.dart';
import '../modules/airs_aspects/limits_0_1/limits_0_1_binding.dart';
import '../modules/airs_aspects/limits_0_1/limits_0_1_enhanced_view.dart';
import '../modules/airs_aspects/new_in_air/new_in_air_binding.dart';
import '../modules/airs_aspects/new_in_air/new_in_air_enhanced_view.dart';
// AIR's Aspects Imports
import '../modules/airs_aspects/resume_tour/resume_tour_binding.dart';
import '../modules/airs_aspects/resume_tour/resume_tour_enhanced_view.dart';
import '../modules/airs_aspects/skills_talents/skills_talents_binding.dart';
import '../modules/airs_aspects/skills_talents/skills_talents_enhanced_view.dart';
import '../modules/airs_aspects/timeline_of_air/timeline_of_air_binding.dart';
import '../modules/airs_aspects/timeline_of_air/timeline_of_air_enhanced_view.dart';
import '../modules/airs_aspects/training/training_binding.dart';
import '../modules/airs_aspects/training/training_enhanced_view.dart';
import '../modules/airs_aspects/unchecked_anomalies/unchecked_anomalies_binding.dart';
import '../modules/airs_aspects/unchecked_anomalies/unchecked_anomalies_enhanced_view.dart';
// AIR's Vision Details Imports
import '../modules/airs_vision_details/airs_mission/airs_mission_binding.dart';
import '../modules/airs_vision_details/airs_mission/airs_mission_enhanced_view.dart';
import '../modules/airs_vision_details/airs_showcase/airs_showcase_binding.dart';
import '../modules/airs_vision_details/airs_showcase/airs_showcase_enhanced_view.dart';
import '../modules/airs_vision_details/finally_blessings/finally_blessings_binding.dart';
import '../modules/airs_vision_details/finally_blessings/finally_blessings_enhanced_view.dart';
import '../modules/airs_vision_details/follow_calendar/follow_calendar_binding.dart';
import '../modules/airs_vision_details/follow_calendar/follow_calendar_enhanced_view.dart';
import '../modules/airs_vision_details/pick_good_going/pick_good_going_binding.dart';
import '../modules/airs_vision_details/pick_good_going/pick_good_going_enhanced_view.dart';
import '../modules/airs_vision_details/windup_else/windup_else_binding.dart';
import '../modules/airs_vision_details/windup_else/windup_else_enhanced_view.dart';
import '../modules/appreciations_thanks/appreciations_thanks_binding.dart';
import '../modules/appreciations_thanks/appreciations_thanks_view.dart';
import '../modules/category_docs/category_docs_binding.dart';
import '../modules/category_docs/category_docs_view.dart';
import '../modules/category_tree/category_tree_binding.dart';
import '../modules/category_tree/category_tree_view.dart';
import '../modules/code_conduct/code_conduct_binding.dart';
import '../modules/code_conduct/code_conduct_view.dart';
import '../modules/compitition/compitition_binding.dart';
import '../modules/compitition/compitition_enhanced_view.dart';
import '../modules/control_coordination/control_coordination_binding.dart';
import '../modules/control_coordination/control_coordination_enhanced_view.dart';
import '../modules/counting_reports/counting_reports_binding.dart';
import '../modules/counting_reports/counting_reports_enhanced_view.dart';
import '../modules/court_cases/court_cases_binding.dart';
import '../modules/court_cases/court_cases_enhanced_view.dart';
import '../modules/demonstration/demonstration_binding.dart';
import '../modules/demonstration/demonstration_enhanced_view.dart';
import '../modules/digitalize_records/digitalize_records_enhanced_view.dart';
import '../modules/ease_tools/ease_tools_binding.dart';
import '../modules/ease_tools/ease_tools_enhanced_view.dart';
import '../modules/elections/elections_binding.dart';
import '../modules/elections/elections_enhanced_view.dart';
import '../modules/empathy_sympathy/empathy_sympathy_binding.dart';
import '../modules/empathy_sympathy/empathy_sympathy_enhanced_view.dart';
import '../modules/engagements/engagements_binding.dart';
import '../modules/engagements/engagements_enhanced_view.dart';
import '../modules/family/family_binding.dart';
import '../modules/family/family_enhanced_view.dart';
import '../modules/fingers_are_crossed/fingers_are_crossed_binding.dart';
import '../modules/fingers_are_crossed/fingers_are_crossed_enhanced_view.dart';
import '../modules/forgivness/forgivness_binding.dart';
import '../modules/forgivness/forgivness_enhanced_view.dart';
import '../modules/friendship/friendship_binding.dart';
import '../modules/friendship/friendship_enhanced_view.dart';
import '../modules/ground_task/ground_task_binding.dart';
import '../modules/ground_task/ground_task_enhanced_view.dart';
import '../modules/group_discussions/group_discussions_binding.dart';
import '../modules/group_discussions/group_discussions_enhanced_view.dart';
import '../modules/heart_winning/heart_winning_binding.dart';
import '../modules/heart_winning/heart_winning_enhanced_view.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';
import '../modules/identities_earnings/identities_earnings_binding.dart';
import '../modules/identities_earnings/identities_earnings_enhanced_view.dart';
import '../modules/interviews/interviews_binding.dart';
import '../modules/interviews/interviews_enhanced_view.dart';
import '../modules/joining_services/joining_services_binding.dart';
import '../modules/joining_services/joining_services_enhanced_view.dart';
import '../modules/keep_adding_with_patience/keep_adding_with_patience_binding.dart';
import '../modules/keep_adding_with_patience/keep_adding_with_patience_enhanced_view.dart';
import '../modules/kindness/kindness_binding.dart';
import '../modules/kindness/kindness_enhanced_view.dart';
import '../modules/knowledge_center/knowledge_center_binding.dart';
import '../modules/knowledge_center/knowledge_center_enhanced_view.dart';
import '../modules/language_translation/language_translation_binding.dart';
import '../modules/language_translation/language_translation_enhanced_view.dart';
import '../modules/leadership/leadership_binding.dart';
import '../modules/leadership/leadership_enhanced_view.dart';
import '../modules/learn_fun/learn_fun_binding.dart';
import '../modules/learn_fun/learn_fun_enhanced_view.dart';
// System Core & Auth Imports
import '../modules/login/login_binding.dart';
import '../modules/login/login_enhanced_view.dart';
import '../modules/loyalty/loyalty_binding.dart';
import '../modules/loyalty/loyalty_enhanced_view.dart';
import '../modules/media_news/media_news_binding.dart';
import '../modules/media_news/media_news_enhanced_view.dart';
import '../modules/medical/medical_binding.dart';
import '../modules/medical/medical_enhanced_view.dart';
import '../modules/merits_demerits/merits_demerits_binding.dart';
import '../modules/merits_demerits/merits_demerits_enhanced_view.dart';
import '../modules/monitorship/monitorship_binding.dart';
import '../modules/monitorship/monitorship_enhanced_view.dart';
import '../modules/motivation_connectivity/accountable/accountable_binding.dart';
import '../modules/motivation_connectivity/accountable/accountable_enhanced_view.dart';
import '../modules/motivation_connectivity/get_connected/get_connected_binding.dart';
import '../modules/motivation_connectivity/get_connected/get_connected_enhanced_view.dart';
import '../modules/motivation_connectivity/greetings/greetings_binding.dart';
import '../modules/motivation_connectivity/greetings/greetings_enhanced_view.dart';
import '../modules/motivation_connectivity/innovation_key/innovation_key_binding.dart';
import '../modules/motivation_connectivity/innovation_key/innovation_key_enhanced_view.dart';
import '../modules/motivation_connectivity/live_fullest/live_fullest_binding.dart';
import '../modules/motivation_connectivity/live_fullest/live_fullest_enhanced_view.dart';
// Motivation & Connectivity Imports
import '../modules/motivation_connectivity/motivation/motivation_binding.dart';
import '../modules/motivation_connectivity/motivation/motivation_enhanced_view.dart';
import '../modules/motivation_connectivity/never_give_up/never_give_up_binding.dart';
import '../modules/motivation_connectivity/never_give_up/never_give_up_enhanced_view.dart';
import '../modules/motivation_connectivity/onboard/onboard_binding.dart';
import '../modules/motivation_connectivity/onboard/onboard_enhanced_view.dart';
import '../modules/motivation_connectivity/responsibilities/responsibilities_binding.dart';
import '../modules/motivation_connectivity/responsibilities/responsibilities_enhanced_view.dart';
import '../modules/motivation_connectivity/together_unison/together_unison_binding.dart';
import '../modules/motivation_connectivity/together_unison/together_unison_enhanced_view.dart';
import '../modules/only_one_way/only_one_way_binding.dart';
import '../modules/only_one_way/only_one_way_enhanced_view.dart';
import '../modules/peace_prosperity/peace_prosperity_binding.dart';
import '../modules/peace_prosperity/peace_prosperity_enhanced_view.dart';
import '../modules/prayer_for_all/prayer_for_all_binding.dart';
import '../modules/prayer_for_all/prayer_for_all_enhanced_view.dart';
import '../modules/products_services/products_services_binding.dart';
import '../modules/products_services/products_services_enhanced_view.dart';
import '../modules/projects_assessments/projects_assessments_binding.dart';
import '../modules/projects_assessments/projects_assessments_enhanced_view.dart';
import '../modules/punctuality/punctuality_binding.dart';
import '../modules/punctuality/punctuality_enhanced_view.dart';
import '../modules/queries/queries_binding.dart';
import '../modules/queries/queries_enhanced_view.dart';
import '../modules/query_discussion/query_discussion_binding.dart';
import '../modules/query_discussion/query_discussion_enhanced_view.dart';
import '../modules/ranking_orders/ranking_orders_binding.dart';
import '../modules/ranking_orders/ranking_orders_enhanced_view.dart';
import '../modules/record_post/record_post_binding.dart';
import '../modules/record_post/record_post_enhanced_view.dart';
import '../modules/respect/respect_binding.dart';
import '../modules/respect/respect_enhanced_view.dart';
import '../modules/rivalry/rivalry_binding.dart';
import '../modules/rivalry/rivalry_enhanced_view.dart';
import '../modules/rules_regulations/rules_regulations_binding.dart';
import '../modules/rules_regulations/rules_regulations_enhanced_view.dart';
import '../modules/script_strategy/script_strategy_binding.dart';
import '../modules/script_strategy/script_strategy_enhanced_view.dart';
import '../modules/self_discipline/self_discipline_binding.dart';
import '../modules/self_discipline/self_discipline_enhanced_view.dart';
// Service & Production Imports
import '../modules/service_production/input_in_process/input_in_process_binding.dart';
import '../modules/service_production/input_in_process/input_in_process_enhanced_view.dart';
import '../modules/service_production/outcome_processed/outcome_processed_binding.dart';
import '../modules/service_production/outcome_processed/outcome_processed_enhanced_view.dart';
import '../modules/service_production/practice_expertise/practice_expertise_binding.dart';
import '../modules/service_production/practice_expertise/practice_expertise_enhanced_view.dart';
import '../modules/service_production/process/process_binding.dart';
import '../modules/service_production/process/process_enhanced_view.dart';
import '../modules/service_production/revise_improve/revise_improve_binding.dart';
import '../modules/service_production/revise_improve/revise_improve_enhanced_view.dart';
import '../modules/service_production/share_care/share_care_binding.dart';
import '../modules/service_production/share_care/share_care_enhanced_view.dart';
import '../modules/service_production/system_all_together/system_all_together_binding.dart';
import '../modules/service_production/system_all_together/system_all_together_enhanced_view.dart';
import '../modules/settings/settings_binding.dart';
import '../modules/settings/settings_enhanced_view.dart';
import '../modules/share_experience/share_experience_binding.dart';
import '../modules/share_experience/share_experience_enhanced_view.dart';
import '../modules/situation_reaction/situation_reaction_binding.dart';
import '../modules/situation_reaction/situation_reaction_enhanced_view.dart';
import '../modules/spirituality_lord_shiva/spirituality_lord_shiva_binding.dart';
import '../modules/spirituality_lord_shiva/spirituality_lord_shiva_enhanced_view.dart';
import '../modules/statistics/statistics_binding.dart';
import '../modules/statistics/statistics_enhanced_view.dart';
import '../modules/survellence_investigation/survellence_investigation_binding.dart';
import '../modules/survellence_investigation/survellence_investigation_enhanced_view.dart';
import '../modules/technology/technology_binding.dart';
import '../modules/technology/technology_enhanced_view.dart';
import '../modules/trade_import_export/trade_import_export_binding.dart';
import '../modules/trade_import_export/trade_import_export_enhanced_view.dart';
import '../modules/universal_peace_rule/universal_peace_rule_binding.dart';
import '../modules/universal_peace_rule/universal_peace_rule_enhanced_view.dart';
import '../modules/utilities_guest/utilities_guest_binding.dart';
import '../modules/utilities_guest/utilities_guest_enhanced_view.dart';
import '../modules/vocabulary/vocabulary_binding.dart';
import '../modules/vocabulary/vocabulary_enhanced_view.dart';
import '../modules/wisdom/wisdom_binding.dart';
import '../modules/wisdom/wisdom_enhanced_view.dart';
import '../modules/world/world_binding.dart';
import '../modules/world/world_enhanced_view.dart';
import '../modules/your_profile_specifics/approval_appeals/approval_appeals_binding.dart';
import '../modules/your_profile_specifics/approval_appeals/approval_appeals_enhanced_view.dart';
import '../modules/your_profile_specifics/connect_collaborate/connect_collaborate_binding.dart';
import '../modules/your_profile_specifics/connect_collaborate/connect_collaborate_enhanced_view.dart';
// Your Profile Specifics Imports
import '../modules/your_profile_specifics/events/events_binding.dart';
import '../modules/your_profile_specifics/events/events_enhanced_view.dart';
import '../modules/your_profile_specifics/maintenance/maintenance_binding.dart';
import '../modules/your_profile_specifics/maintenance/maintenance_enhanced_view.dart';
import '../modules/your_profile_specifics/managements/managements_binding.dart';
import '../modules/your_profile_specifics/managements/managements_enhanced_view.dart';
import '../modules/your_profile_specifics/network_apis/network_apis_binding.dart';
import '../modules/your_profile_specifics/network_apis/network_apis_enhanced_view.dart';
import '../modules/your_profile_specifics/notices/notices_binding.dart';
import '../modules/your_profile_specifics/notices/notices_enhanced_view.dart';
import '../modules/your_profile_specifics/private_confidential/private_confidential_binding.dart';
import '../modules/your_profile_specifics/private_confidential/private_confidential_enhanced_view.dart';
import '../modules/your_profile_specifics/public_stuff/public_stuff_binding.dart';
import '../modules/your_profile_specifics/public_stuff/public_stuff_enhanced_view.dart';
import '../modules/your_profile_specifics/rewards_credits/rewards_credits_binding.dart';
import '../modules/your_profile_specifics/rewards_credits/rewards_credits_enhanced_view.dart';
import '../modules/your_profile_specifics/tracks_traces/tracks_traces_binding.dart';
import '../modules/your_profile_specifics/tracks_traces/tracks_traces_enhanced_view.dart';
import '../modules/your_profile_specifics/your_business/your_business_binding.dart';
import '../modules/your_profile_specifics/your_business/your_business_enhanced_view.dart';

class AppRoutes {
  static const SPLASH = '/splash';
  static const LOGIN = '/login';
  static const SIGNUP = '/signup';
  static const HOME = '/';
  static const SETTINGS = '/settings';
  static const LEARN_FUN = '/learn-fun';
  static const LEARN_DOCS = '/learn-docs';
  static const QUERIES = '/queries';
  static const WISDOM = '/wisdom';
  static const AIR_VISION = '/air-vision';
  static const SHARE_EXPERIENCE = '/share-experience';
  static const RECORD_POST = '/record-post';
  static const IDENTITIES_EARNINGS = '/identities-earnings';
  static const KNOWLEDGE_CENTER = '/knowledge-center';
  static const PRODUCTS_SERVICES = '/products-services';
  static const QUERY_DISCUSSION = '/query-discussion';

  // Your Profile Specifics Routes
  static const EVENTS = '/events';
  static const MANAGEMENTS = '/managements';
  static const MAINTENANCE = '/maintenance';
  static const CONNECT_COLLABORATE = '/connect-collaborate';
  static const NOTICES = '/notices';
  static const TRACKS_TRACES = '/tracks-traces';
  static const YOUR_BUSINESS = '/your-business';
  static const REWARDS_CREDITS = '/rewards-credits';
  static const APPROVAL_APPEALS = '/approval-appeals';
  static const NETWORK_APIS = '/network-apis';
  static const PRIVATE_CONFIDENTIAL = '/private-confidential';
  static const PUBLIC_STUFF = '/public-stuff';

  // AIR's Aspects Routes
  static const RESUME_TOUR = '/resume-tour';
  static const BE_PART_OF_AIR = '/be-part-of-air';
  static const CONTRIBUTE_TO_AIR = '/contribute-to-air';
  static const TIMELINE_OF_AIR = '/timeline-of-air';
  static const NEW_IN_AIR = '/new-in-air';
  static const CHECKED_ANOMALIES = '/checked-anomalies';
  static const UNCHECKED_ANOMALIES = '/unchecked-anomalies';
  static const LIMITS_0_1 = '/limits-01';
  static const COMMUNICATION = '/communication';
  static const IMAGINATION_FEATURES = '/imagination-features';
  static const BELIEFS_VALUES = '/beliefs-values';
  static const ENTERTAINMENT = '/entertainment';
  static const SKILLS_TALENTS = '/skills-talents';
  static const BEING_RECORDED_REWARDED = '/being-recorded-rewarded';
  static const TRAINING = '/training';

  // Service & Production Routes
  static const INPUT_IN_PROCESS = '/input-in-process';
  static const PROCESS = '/process';
  static const OUTCOME_PROCESSED = '/outcome-processed';
  static const SYSTEM_ALL_TOGETHER = '/system-all-together';
  static const REVISE_IMPROVE = '/revise-improve';
  static const PRACTICE_EXPERTISE = '/practice-expertise';
  static const SHARE_CARE = '/share-care';

  // AIR's Vision Details Routes
  static const AIRS_MISSION = '/airs-mission';
  static const AIRS_SHOWCASE = '/airs-showcase';
  static const WINDUP_ELSE = '/windup-else';
  static const FOLLOW_CALENDAR = '/follow-calendar';
  static const PICK_GOOD_GOING = '/pick-good-going';
  static const FINALLY_BLESSINGS = '/finally-blessings';

  // Motivation & Connectivity Routes
  static const MOTIVATION = '/motivation';
  static const NEVER_GIVE_UP = '/never-give-up';
  static const INNOVATION_KEY = '/innovation-key';
  static const ACCOUNTABLE = '/accountable';
  static const LIVE_FULLEST = '/live-fullest';
  static const GET_CONNECTED_SOCIAL = '/get-connected-social';
  static const TOGETHER_UNISON = '/together-unison';
  static const ONBOARD = '/onboard';
  static const GREETINGS = '/greetings';
  static const RESPONSIBILITIES = '/responsibilities';

  // System Core & Auth Routes
  static const LOGOUT = '/logout';
  static const UTILITIES_GUEST = '/utilities-guest';
  static const ABOUT_APP = '/about-app';
  static const ABOUT_ORG = '/about-org';
  static const digitalize_records = '/digitalize-records';
  static const projects_assessments = '/projects-assessments';
  static const category_tree = '/category-tree';
  static const ease_tools = '/ease-tools';
  static const vocabulary = '/vocabulary';
  static const script_strategy = '/script-strategy';
  static const code_conduct = '/code-conduct';
  static const SAFETY = '/safety';
  static const HOSPITALITY_CARE = '/hospitality-care';
  static const UTILITY_FACILITIES = '/utility-facilities';
  static const COMMERCE = '/commerce';
  static const SOCIAL = '/social';
  static const RESEARCH_DEVELOPMENT = '/research-development';
  static const TRAVEL_TRANSPORT = '/travel-transport';
  static const LOOP_HOLE = '/loop-hole';
  static const ADVANTAGE = '/advantage';
  static const CHALLENGE = '/challenge';
  static const SOLUTION = '/solution';
  static const INNOVATION = '/innovation';
  static const DISCOVERY = '/discovery';
  static const ENHANCEMENT = '/enhancement';
  static const HOPE = '/hope';
  static const SUCCESS_FAILURE = '/success-failure';
  static const RELIGION_PRAYER = '/religion-prayer';
  static const FEEDBACK = '/feedback';
  static const HEIGHER_STUDIES = '/heigher-studies';
  static const DOCTORATE = '/doctorate';
  static const LIFE_HACKS = '/life-hacks';
  static const serve = '/serve';
  static const marketing_promotion = '/marketing-promotion';
  static const RELATIONSHIPS = '/relationships';
  static const OBLIGATIONS = '/obligations';
  static const PUNCTUALITY = '/punctuality';
  static const LOYALTY = '/loyalty';
  static const APPRECIATIONS_THANKS = '/appreciations-thanks';
  static const EMPATHY_SYMPATHY = '/empathy-sympathy';
  static const FORGIVNESS = '/forgivness';
  static const KINDNESS = '/kindness';
  static const RESPECT = '/respect';
  static const SELF_DISCIPLINE = '/self-discipline';
  static const AFFECTION_LOVE = '/affection-love';
  static const FAMILY = '/family';
  static const FRIENDSHIP = '/friendship';
  static const RIVALRY = '/rivalry';
  static const COMPITITION = '/compitition';
  static const TECHNOLOGY = '/technology';
  static const LANGUAGE_TRANSLATION = '/language-translation';
  static const MONITORSHIP = '/monitorship';
  static const SURVELLENCE_INVESTIGATION = '/survellence-investigation';
  static const LEADERSHIP = '/leadership';
  static const CONTROL_COORDINATION = '/control-coordination';
  static const ONLY_ONE_WAY = '/only-one-way';
  static const TRADE_IMPORT_EXPORT = '/trade-import-export';
  static const RANKING_ORDERS = '/ranking-orders';
  static const STATISTICS = '/statistics';
  static const PEACE_PROSPERITY = '/peace-prosperity';
  static const WORLD = '/world';
  static const UNIVERSAL_PEACE_RULE = '/universal-peace-rule';
  static const KEEP_ADDING_WITH_PATIENCE = '/keep-adding';
  static const MEDIA_NEWS = '/media-news';
  static const ENGAGEMENTS = '/engagements';
  static const DEMONSTRATION = '/demonstration';
  static const GROUP_DISCUSSIONS = '/group-discussions';
  static const SITUATION_REACTION = '/situation-reaction';
  static const GROUND_TASK = '/ground-task';
  static const INTERVIEWS = '/interviews';
  static const MERITS_DEMERITS = '/merits-demerits';
  static const MEDICAL = '/medical';
  static const JOINING_SERVICES = '/joining-services';
  static const RULES_REGULATIONS = '/rules-regulations';
  static const COURT_CASES = '/court-cases';
  static const ELECTIONS = '/elections';
  static const HEART_WINNING = '/heart-winning';
  static const SPIRITUALITY_LORD_SHIVA = '/spirituality-lord-shiva';
  static const PRAYER_FOR_ALL = '/prayer-for-all';
  static const FINGERS_ARE_CROSSED = '/fingers-are-crossed';
  static const COUNTING_REPORTS = '/counting-reports';
}

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => const LoginEnhancedView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.SIGNUP,
      page: () => const SignupEnhancedView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.SETTINGS,
      page: () => const SettingsEnhancedView(),
      binding: SettingsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.LEARN_FUN,
      page: () => const LearnFunEnhancedView(),
      binding: LearnFunBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.LEARN_DOCS,
      page: () => const CategoryDocsView(),
      binding: CategoryDocsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.QUERIES,
      page: () => const QueriesEnhancedView(),
      binding: QueriesBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.WISDOM,
      page: () => const WisdomEnhancedView(),
      binding: WisdomBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.AIR_VISION,
      page: () => const AirVisionView(),
      binding: AirVisionBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.SHARE_EXPERIENCE,
      page: () => const ShareExperienceEnhancedView(),
      binding: ShareExperienceBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.RECORD_POST,
      page: () => const RecordPostEnhancedView(),
      binding: RecordPostBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.IDENTITIES_EARNINGS,
      page: () => const IdentitiesEarningsEnhancedView(),
      binding: IdentitiesEarningsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.KNOWLEDGE_CENTER,
      page: () => const KnowledgeCenterEnhancedView(),
      binding: KnowledgeCenterBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.PRODUCTS_SERVICES,
      page: () => const ProductsServicesEnhancedView(),
      binding: ProductsServicesBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.QUERY_DISCUSSION,
      page: () => const QueryDiscussionEnhancedView(),
      binding: QueryDiscussionBinding(),
      transition: Transition.rightToLeft,
    ),

    // Your Profile Specifics Pages
    GetPage(
      name: AppRoutes.EVENTS,
      page: () => const EventsEnhancedView(),
      binding: EventsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.MANAGEMENTS,
      page: () => const ManagementsEnhancedView(),
      binding: ManagementsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.MAINTENANCE,
      page: () => const MaintenanceEnhancedView(),
      binding: MaintenanceBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.CONNECT_COLLABORATE,
      page: () => const ConnectCollaborateEnhancedView(),
      binding: ConnectCollaborateBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.NOTICES,
      page: () => const NoticesEnhancedView(),
      binding: NoticesBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.TRACKS_TRACES,
      page: () => const TracksTracesEnhancedView(),
      binding: TracksTracesBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.YOUR_BUSINESS,
      page: () => const YourBusinessEnhancedView(),
      binding: YourBusinessBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.REWARDS_CREDITS,
      page: () => const RewardsCreditsEnhancedView(),
      binding: RewardsCreditsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.APPROVAL_APPEALS,
      page: () => const ApprovalAppealsEnhancedView(),
      binding: ApprovalAppealsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.NETWORK_APIS,
      page: () => const NetworkApisEnhancedView(),
      binding: NetworkApisBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.PRIVATE_CONFIDENTIAL,
      page: () => const PrivateConfidentialEnhancedView(),
      binding: PrivateConfidentialBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.PUBLIC_STUFF,
      page: () => const PublicStuffEnhancedView(),
      binding: PublicStuffBinding(),
      transition: Transition.rightToLeft,
    ),

    // AIR's Aspects Pages
    GetPage(
      name: AppRoutes.RESUME_TOUR,
      page: () => const ResumeTourEnhancedView(),
      binding: ResumeTourBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.BE_PART_OF_AIR,
      page: () => const BePartOfAirEnhancedView(),
      binding: BePartOfAirBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.CONTRIBUTE_TO_AIR,
      page: () => const ContributeToAirEnhancedView(),
      binding: ContributeToAirBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.TIMELINE_OF_AIR,
      page: () => const TimelineOfAirEnhancedView(),
      binding: TimelineOfAirBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.NEW_IN_AIR,
      page: () => const NewInAirEnhancedView(),
      binding: NewInAirBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.CHECKED_ANOMALIES,
      page: () => const CheckedAnomaliesEnhancedView(),
      binding: CheckedAnomaliesBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.UNCHECKED_ANOMALIES,
      page: () => const UncheckedAnomaliesEnhancedView(),
      binding: UncheckedAnomaliesBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.LIMITS_0_1,
      page: () => const Limits01EnhancedView(),
      binding: Limits01Binding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.COMMUNICATION,
      page: () => const CommunicationEnhancedView(),
      binding: CommunicationBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.IMAGINATION_FEATURES,
      page: () => const ImaginationFeaturesEnhancedView(),
      binding: ImaginationFeaturesBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.BELIEFS_VALUES,
      page: () => const BeliefsValuesEnhancedView(),
      binding: BeliefsValuesBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.ENTERTAINMENT,
      page: () => const EntertainmentEnhancedView(),
      binding: EntertainmentBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.SKILLS_TALENTS,
      page: () => const SkillsTalentsEnhancedView(),
      binding: SkillsTalentsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.BEING_RECORDED_REWARDED,
      page: () => const BeingRecordedRewardedEnhancedView(),
      binding: BeingRecordedRewardedBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.TRAINING,
      page: () => const TrainingEnhancedView(),
      binding: TrainingBinding(),
      transition: Transition.rightToLeft,
    ),

    // Service & Production Pages
    GetPage(
      name: AppRoutes.INPUT_IN_PROCESS,
      page: () => const InputInProcessEnhancedView(),
      binding: InputInProcessBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.PROCESS,
      page: () => const ProcessEnhancedView(),
      binding: ProcessBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.OUTCOME_PROCESSED,
      page: () => const OutcomeProcessedEnhancedView(),
      binding: OutcomeProcessedBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.SYSTEM_ALL_TOGETHER,
      page: () => const SystemAllTogetherEnhancedView(),
      binding: SystemAllTogetherBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.REVISE_IMPROVE,
      page: () => const ReviseImproveEnhancedView(),
      binding: ReviseImproveBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.PRACTICE_EXPERTISE,
      page: () => const PracticeExpertiseEnhancedView(),
      binding: PracticeExpertiseBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.SHARE_CARE,
      page: () => const ShareCareEnhancedView(),
      binding: ShareCareBinding(),
      transition: Transition.rightToLeft,
    ),

    // AIR's Vision Details Pages
    GetPage(
      name: AppRoutes.AIRS_MISSION,
      page: () => const AirsMissionEnhancedView(),
      binding: AirsMissionBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.AIRS_SHOWCASE,
      page: () => const AirsShowcaseEnhancedView(),
      binding: AirsShowcaseBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.WINDUP_ELSE,
      page: () => const WindupElseEnhancedView(),
      binding: WindupElseBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.FOLLOW_CALENDAR,
      page: () => const FollowCalendarEnhancedView(),
      binding: FollowCalendarBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.PICK_GOOD_GOING,
      page: () => const PickGoodGoingEnhancedView(),
      binding: PickGoodGoingBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.FINALLY_BLESSINGS,
      page: () => const FinallyBlessingsEnhancedView(),
      binding: FinallyBlessingsBinding(),
      transition: Transition.rightToLeft,
    ),

    // Motivation & Connectivity Pages
    GetPage(
      name: AppRoutes.MOTIVATION,
      page: () => const MotivationEnhancedView(),
      binding: MotivationBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.NEVER_GIVE_UP,
      page: () => const NeverGiveUpEnhancedView(),
      binding: NeverGiveUpBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.INNOVATION_KEY,
      page: () => const InnovationKeyEnhancedView(),
      binding: InnovationKeyBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.ACCOUNTABLE,
      page: () => const AccountableEnhancedView(),
      binding: AccountableBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.LIVE_FULLEST,
      page: () => const LiveFullestEnhancedView(),
      binding: LiveFullestBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.GET_CONNECTED_SOCIAL,
      page: () => const GetConnectedEnhancedView(),
      binding: GetConnectedBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.TOGETHER_UNISON,
      page: () => const TogetherUnisonEnhancedView(),
      binding: TogetherUnisonBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.ONBOARD,
      page: () => const OnboardEnhancedView(),
      binding: OnboardBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.GREETINGS,
      page: () => const GreetingsEnhancedView(),
      binding: GreetingsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.RESPONSIBILITIES,
      page: () => const ResponsibilitiesEnhancedView(),
      binding: ResponsibilitiesBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.LOGOUT,
      page: () => const LoginEnhancedView(),
      binding: LoginBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.UTILITIES_GUEST,
      page: () => const UtilitiesGuestEnhancedView(),
      binding: UtilitiesGuestBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.ABOUT_APP,
      page: () => const AboutAppView(),
      binding: AboutAppBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.ABOUT_ORG,
      page: () => const AboutOrgView(),
      binding: AboutOrgBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.digitalize_records,
      page: () => const DigitalizeRecordsEnhancedView(),
      binding: DigitalizeRecordsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.projects_assessments,
      page: () => const ProjectsAssessmentsEnhancedView(),
      binding: ProjectsAssessmentsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.category_tree,
      page: () => const CategoryTreeView(),
      binding: CategoryTreeBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.ease_tools,
      page: () => const EaseToolsEnhancedView(),
      binding: EaseToolsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.vocabulary,
      page: () => const VocabularyEnhancedView(),
      binding: VocabularyBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.script_strategy,
      page: () => const ScriptStrategyEnhancedView(),
      binding: ScriptStrategyBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.code_conduct,
      page: () => const CodeConductView(),
      binding: CodeConductBinding(),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: AppRoutes.SAFETY,
      page: () => const SafetyEnhancedView(),
      binding: SafetyBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.OBLIGATIONS,
      page: () => const ObligationsEnhancedView(),
      binding: ObligationsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.HOSPITALITY_CARE,
      page: () => const HospitalityCareEnhancedView(),
      binding: HospitalityCareBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.UTILITY_FACILITIES,
      page: () => const UtilityFacilitiesEnhancedView(),
      binding: UtilityFacilitiesBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.COMMERCE,
      page: () => const CommerceEnhancedView(),
      binding: CommerceBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.SOCIAL,
      page: () => const SocialEnhancedView(),
      binding: SocialBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.RESEARCH_DEVELOPMENT,
      page: () => const ResearchDevelopmentEnhancedView(),
      binding: ResearchDevelopmentBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.TRAVEL_TRANSPORT,
      page: () => const TravelTransportEnhancedView(),
      binding: TravelTransportBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.LOOP_HOLE,
      page: () => const LoopHoleEnhancedView(),
      binding: LoopHoleBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.ADVANTAGE,
      page: () => const AdvantageView(),
      binding: AdvantageBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.CHALLENGE,
      page: () => const ChallengeView(),
      binding: ChallengeBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.SOLUTION,
      page: () => const SolutionEnhancedView(),
      binding: SolutionBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.INNOVATION,
      page: () => const InnovationEnhancedView(),
      binding: InnovationBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.DISCOVERY,
      page: () => const DiscoveryEnhancedView(),
      binding: DiscoveryBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.ENHANCEMENT,
      page: () => const EnhancementEnhancedView(),
      binding: EnhancementBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.HOPE,
      page: () => const HopeEnhancedView(),
      binding: HopeBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.SUCCESS_FAILURE,
      page: () => const SuccessFailureEnhancedView(),
      binding: SuccessFailureBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.RELIGION_PRAYER,
      page: () => const ReligionPrayerEnhancedView(),
      binding: ReligionPrayerBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.FEEDBACK,
      page: () => const FeedbackEnhancedView(),
      binding: FeedbackBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.HEIGHER_STUDIES,
      page: () => const HeigherStudiesEnhancedView(),
      binding: HeigherStudiesBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.DOCTORATE,
      page: () => const DoctorateEnhancedView(),
      binding: DoctorateBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.LIFE_HACKS,
      page: () => const LifeHacksEnhancedView(),
      binding: LifeHacksBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.serve,
      page: () => const ServeEnhancedView(),
      binding: ServeBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.marketing_promotion,
      page: () => const MarketingPromotionEnhancedView(),
      binding: MarketingPromotionBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.RELATIONSHIPS,
      page: () => const RelationshipsEnhancedView(),
      binding: RelationshipsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.PUNCTUALITY,
      page: () => const PunctualityEnhancedView(),
      binding: PunctualityBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.LOYALTY,
      page: () => const LoyaltyEnhancedView(),
      binding: LoyaltyBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.APPRECIATIONS_THANKS,
      page: () => const AppreciationsThanksView(),
      binding: AppreciationsThanksBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.EMPATHY_SYMPATHY,
      page: () => const EmpathySympathyEnhancedView(),
      binding: EmpathySympathyBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.FORGIVNESS,
      page: () => const ForgivnessEnhancedView(),
      binding: ForgivnessBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.KINDNESS,
      page: () => const KindnessEnhancedView(),
      binding: KindnessBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.RESPECT,
      page: () => const RespectEnhancedView(),
      binding: RespectBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.SELF_DISCIPLINE,
      page: () => const SelfDisciplineEnhancedView(),
      binding: SelfDisciplineBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.AFFECTION_LOVE,
      page: () => const AffectionLoveView(),
      binding: AffectionLoveBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.FAMILY,
      page: () => const FamilyEnhancedView(),
      binding: FamilyBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.FRIENDSHIP,
      page: () => const FriendshipEnhancedView(),
      binding: FriendshipBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.RIVALRY,
      page: () => const RivalryEnhancedView(),
      binding: RivalryBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.COMPITITION,
      page: () => const CompititionEnhancedView(),
      binding: CompititionBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.TECHNOLOGY,
      page: () => const TechnologyEnhancedView(),
      binding: TechnologyBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.LANGUAGE_TRANSLATION,
      page: () => const LanguageTranslationEnhancedView(),
      binding: LanguageTranslationBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.MONITORSHIP,
      page: () => const MonitorshipEnhancedView(),
      binding: MonitorshipBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.SURVELLENCE_INVESTIGATION,
      page: () => const SurvellenceInvestigationEnhancedView(),
      binding: SurvellenceInvestigationBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.LEADERSHIP,
      page: () => const LeadershipEnhancedView(),
      binding: LeadershipBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.CONTROL_COORDINATION,
      page: () => const ControlCoordinationEnhancedView(),
      binding: ControlCoordinationBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.ONLY_ONE_WAY,
      page: () => const OnlyOneWayEnhancedView(),
      binding: OnlyOneWayBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.TRADE_IMPORT_EXPORT,
      page: () => const TradeImportExportEnhancedView(),
      binding: TradeImportExportBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.RANKING_ORDERS,
      page: () => const RankingOrdersEnhancedView(),
      binding: RankingOrdersBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.STATISTICS,
      page: () => const StatisticsEnhancedView(),
      binding: StatisticsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.PEACE_PROSPERITY,
      page: () => const PeaceProsperityEnhancedView(),
      binding: PeaceProsperityBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.WORLD,
      page: () => const WorldEnhancedView(),
      binding: WorldBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.UNIVERSAL_PEACE_RULE,
      page: () => const UniversalPeaceRuleEnhancedView(),
      binding: UniversalPeaceRuleBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.KEEP_ADDING_WITH_PATIENCE,
      page: () => const KeepAddingWithPatienceEnhancedView(),
      binding: KeepAddingWithPatienceBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.MEDIA_NEWS,
      page: () => const MediaNewsEnhancedView(),
      binding: MediaNewsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.ENGAGEMENTS,
      page: () => const EngagementsEnhancedView(),
      binding: EngagementsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.DEMONSTRATION,
      page: () => const DemonstrationEnhancedView(),
      binding: DemonstrationBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.GROUP_DISCUSSIONS,
      page: () => const GroupDiscussionsEnhancedView(),
      binding: GroupDiscussionsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.SITUATION_REACTION,
      page: () => const SituationReactionEnhancedView(),
      binding: SituationReactionBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.GROUND_TASK,
      page: () => const GroundTaskEnhancedView(),
      binding: GroundTaskBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.INTERVIEWS,
      page: () => const InterviewsEnhancedView(),
      binding: InterviewsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.MERITS_DEMERITS,
      page: () => const MeritsDemeritsEnhancedView(),
      binding: MeritsDemeritsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.MEDICAL,
      page: () => const MedicalEnhancedView(),
      binding: MedicalBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.JOINING_SERVICES,
      page: () => const JoiningServicesEnhancedView(),
      binding: JoiningServicesBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.RULES_REGULATIONS,
      page: () => const RulesRegulationsEnhancedView(),
      binding: RulesRegulationsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.COURT_CASES,
      page: () => const CourtCasesEnhancedView(),
      binding: CourtCasesBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.ELECTIONS,
      page: () => const ElectionsEnhancedView(),
      binding: ElectionsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.HEART_WINNING,
      page: () => const HeartWinningEnhancedView(),
      binding: HeartWinningBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.SPIRITUALITY_LORD_SHIVA,
      page: () => const SpiritualityLordShivaEnhancedView(),
      binding: SpiritualityLordShivaBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.PRAYER_FOR_ALL,
      page: () => const PrayerForAllEnhancedView(),
      binding: PrayerForAllBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.FINGERS_ARE_CROSSED,
      page: () => const FingersAreCrossedEnhancedView(),
      binding: FingersAreCrossedBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.COUNTING_REPORTS,
      page: () => const CountingReportsEnhancedView(),
      binding: CountingReportsBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}
