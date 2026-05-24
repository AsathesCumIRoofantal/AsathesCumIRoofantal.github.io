// web_routes.dart — central GetX route table for all web_modules pages.

import 'package:air_app/web_modules/web_air_space/pages/web_knowledge_center_binding.dart';
import 'package:air_app/web_modules/web_air_space/pages/web_knowledge_center_view.dart';
import 'package:air_app/web_modules/web_air_space/pages/web_products_services_binding.dart';
import 'package:air_app/web_modules/web_air_space/pages/web_products_services_view.dart';
import 'package:air_app/web_modules/web_air_space/pages/web_query_discussion_binding.dart';
import 'package:air_app/web_modules/web_air_space/pages/web_query_discussion_view.dart';
import 'package:air_app/web_modules/web_air_space/pages/web_utilities_guest_binding.dart';
import 'package:air_app/web_modules/web_air_space/pages/web_utilities_guest_view.dart';
import 'package:air_app/web_modules/web_air_space/web_air_space_binding.dart';
import 'package:air_app/web_modules/web_air_space/web_air_space_view.dart';
import 'package:air_app/web_modules/web_aspects/pages/web_anomalies_checked_binding.dart';
import 'package:air_app/web_modules/web_aspects/pages/web_anomalies_checked_view.dart';
import 'package:air_app/web_modules/web_aspects/pages/web_anomalies_open_binding.dart';
import 'package:air_app/web_modules/web_aspects/pages/web_anomalies_open_view.dart';
import 'package:air_app/web_modules/web_aspects/pages/web_be_part_binding.dart';
import 'package:air_app/web_modules/web_aspects/pages/web_be_part_view.dart';
import 'package:air_app/web_modules/web_aspects/pages/web_communication_binding.dart';
import 'package:air_app/web_modules/web_aspects/pages/web_communication_view.dart';
import 'package:air_app/web_modules/web_aspects/pages/web_contribute_binding.dart';
import 'package:air_app/web_modules/web_aspects/pages/web_contribute_view.dart';
import 'package:air_app/web_modules/web_aspects/pages/web_limits_binding.dart';
import 'package:air_app/web_modules/web_aspects/pages/web_limits_view.dart';
import 'package:air_app/web_modules/web_aspects/pages/web_new_in_air_binding.dart';
import 'package:air_app/web_modules/web_aspects/pages/web_new_in_air_view.dart';
import 'package:air_app/web_modules/web_aspects/pages/web_resume_tour_binding.dart';
import 'package:air_app/web_modules/web_aspects/pages/web_resume_tour_view.dart';
import 'package:air_app/web_modules/web_aspects/pages/web_timeline_of_air_binding.dart';
import 'package:air_app/web_modules/web_aspects/pages/web_timeline_of_air_view.dart';
import 'package:air_app/web_modules/web_aspects/web_aspects_binding.dart';
import 'package:air_app/web_modules/web_aspects/web_aspects_view.dart';
import 'package:air_app/web_modules/web_be_you/pages/web_ask_anything_b_binding.dart';
import 'package:air_app/web_modules/web_be_you/pages/web_ask_anything_b_view.dart';
import 'package:air_app/web_modules/web_be_you/pages/web_higher_studies_view.dart';
import 'package:air_app/web_modules/web_be_you/pages/web_identities_earnings_b_binding.dart';
import 'package:air_app/web_modules/web_be_you/pages/web_identities_earnings_b_view.dart';
import 'package:air_app/web_modules/web_be_you/pages/web_identities_earnings_binding.dart';
import 'package:air_app/web_modules/web_be_you/pages/web_identities_earnings_view.dart';
import 'package:air_app/web_modules/web_be_you/pages/web_record_post_binding.dart';
import 'package:air_app/web_modules/web_be_you/pages/web_record_post_view.dart';
import 'package:air_app/web_modules/web_be_you/pages/web_share_experience_binding.dart';
import 'package:air_app/web_modules/web_be_you/pages/web_share_experience_view.dart';
import 'package:air_app/web_modules/web_be_you/web_be_you_binding.dart';
import 'package:air_app/web_modules/web_be_you/web_be_you_view.dart';
import 'package:air_app/web_modules/web_explore/pages/web_doctorate_binding.dart';
import 'package:air_app/web_modules/web_explore/pages/web_doctorate_view.dart';
import 'package:air_app/web_modules/web_explore/pages/web_higher_studies_binding.dart';
import 'package:air_app/web_modules/web_explore/pages/web_learn_and_fun_binding.dart';
import 'package:air_app/web_modules/web_explore/pages/web_learn_and_fun_view.dart';
import 'package:air_app/web_modules/web_explore/pages/web_learn_docs_binding.dart';
import 'package:air_app/web_modules/web_explore/pages/web_learn_docs_view.dart';
import 'package:air_app/web_modules/web_explore/pages/web_life_hacks_binding.dart';
import 'package:air_app/web_modules/web_explore/pages/web_life_hacks_view.dart';
import 'package:air_app/web_modules/web_explore/web_explore_binding.dart';
import 'package:air_app/web_modules/web_explore/web_explore_view.dart';
import 'package:air_app/web_modules/web_home/web_home_binding.dart';
import 'package:air_app/web_modules/web_home/web_home_view.dart';
import 'package:air_app/web_modules/web_motivation/pages/web_get_connected_binding.dart';
import 'package:air_app/web_modules/web_motivation/pages/web_get_connected_view.dart';
import 'package:air_app/web_modules/web_motivation/pages/web_word_motivation_binding.dart';
import 'package:air_app/web_modules/web_motivation/pages/web_word_motivation_view.dart';
import 'package:air_app/web_modules/web_motivation/web_motivation_binding.dart';
import 'package:air_app/web_modules/web_motivation/web_motivation_view.dart';
import 'package:air_app/web_modules/web_profile/pages/web_appeals_binding.dart';
import 'package:air_app/web_modules/web_profile/pages/web_appeals_view.dart';
import 'package:air_app/web_modules/web_profile/pages/web_connect_collaborate_binding.dart';
import 'package:air_app/web_modules/web_profile/pages/web_connect_collaborate_view.dart';
import 'package:air_app/web_modules/web_profile/pages/web_events_binding.dart';
import 'package:air_app/web_modules/web_profile/pages/web_events_view.dart';
import 'package:air_app/web_modules/web_profile/pages/web_maintenance_binding.dart';
import 'package:air_app/web_modules/web_profile/pages/web_maintenance_view.dart';
import 'package:air_app/web_modules/web_profile/pages/web_managements_binding.dart';
import 'package:air_app/web_modules/web_profile/pages/web_managements_view.dart';
import 'package:air_app/web_modules/web_profile/pages/web_network_apis_binding.dart';
import 'package:air_app/web_modules/web_profile/pages/web_network_apis_view.dart';
import 'package:air_app/web_modules/web_profile/pages/web_notices_binding.dart';
import 'package:air_app/web_modules/web_profile/pages/web_notices_view.dart';
import 'package:air_app/web_modules/web_profile/pages/web_private_binding.dart';
import 'package:air_app/web_modules/web_profile/pages/web_private_view.dart';
import 'package:air_app/web_modules/web_profile/pages/web_public_binding.dart';
import 'package:air_app/web_modules/web_profile/pages/web_public_view.dart';
import 'package:air_app/web_modules/web_profile/pages/web_rewards_binding.dart';
import 'package:air_app/web_modules/web_profile/pages/web_rewards_view.dart';
import 'package:air_app/web_modules/web_profile/pages/web_tracks_and_traces_binding.dart';
import 'package:air_app/web_modules/web_profile/pages/web_tracks_and_traces_view.dart';
import 'package:air_app/web_modules/web_profile/pages/web_your_business_binding.dart';
import 'package:air_app/web_modules/web_profile/pages/web_your_business_view.dart';
import 'package:air_app/web_modules/web_profile/web_profile_binding.dart';
import 'package:air_app/web_modules/web_profile/web_profile_view.dart';
import 'package:air_app/web_modules/web_service/pages/web_process_binding.dart';
import 'package:air_app/web_modules/web_service/pages/web_process_view.dart';
import 'package:air_app/web_modules/web_service/web_service_binding.dart';
import 'package:air_app/web_modules/web_service/web_service_view.dart';
import 'package:air_app/web_modules/web_setup/pages/web_category_tree_binding.dart';
import 'package:air_app/web_modules/web_setup/pages/web_category_tree_view.dart';
import 'package:air_app/web_modules/web_setup/pages/web_commerce_showcase_view.dart';
import 'package:air_app/web_modules/web_setup/pages/web_digitalize_hub_showcase_view.dart';
import 'package:air_app/web_modules/web_setup/pages/web_ease_tools_showcase_view.dart';
import 'package:air_app/web_modules/web_setup/pages/web_hospitality_care_showcase_view.dart';
import 'package:air_app/web_modules/web_setup/pages/web_projects_assessments_showcase_view.dart';
import 'package:air_app/web_modules/web_setup/web_setup_binding.dart';
import 'package:air_app/web_modules/web_setup/web_setup_view.dart';
import 'package:air_app/web_modules/web_system/pages/web_about_org_binding.dart';
import 'package:air_app/web_modules/web_system/pages/web_about_org_view.dart';
import 'package:air_app/web_modules/web_system/pages/web_app_setting_binding.dart';
import 'package:air_app/web_modules/web_system/pages/web_app_setting_view.dart';
import 'package:air_app/web_modules/web_system/web_system_binding.dart';
import 'package:air_app/web_modules/web_system/web_system_view.dart';
import 'package:air_app/web_modules/web_vision/pages/web_airs_mission_binding.dart';
import 'package:air_app/web_modules/web_vision/pages/web_airs_mission_view.dart';
import 'package:air_app/web_modules/web_vision/pages/web_airs_show_case_binding.dart';
import 'package:air_app/web_modules/web_vision/pages/web_airs_show_case_view.dart';
import 'package:air_app/web_modules/web_vision/web_vision_binding.dart';
import 'package:air_app/web_modules/web_vision/web_vision_view.dart';
import 'package:air_app/web_modules/web_wisdom/pages/web_ask_anything_binding.dart';
import 'package:air_app/web_modules/web_wisdom/pages/web_ask_anything_view.dart';
import 'package:air_app/web_modules/web_wisdom/pages/web_wisdom_internal_binding.dart';
import 'package:air_app/web_modules/web_wisdom/pages/web_wisdom_internal_view.dart';
import 'package:air_app/web_modules/web_wisdom/web_wisdom_binding.dart';
import 'package:air_app/web_modules/web_wisdom/web_wisdom_view.dart';
import 'package:get/get.dart';

