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

class AppRoutes {
  static const HOME = '/';
  static const SETTINGS = '/settings';
  static const LEARN_FUN = '/learn-fun';
  static const LEARN_DOCS = '/learn-docs';
  static const QUERIES = '/queries';
  static const WISDOM = '/wisdom';
  static const AIR_VISION = '/air-vision';
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
  ];
}
