import 'package:air_app/modules/digitalize_records/digitalize_records_binding.dart';
import 'package:get/get.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';
import '../modules/settings/settings_binding.dart';
import '../modules/settings/settings_view.dart';
import '../modules/learn_fun/learn_fun_binding.dart';
import '../modules/learn_fun/learn_fun_view.dart';
import '../modules/category_docs/category_docs_binding.dart';
import '../modules/category_docs/category_docs_view.dart';
import '../modules/queries/queries_binding.dart';
import '../modules/queries/queries_view.dart';
import '../modules/wisdom/wisdom_binding.dart';
import '../modules/wisdom/wisdom_view.dart';
import '../modules/air_vision/air_vision_binding.dart';
import '../modules/air_vision/air_vision_view.dart';
import '../modules/share_experience/share_experience_binding.dart';
import '../modules/share_experience/share_experience_view.dart';
import '../modules/record_post/record_post_binding.dart';
import '../modules/record_post/record_post_view.dart';
import '../modules/identities_earnings/identities_earnings_binding.dart';
import '../modules/identities_earnings/identities_earnings_view.dart';
import '../modules/knowledge_center/knowledge_center_binding.dart';
import '../modules/knowledge_center/knowledge_center_view.dart';
import '../modules/products_services/products_services_binding.dart';
import '../modules/products_services/products_services_view.dart';
import '../modules/query_discussion/query_discussion_binding.dart';
import '../modules/query_discussion/query_discussion_view.dart';
import '../modules/digitalize_records/digitalize_records_view.dart';
import '../modules/projects_assessments/projects_assessments_binding.dart';
import '../modules/projects_assessments/projects_assessments_view.dart';

// Your Profile Specifics Imports
import '../modules/your_profile_specifics/events/events_binding.dart';
import '../modules/your_profile_specifics/events/events_view.dart';
import '../modules/your_profile_specifics/managements/managements_binding.dart';
import '../modules/your_profile_specifics/managements/managements_view.dart';
import '../modules/your_profile_specifics/maintenance/maintenance_binding.dart';
import '../modules/your_profile_specifics/maintenance/maintenance_view.dart';
import '../modules/your_profile_specifics/connect_collaborate/connect_collaborate_binding.dart';
import '../modules/your_profile_specifics/connect_collaborate/connect_collaborate_view.dart';
import '../modules/your_profile_specifics/notices/notices_binding.dart';
import '../modules/your_profile_specifics/notices/notices_view.dart';
import '../modules/your_profile_specifics/tracks_traces/tracks_traces_binding.dart';
import '../modules/your_profile_specifics/tracks_traces/tracks_traces_view.dart';
import '../modules/your_profile_specifics/your_business/your_business_binding.dart';
import '../modules/your_profile_specifics/your_business/your_business_view.dart';
import '../modules/your_profile_specifics/rewards_credits/rewards_credits_binding.dart';
import '../modules/your_profile_specifics/rewards_credits/rewards_credits_view.dart';
import '../modules/your_profile_specifics/approval_appeals/approval_appeals_binding.dart';
import '../modules/your_profile_specifics/approval_appeals/approval_appeals_view.dart';
import '../modules/your_profile_specifics/network_apis/network_apis_binding.dart';
import '../modules/your_profile_specifics/network_apis/network_apis_view.dart';
import '../modules/your_profile_specifics/private_confidential/private_confidential_binding.dart';
import '../modules/your_profile_specifics/private_confidential/private_confidential_view.dart';
import '../modules/your_profile_specifics/public_stuff/public_stuff_binding.dart';
import '../modules/your_profile_specifics/public_stuff/public_stuff_view.dart';

