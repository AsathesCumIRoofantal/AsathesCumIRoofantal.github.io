// ============================================================
//  AIR App – GetX Page Registry
// ============================================================
import 'package:get/get.dart';
import '../middleware/auth_middleware.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/profile/views/profile_view.dart';
import 'air_routes.dart';

// Auth pages are handled inline via existing modules folder
// (do not import from lib/modules – see README)

class AirPages {
  AirPages._();

  static final pages = <GetPage>[
    GetPage(
      name:        AirRoutes.dashboard,
      page:        () => const DashboardView(),
      middlewares: [AuthMiddleware()],
      transition:  Transition.fadeIn,
    ),
    GetPage(
      name:   AirRoutes.settings,
      page:   () => const SettingsView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name:   AirRoutes.profile,
      page:   () => const ProfileView(),
      transition: Transition.rightToLeft,
    ),
  ];
}
