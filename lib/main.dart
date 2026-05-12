import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_pages.dart';
import 'modules/login/login_binding.dart';
import 'core/theme/app_theme.dart';
import 'data/auth_service.dart';

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
      initialRoute: AppRoutes.LOGIN,
      getPages: AppPages.pages,
      initialBinding: LoginBinding(),
      debugShowCheckedModeBanner: false,
    );
  }
}