// AIR's Aspects Imports
import '../modules/airs_aspects/resume_tour/resume_tour_binding.dart';
import '../modules/airs_aspects/resume_tour/resume_tour_view.dart';
import '../modules/airs_aspects/be_part_of_air/be_part_of_air_binding.dart';
import '../modules/airs_aspects/be_part_of_air/be_part_of_air_view.dart';
import '../modules/airs_aspects/contribute_to_air/contribute_to_air_binding.dart';
import '../modules/airs_aspects/contribute_to_air/contribute_to_air_view.dart';
import '../modules/airs_aspects/timeline_of_air/timeline_of_air_binding.dart';
import '../modules/airs_aspects/timeline_of_air/timeline_of_air_view.dart';
import '../modules/airs_aspects/new_in_air/new_in_air_binding.dart';
import '../modules/airs_aspects/new_in_air/new_in_air_view.dart';
import '../modules/airs_aspects/checked_anomalies/checked_anomalies_binding.dart';
import '../modules/airs_aspects/checked_anomalies/checked_anomalies_view.dart';
import '../modules/airs_aspects/unchecked_anomalies/unchecked_anomalies_binding.dart';
import '../modules/airs_aspects/unchecked_anomalies/unchecked_anomalies_view.dart';
import '../modules/airs_aspects/limits_0_1/limits_0_1_binding.dart';
import '../modules/airs_aspects/limits_0_1/limits_0_1_view.dart';
import '../modules/airs_aspects/communication/communication_binding.dart';
import '../modules/airs_aspects/communication/communication_view.dart';
import '../modules/airs_aspects/imagination_features/imagination_features_binding.dart';
import '../modules/airs_aspects/imagination_features/imagination_features_view.dart';
import '../modules/airs_aspects/beliefs_values/beliefs_values_binding.dart';
import '../modules/airs_aspects/beliefs_values/beliefs_values_view.dart';
import '../modules/airs_aspects/entertainment/entertainment_binding.dart';
import '../modules/airs_aspects/entertainment/entertainment_view.dart';
import '../modules/airs_aspects/skills_talents/skills_talents_binding.dart';
import '../modules/airs_aspects/skills_talents/skills_talents_view.dart';
import '../modules/airs_aspects/being_recorded_rewarded/being_recorded_rewarded_binding.dart';
import '../modules/airs_aspects/being_recorded_rewarded/being_recorded_rewarded_view.dart';
import '../modules/airs_aspects/training/training_binding.dart';
import '../modules/airs_aspects/training/training_view.dart';

// Service & Production Imports
import '../modules/service_production/input_in_process/input_in_process_binding.dart';
import '../modules/service_production/input_in_process/input_in_process_view.dart';
import '../modules/service_production/process/process_binding.dart';
import '../modules/service_production/process/process_view.dart';
import '../modules/service_production/outcome_processed/outcome_processed_binding.dart';
import '../modules/service_production/outcome_processed/outcome_processed_view.dart';
import '../modules/service_production/system_all_together/system_all_together_binding.dart';
import '../modules/service_production/system_all_together/system_all_together_view.dart';
import '../modules/service_production/revise_improve/revise_improve_binding.dart';
import '../modules/service_production/revise_improve/revise_improve_view.dart';
import '../modules/service_production/practice_expertise/practice_expertise_binding.dart';
import '../modules/service_production/practice_expertise/practice_expertise_view.dart';
import '../modules/service_production/share_care/share_care_binding.dart';
import '../modules/service_production/share_care/share_care_view.dart';

// AIR's Vision Details Imports
import '../modules/airs_vision_details/airs_mission/airs_mission_binding.dart';
import '../modules/airs_vision_details/airs_mission/airs_mission_view.dart';
import '../modules/airs_vision_details/airs_showcase/airs_showcase_binding.dart';
import '../modules/airs_vision_details/airs_showcase/airs_showcase_view.dart';
import '../modules/airs_vision_details/windup_else/windup_else_binding.dart';
import '../modules/airs_vision_details/windup_else/windup_else_view.dart';
import '../modules/airs_vision_details/follow_calendar/follow_calendar_binding.dart';
import '../modules/airs_vision_details/follow_calendar/follow_calendar_view.dart';
import '../modules/airs_vision_details/pick_good_going/pick_good_going_binding.dart';
import '../modules/airs_vision_details/pick_good_going/pick_good_going_view.dart';
import '../modules/airs_vision_details/finally_blessings/finally_blessings_binding.dart';
import '../modules/airs_vision_details/finally_blessings/finally_blessings_view.dart';