class WebRoutes {
  static const String initial = WebHomeView.routeName;

  static final List<GetPage> pages = [
    GetPage(
      name: WebHomeView.routeName,
      page: () => const WebHomeView(),
      binding: WebHomeBinding(),
    ),

    GetPage(
      name: WebAirSpaceView.routeName,
      page: () => const WebAirSpaceView(),
      binding: WebAirSpaceBinding(),
    ),
    GetPage(
      name: WebKnowledgeCenterView.routeName,
      page: () => const WebKnowledgeCenterView(),
      binding: WebKnowledgeCenterBinding(),
    ),
    GetPage(
      name: WebProductsServicesView.routeName,
      page: () => const WebProductsServicesView(),
      binding: WebProductsServicesBinding(),
    ),
    GetPage(
      name: WebQueryDiscussionView.routeName,
      page: () => const WebQueryDiscussionView(),
      binding: WebQueryDiscussionBinding(),
    ),

    GetPage(
      name: WebAspectsView.routeName,
      page: () => const WebAspectsView(),
      binding: WebAspectsBinding(),
    ),
    GetPage(
      name: WebBePartView.routeName,
      page: () => const WebBePartView(),
      binding: WebBePartBinding(),
    ),
    GetPage(
      name: WebTimelineOfAirView.routeName,
      page: () => const WebTimelineOfAirView(),
      binding: WebTimelineOfAirBinding(),
    ),

    GetPage(
      name: WebBeYouView.routeName,
      page: () => const WebBeYouView(),
      binding: WebBeYouBinding(),
    ),
    GetPage(
      name: WebRecordPostView.routeName,
      page: () => const WebRecordPostView(),
      binding: WebRecordPostBinding(),
    ),
    GetPage(
      name: WebShareExperienceView.routeName,
      page: () => const WebShareExperienceView(),
      binding: WebShareExperienceBinding(),
    ),

    GetPage(
      name: WebExploreView.routeName,
      page: () => const WebExploreView(),
      binding: WebExploreBinding(),
    ),
    GetPage(
      name: WebLearnAndFunView.routeName,
      page: () => const WebLearnAndFunView(),
      binding: WebLearnAndFunBinding(),
    ),
    GetPage(
      name: WebLearnDocsView.routeName,
      page: () => const WebLearnDocsView(),
      binding: WebLearnDocsBinding(),
    ),
    GetPage(
      name: WebLifeHacksView.routeName,
      page: () => const WebLifeHacksView(),
      binding: WebLifeHacksBinding(),
    ),

    GetPage(
      name: WebMotivationView.routeName,
      page: () => const WebMotivationView(),
      binding: WebMotivationBinding(),
    ),
    GetPage(
      name: WebGetConnectedView.routeName,
      page: () => const WebGetConnectedView(),
      binding: WebGetConnectedBinding(),
    ),
    GetPage(
      name: WebWordMotivationView.routeName,
      page: () => const WebWordMotivationView(),
      binding: WebWordMotivationBinding(),
    ),

    GetPage(
      name: WebProfileView.routeName,
      page: () => const WebProfileView(),
      binding: WebProfileBinding(),
    ),
    GetPage(
      name: WebConnectCollaborateView.routeName,
      page: () => const WebConnectCollaborateView(),
      binding: WebConnectCollaborateBinding(),
    ),
    GetPage(
      name: WebEventsView.routeName,
      page: () => const WebEventsView(),
      binding: WebEventsBinding(),
    ),
    GetPage(
      name: WebTracksAndTracesView.routeName,
      page: () => const WebTracksAndTracesView(),
      binding: WebTracksAndTracesBinding(),
    ),

    GetPage(
      name: WebServiceView.routeName,
      page: () => const WebServiceView(),
      binding: WebServiceBinding(),
    ),
    GetPage(
      name: WebProcessView.routeName,
      page: () => const WebProcessView(),
      binding: WebProcessBinding(),
    ),

    GetPage(
      name: WebSetupView.routeName,
      page: () => const WebSetupView(),
      binding: WebSetupBinding(),
    ),
    GetPage(
      name: WebCategoryTreeView.routeName,
      page: () => const WebCategoryTreeView(),
      binding: WebCategoryTreeBinding(),
    ),

    GetPage(
      name: WebSystemView.routeName,
      page: () => const WebSystemView(),
      binding: WebSystemBinding(),
    ),
    GetPage(
      name: WebAboutOrgView.routeName,
      page: () => const WebAboutOrgView(),
      binding: WebAboutOrgBinding(),
    ),
    GetPage(
      name: WebAppSettingView.routeName,
      page: () => const WebAppSettingView(),
      binding: WebAppSettingBinding(),
    ),

    GetPage(
      name: WebVisionView.routeName,
      page: () => const WebVisionView(),
      binding: WebVisionBinding(),
    ),
    GetPage(
      name: WebAirsMissionView.routeName,
      page: () => const WebAirsMissionView(),
      binding: WebAirsMissionBinding(),
    ),
    GetPage(
      name: WebAirsShowCaseView.routeName,
      page: () => const WebAirsShowCaseView(),
      binding: WebAirsShowCaseBinding(),
    ),

    GetPage(
      name: WebWisdomView.routeName,
      page: () => const WebWisdomView(),
      binding: WebWisdomBinding(),
    ),
    GetPage(
      name: WebAskAnythingView.routeName,
      page: () => const WebAskAnythingView(),
      binding: WebAskAnythingBinding(),
    ),
    GetPage(
      name: WebWisdomInternalView.routeName,
      page: () => const WebWisdomInternalView(),
      binding: WebWisdomInternalBinding(),
    ),

    GetPage(
      name: WebCommerceShowcaseView.routeName,
      page: () => const WebCommerceShowcaseView(),
    ),
    GetPage(
      name: WebDigitalizeHubShowcaseView.routeName,
      page: () => const WebDigitalizeHubShowcaseView(),
    ),
    GetPage(
      name: WebEaseToolsShowcaseView.routeName,
      page: () => const WebEaseToolsShowcaseView(),
    ),
    GetPage(
      name: WebHospitalityCareShowcaseView.routeName,
      page: () => const WebHospitalityCareShowcaseView(),
    ),
    GetPage(
      name: WebProjectsAssessmentsShowcaseView.routeName,
      page: () => const WebProjectsAssessmentsShowcaseView(),
    ),
    GetPage(
      name: WebIdentitiesEarningsView.routeName,
      page: () => const WebIdentitiesEarningsView(),
      binding: WebIdentitiesEarningsBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WebHigherStudiesView.routeName,
      page: () => const WebHigherStudiesView(),
      binding: WebHigherStudiesBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WebDoctorateView.routeName,
      page: () => const WebDoctorateView(),
      binding: WebDoctorateBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WebAskAnythingBView.routeName,
      page: () => const WebAskAnythingBView(),
      binding: WebAskAnythingBBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WebWisdomView.routeName,
      page: () => const WebWisdomView(),
      binding: WebWisdomBinding(),
      transition: Transition.rightToLeft, // Section roots use rightToLeft
    ),
    GetPage(
      name: WebIdentitiesEarningsBView.routeName,
      page: () => const WebIdentitiesEarningsBView(),
      binding: WebIdentitiesEarningsBBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WebUtilitiesGuestView.routeName,
      page: () => const WebUtilitiesGuestView(),
      binding: WebUtilitiesGuestBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WebManagementsView.routeName,
      page: () => const WebManagementsView(),
      binding: WebManagementsBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WebMaintenanceView.routeName,
      page: () => const WebMaintenanceView(),
      binding: WebMaintenanceBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WebNoticesView.routeName,
      page: () => const WebNoticesView(),
      binding: WebNoticesBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WebYourBusinessView.routeName,
      page: () => const WebYourBusinessView(),
      binding: WebYourBusinessBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WebRewardsView.routeName,
      page: () => const WebRewardsView(),
      binding: WebRewardsBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WebAppealsView.routeName,
      page: () => const WebAppealsView(),
      binding: WebAppealsBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WebNetworkApisView.routeName,
      page: () => const WebNetworkApisView(),
      binding: WebNetworkApisBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WebPrivateView.routeName,
      page: () => const WebPrivateView(),
      binding: WebPrivateBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WebPublicView.routeName,
      page: () => const WebPublicView(),
      binding: WebPublicBinding(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: WebResumeTourView.routeName,
      page: () => const WebResumeTourView(),
      binding: WebResumeTourBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WebContributeView.routeName,
      page: () => const WebContributeView(),
      binding: WebContributeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WebNewInAirView.routeName,
      page: () => const WebNewInAirView(),
      binding: WebNewInAirBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WebAnomaliesCheckedView.routeName,
      page: () => const WebAnomaliesCheckedView(),
      binding: WebAnomaliesCheckedBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WebAnomaliesOpenView.routeName,
      page: () => const WebAnomaliesOpenView(),
      binding: WebAnomaliesOpenBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WebLimitsView.routeName,
      page: () => const WebLimitsView(),
      binding: WebLimitsBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WebCommunicationView.routeName,
      page: () => const WebCommunicationView(),
      binding: WebCommunicationBinding(),
      transition: Transition.fadeIn,
    ),
  ];
}
