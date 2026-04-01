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
  ];
}