// Motivation & Connectivity Imports
import '../modules/motivation_connectivity/motivation/motivation_binding.dart';
import '../modules/motivation_connectivity/motivation/motivation_view.dart';
import '../modules/motivation_connectivity/never_give_up/never_give_up_binding.dart';
import '../modules/motivation_connectivity/never_give_up/never_give_up_view.dart';
import '../modules/motivation_connectivity/innovation_key/innovation_key_binding.dart';
import '../modules/motivation_connectivity/innovation_key/innovation_key_view.dart';
import '../modules/motivation_connectivity/accountable/accountable_binding.dart';
import '../modules/motivation_connectivity/accountable/accountable_view.dart';
import '../modules/motivation_connectivity/live_fullest/live_fullest_binding.dart';
import '../modules/motivation_connectivity/live_fullest/live_fullest_view.dart';
import '../modules/motivation_connectivity/get_connected/get_connected_binding.dart';
import '../modules/motivation_connectivity/get_connected/get_connected_view.dart';
import '../modules/motivation_connectivity/together_unison/together_unison_binding.dart';
import '../modules/motivation_connectivity/together_unison/together_unison_view.dart';
import '../modules/motivation_connectivity/onboard/onboard_binding.dart';
import '../modules/motivation_connectivity/onboard/onboard_view.dart';
import '../modules/motivation_connectivity/greetings/greetings_binding.dart';
import '../modules/motivation_connectivity/greetings/greetings_view.dart';
import '../modules/motivation_connectivity/responsibilities/responsibilities_binding.dart';
import '../modules/motivation_connectivity/responsibilities/responsibilities_view.dart';

// System Core & Auth Imports
import '../modules/login/login_binding.dart';
import '../modules/login/login_view.dart';
import '../modules/utilities_guest/utilities_guest_binding.dart';
import '../modules/utilities_guest/utilities_guest_view.dart';
import '../modules/about_app/about_app_binding.dart';
import '../modules/about_app/about_app_view.dart';
import '../modules/about_org/about_org_binding.dart';
import '../modules/about_org/about_org_view.dart';

