// ============================================================
// web_modules/web_routes.dart
// Register all Web* pages as GetX routes
// Usage: add WebRoutes.pages to AppPages.pages list
// ============================================================

import 'package:get/get.dart';

import 'web_about_page.dart';
import 'web_air_vision_page.dart';
import 'web_community_page.dart';
import 'web_explore_page.dart';
import 'web_home_page.dart';
import 'web_profile_page.dart';
import 'web_setup_page.dart';
import 'web_wisdom_page.dart';

/// All Web route names — prefix convention: /web-
class WebRoutes {
  WebRoutes._();

  static const home = WebHomePage.routeName;         // /web-home
  static const wisdom = WebWisdomPage.routeName;     // /web-wisdom
  static const explore = WebExplorePage.routeName;   // /web-explore
  static const airVision = WebAirVisionPage.routeName; // /web-air-vision
  static const profile = WebProfilePage.routeName;   // /web-profile
  static const community = WebCommunityPage.routeName; // /web-community
  static const about = WebAboutPage.routeName;       // /web-about
  static const setup = WebSetupPage.routeName;       // /web-setup

  /// Add this list to AppPages.pages (or append in main.dart)
  static final pages = <GetPage>[
    GetPage(
      name: home,
      page: () => const WebHomePage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: wisdom,
      page: () => const WebWisdomPage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: explore,
      page: () => const WebExplorePage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: airVision,
      page: () => const WebAirVisionPage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: profile,
      page: () => const WebProfilePage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: community,
      page: () => const WebCommunityPage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: about,
      page: () => const WebAboutPage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: setup,
      page: () => const WebSetupPage(),
      transition: Transition.rightToLeft,
    ),
  ];
}
