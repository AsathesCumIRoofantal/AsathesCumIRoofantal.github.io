import 'package:air_app/modules/splash/spash_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/theme/app_theme.dart';
import 'data/auth_service.dart';
import 'routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AuthService());
  runApp(const AirApp());
}

class AirApp extends StatelessWidget {
  const AirApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Categories in All-Space',
      theme: AppTheme.etherealLight,
      darkTheme: AppTheme.cosmicDark,
      themeMode: ThemeMode.system, // Defaults to system but managed by Settings
      initialRoute: AppRoutes.SPLASH,
      getPages: AppPages.pages,
      initialBinding: SplashBinding(),
      debugShowCheckedModeBanner: false,
    );
  }
}
