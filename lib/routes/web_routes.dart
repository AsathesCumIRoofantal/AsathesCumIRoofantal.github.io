// ============================================================
// web_modules/web_routes.dart
// Register every web page as a GetX route.
// Add WebRoutes.pages to your AppPages.pages list.
// ============================================================

import 'package:air_app/web_modules/web_wisdom/pages/web_wisdom_internal_binding.dart';
import 'package:air_app/web_modules/web_wisdom/pages/web_wisdom_internal_view.dart';
import 'package:air_app/web_modules/web_wisdom/web_wisdom_view.dart';
import 'package:get/get.dart';

import '../web_modules/web_home/web_home_binding.dart';
import '../web_modules/web_home/web_home_view.dart';
import '../web_modules/web_explore/web_explore_binding.dart';
import '../web_modules/web_explore/web_explore_view.dart';
import '../web_modules/web_explore/pages/web_learn_and_fun_binding.dart';
import '../web_modules/web_explore/pages/web_learn_and_fun_view.dart';
import '../web_modules/web_wisdom/web_wisdom_binding.dart';
import '../web_modules/web_be_you/web_be_you_binding.dart';
import '../web_modules/web_be_you/web_be_you_view.dart';
import '../web_modules/web_be_you/pages/web_share_experience_binding.dart';
import '../web_modules/web_be_you/pages/web_share_experience_view.dart';
import '../web_modules/web_air_space/web_air_space_binding.dart';
import '../web_modules/web_air_space/web_air_space_view.dart';
import '../web_modules/web_air_space/pages/web_knowledge_center_binding.dart';
import '../web_modules/web_air_space/pages/web_knowledge_center_view.dart';
import '../web_modules/web_profile/web_profile_binding.dart';
import '../web_modules/web_profile/web_profile_view.dart';
import '../web_modules/web_profile/pages/web_tracks_and_traces_binding.dart';
import '../web_modules/web_profile/pages/web_tracks_and_traces_view.dart';
import '../web_modules/web_aspects/web_aspects_binding.dart';
import '../web_modules/web_aspects/web_aspects_view.dart';
import '../web_modules/web_aspects/pages/web_timeline_of_air_binding.dart';
import '../web_modules/web_aspects/pages/web_timeline_of_air_view.dart';
import '../web_modules/web_service/web_service_binding.dart';
import '../web_modules/web_service/web_service_view.dart';
import '../web_modules/web_service/pages/web_process_binding.dart';
import '../web_modules/web_service/pages/web_process_view.dart';
import '../web_modules/web_vision/web_vision_binding.dart';
import '../web_modules/web_vision/web_vision_view.dart';
import '../web_modules/web_vision/pages/web_airs_show_case_binding.dart';
import '../web_modules/web_vision/pages/web_airs_show_case_view.dart';
import '../web_modules/web_motivation/web_motivation_binding.dart';
import '../web_modules/web_motivation/web_motivation_view.dart';
import '../web_modules/web_motivation/pages/web_get_connected_binding.dart';
import '../web_modules/web_motivation/pages/web_get_connected_view.dart';
import '../web_modules/web_setup/web_setup_binding.dart';
import '../web_modules/web_setup/web_setup_view.dart';
import '../web_modules/web_setup/pages/web_category_tree_binding.dart';
import '../web_modules/web_setup/pages/web_category_tree_view.dart';
import '../web_modules/web_system/web_system_binding.dart';
import '../web_modules/web_system/web_system_view.dart';
import '../web_modules/web_system/pages/web_app_setting_binding.dart';
import '../web_modules/web_system/pages/web_app_setting_view.dart';
import '../web_modules/web_setup/pages/web_category_tree_showcase_view.dart';
import '../web_modules/web_setup/pages/web_code_conduct_showcase_view.dart';
import '../web_modules/web_setup/pages/web_commerce_showcase_view.dart';
import '../web_modules/web_setup/pages/web_digitalize_hub_showcase_view.dart';
import '../web_modules/web_setup/pages/web_ease_tools_showcase_view.dart';
import '../web_modules/web_setup/pages/web_hospitality_care_showcase_view.dart';
import '../web_modules/web_setup/pages/web_projects_assessments_showcase_view.dart';
import '../web_modules/web_setup/pages/web_safety_showcase_view.dart';
import '../web_modules/web_setup/pages/web_script_strategy_showcase_view.dart';
import '../web_modules/web_setup/pages/web_social_showcase_view.dart';
import '../web_modules/web_setup/pages/web_utility_facilities_showcase_view.dart';
import '../web_modules/web_setup/pages/web_vocabulary_showcase_view.dart';

class WebRoutes {
  WebRoutes._();

