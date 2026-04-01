import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_pages.dart';
import 'modules/home/home_binding.dart';
import 'core/theme/app_theme.dart';

void main() {
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
      initialRoute: AppRoutes.HOME,
      getPages: AppPages.pages,
      initialBinding: HomeBinding(),
      debugShowCheckedModeBanner: false,
    );
  }
}