class AppRoutes {
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
}

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.LEARN_FUN,
      page: () => const LearnFunView(),
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
      page: () => const QueriesView(),
      binding: QueriesBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.WISDOM,
      page: () => const WisdomView(),
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
      page: () => const ShareExperienceView(),
      binding: ShareExperienceBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.RECORD_POST,
      page: () => const RecordPostView(),
      binding: RecordPostBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.IDENTITIES_EARNINGS,
      page: () => const IdentitiesEarningsView(),
      binding: IdentitiesEarningsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.KNOWLEDGE_CENTER,
      page: () => const KnowledgeCenterView(),
      binding: KnowledgeCenterBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.PRODUCTS_SERVICES,
      page: () => const ProductsServicesView(),
      binding: ProductsServicesBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.QUERY_DISCUSSION,
      page: () => const QueryDiscussionView(),
      binding: QueryDiscussionBinding(),
      transition: Transition.rightToLeft,
    ),

    // Your Profile Specifics Pages
    GetPage(
      name: AppRoutes.EVENTS,
      page: () => const EventsView(),
      binding: EventsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.MANAGEMENTS,
      page: () => const ManagementsView(),
      binding: ManagementsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.MAINTENANCE,
      page: () => const MaintenanceView(),
      binding: MaintenanceBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.CONNECT_COLLABORATE,
      page: () => const ConnectCollaborateView(),
      binding: ConnectCollaborateBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.NOTICES,
      page: () => const NoticesView(),
      binding: NoticesBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.TRACKS_TRACES,
      page: () => const TracksTracesView(),
      binding: TracksTracesBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.YOUR_BUSINESS,
      page: () => const YourBusinessView(),
      binding: YourBusinessBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.REWARDS_CREDITS,
      page: () => const RewardsCreditsView(),
      binding: RewardsCreditsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.APPROVAL_APPEALS,
      page: () => const ApprovalAppealsView(),
      binding: ApprovalAppealsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.NETWORK_APIS,
      page: () => const NetworkApisView(),
      binding: NetworkApisBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.PRIVATE_CONFIDENTIAL,
      page: () => const PrivateConfidentialView(),
      binding: PrivateConfidentialBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.PUBLIC_STUFF,
      page: () => const PublicStuffView(),
      binding: PublicStuffBinding(),
      transition: Transition.rightToLeft,
    ),

    // AIR's Aspects Pages
    GetPage(
      name: AppRoutes.RESUME_TOUR,
      page: () => const ResumeTourView(),
      binding: ResumeTourBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.BE_PART_OF_AIR,
      page: () => const BePartOfAirView(),
      binding: BePartOfAirBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.CONTRIBUTE_TO_AIR,
      page: () => const ContributeToAirView(),
      binding: ContributeToAirBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.TIMELINE_OF_AIR,
      page: () => const TimelineOfAirView(),
      binding: TimelineOfAirBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.NEW_IN_AIR,
      page: () => const NewInAirView(),
      binding: NewInAirBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.CHECKED_ANOMALIES,
      page: () => const CheckedAnomaliesView(),
      binding: CheckedAnomaliesBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.UNCHECKED_ANOMALIES,
      page: () => const UncheckedAnomaliesView(),
      binding: UncheckedAnomaliesBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.LIMITS_0_1,
      page: () => const Limits01View(),
      binding: Limits01Binding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.COMMUNICATION,
      page: () => const CommunicationView(),
      binding: CommunicationBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.IMAGINATION_FEATURES,
      page: () => const ImaginationFeaturesView(),
      binding: ImaginationFeaturesBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.BELIEFS_VALUES,
      page: () => const BeliefsValuesView(),
      binding: BeliefsValuesBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.ENTERTAINMENT,
      page: () => const EntertainmentView(),
      binding: EntertainmentBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.SKILLS_TALENTS,
      page: () => const SkillsTalentsView(),
      binding: SkillsTalentsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.BEING_RECORDED_REWARDED,
      page: () => const BeingRecordedRewardedView(),
      binding: BeingRecordedRewardedBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.TRAINING,
      page: () => const TrainingView(),
      binding: TrainingBinding(),
      transition: Transition.rightToLeft,
    ),

    // Service & Production Pages
    GetPage(
      name: AppRoutes.INPUT_IN_PROCESS,
      page: () => const InputInProcessView(),
      binding: InputInProcessBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.PROCESS,
      page: () => const ProcessView(),
      binding: ProcessBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.OUTCOME_PROCESSED,
      page: () => const OutcomeProcessedView(),
      binding: OutcomeProcessedBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.SYSTEM_ALL_TOGETHER,
      page: () => const SystemAllTogetherView(),
      binding: SystemAllTogetherBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.REVISE_IMPROVE,
      page: () => const ReviseImproveView(),
      binding: ReviseImproveBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.PRACTICE_EXPERTISE,
      page: () => const PracticeExpertiseView(),
      binding: PracticeExpertiseBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.SHARE_CARE,
      page: () => const ShareCareView(),
      binding: ShareCareBinding(),
      transition: Transition.rightToLeft,
    ),

    // AIR's Vision Details Pages
    GetPage(
      name: AppRoutes.AIRS_MISSION,
      page: () => const AirsMissionView(),
      binding: AirsMissionBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.AIRS_SHOWCASE,
      page: () => const AirsShowcaseView(),
      binding: AirsShowcaseBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.WINDUP_ELSE,
      page: () => const WindupElseView(),
      binding: WindupElseBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.FOLLOW_CALENDAR,
      page: () => const FollowCalendarView(),
      binding: FollowCalendarBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.PICK_GOOD_GOING,
      page: () => const PickGoodGoingView(),
      binding: PickGoodGoingBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.FINALLY_BLESSINGS,
      page: () => const FinallyBlessingsView(),
      binding: FinallyBlessingsBinding(),
      transition: Transition.rightToLeft,
    ),

    // Motivation & Connectivity Pages
    GetPage(
      name: AppRoutes.MOTIVATION,
      page: () => const MotivationView(),
      binding: MotivationBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.NEVER_GIVE_UP,
      page: () => const NeverGiveUpView(),
      binding: NeverGiveUpBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.INNOVATION_KEY,
      page: () => const InnovationKeyView(),
      binding: InnovationKeyBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.ACCOUNTABLE,
      page: () => const AccountableView(),
      binding: AccountableBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.LIVE_FULLEST,
      page: () => const LiveFullestView(),
      binding: LiveFullestBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.GET_CONNECTED_SOCIAL,
      page: () => const GetConnectedView(),
      binding: GetConnectedBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.TOGETHER_UNISON,
      page: () => const TogetherUnisonView(),
      binding: TogetherUnisonBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.ONBOARD,
      page: () => const OnboardView(),
      binding: OnboardBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.GREETINGS,
      page: () => const GreetingsView(),
      binding: GreetingsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.RESPONSIBILITIES,
      page: () => const ResponsibilitiesView(),
      binding: ResponsibilitiesBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.LOGOUT,
      page: () => const LoginView(),
      binding: LoginBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.UTILITIES_GUEST,
      page: () => const UtilitiesGuestView(),
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
      page: () => const DigitalizeRecordsView(),
      binding: DigitalizeRecordsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.projects_assessments,
      page: () => const ProjectsAssessmentsView(),
      binding: ProjectsAssessmentsBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}