  static const home = WebHomeView.routeName;
  static const explore = WebExploreView.routeName;
  static const explore_learn_and_fun = WebLearnAndFunView.routeName;
  static const wisdom = WebWisdomView.routeName;
  static const wisdom_internal = WebWisdomInternalView.routeName;
  static const be_you = WebBeYouView.routeName;
  static const be_you_share = WebShareExperienceView.routeName;
  static const air_space = WebAirSpaceView.routeName;
  static const air_space_knowledge = WebKnowledgeCenterView.routeName;
  static const profile = WebProfileView.routeName;
  static const profile_tracks = WebTracksAndTracesView.routeName;
  static const aspects = WebAspectsView.routeName;
  static const aspects_timeline = WebTimelineOfAirView.routeName;
  static const service = WebServiceView.routeName;
  static const service_process = WebProcessView.routeName;
  static const vision = WebVisionView.routeName;
  static const vision_show_case = WebAirsShowCaseView.routeName;
  static const motivation = WebMotivationView.routeName;
  static const motivation_connected = WebGetConnectedView.routeName;
  static const setup = WebSetupView.routeName;
  static const setup_category = WebCategoryTreeView.routeName;
  static const setup_digitalizeHub = ProductRecordDigitalize.routeName;

  static const setup_projectsAssessments = ProjectsAssessments.routeName;

  static const setup_categoryTree = CategoryTree.routeName;

  static const setup_easeTools = EaseTools.routeName;

  static const setup_vocabulary = Vocabulary.routeName;

  static const setup_codeConduct = CodeConduct.routeName;

  static const setup_scriptStrategy = ScriptStrategy.routeName;

  static const setup_safety = Safety.routeName;

  static const setup_hospitalityCare = HospitalityCare.routeName;

  static const setup_utilityFacilities = UtilityFacilities.routeName;

  static const setup_commerce = Commerce.routeName;

  static const setup_social = Social.routeName;

  static const system = WebSystemView.routeName;
  static const system_setting = WebAppSettingView.routeName;

  static final List<GetPage> pages = <GetPage>[
    GetPage(
      name: WebHomeView.routeName,
      page: () => const WebHomeView(),
      binding: WebHomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WebExploreView.routeName,
      page: () => const WebExploreView(),
      binding: WebExploreBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: WebLearnAndFunView.routeName,
      page: () => const WebLearnAndFunView(),
      binding: WebLearnAndFunBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WebWisdomView.routeName,
      page: () => const WebWisdomView(),
      binding: WebWisdomBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: WebWisdomInternalView.routeName,
      page: () => const WebWisdomInternalView(),
      binding: WebWisdomInternalBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WebBeYouView.routeName,
      page: () => const WebBeYouView(),
      binding: WebBeYouBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: WebShareExperienceView.routeName,
      page: () => const WebShareExperienceView(),
      binding: WebShareExperienceBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WebAirSpaceView.routeName,
      page: () => const WebAirSpaceView(),
      binding: WebAirSpaceBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: WebKnowledgeCenterView.routeName,
      page: () => const WebKnowledgeCenterView(),
      binding: WebKnowledgeCenterBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WebProfileView.routeName,
      page: () => const WebProfileView(),
      binding: WebProfileBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: WebTracksAndTracesView.routeName,
      page: () => const WebTracksAndTracesView(),
      binding: WebTracksAndTracesBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WebAspectsView.routeName,
      page: () => const WebAspectsView(),
      binding: WebAspectsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: WebTimelineOfAirView.routeName,
      page: () => const WebTimelineOfAirView(),
      binding: WebTimelineOfAirBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WebServiceView.routeName,
      page: () => const WebServiceView(),
      binding: WebServiceBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: WebProcessView.routeName,
      page: () => const WebProcessView(),
      binding: WebProcessBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WebVisionView.routeName,
      page: () => const WebVisionView(),
      binding: WebVisionBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: WebAirsShowCaseView.routeName,
      page: () => const WebAirsShowCaseView(),
      binding: WebAirsShowCaseBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WebMotivationView.routeName,
      page: () => const WebMotivationView(),
      binding: WebMotivationBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: WebGetConnectedView.routeName,
      page: () => const WebGetConnectedView(),
      binding: WebGetConnectedBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WebSetupView.routeName,
      page: () => const WebSetupView(),
      binding: WebSetupBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: WebCategoryTreeView.routeName,
      page: () => const WebCategoryTreeView(),
      binding: WebCategoryTreeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: WebSystemView.routeName,
      page: () => const WebSystemView(),
      binding: WebSystemBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: WebAppSettingView.routeName,
      page: () => const WebAppSettingView(),
      binding: WebAppSettingBinding(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: ProductRecordDigitalize.routeName,
      page: () => const ProductRecordDigitalize(),
    ),

    GetPage(
      name: ProjectsAssessments.routeName,
      page: () => const ProjectsAssessments(),
    ),

    GetPage(name: CategoryTree.routeName, page: () => const CategoryTree()),

    GetPage(name: EaseTools.routeName, page: () => const EaseTools()),

    GetPage(name: Vocabulary.routeName, page: () => const Vocabulary()),

    GetPage(name: CodeConduct.routeName, page: () => const CodeConduct()),

    GetPage(name: ScriptStrategy.routeName, page: () => const ScriptStrategy()),

    GetPage(name: Safety.routeName, page: () => const Safety()),

    GetPage(
      name: HospitalityCare.routeName,
      page: () => const HospitalityCare(),
    ),

    GetPage(
      name: UtilityFacilities.routeName,
      page: () => const UtilityFacilities(),
    ),

    GetPage(name: Commerce.routeName, page: () => const Commerce()),

    GetPage(name: Social.routeName, page: () => const Social()),
  ];
}
