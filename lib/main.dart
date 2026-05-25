import 'package:air_app/modules/splash/spash_binding.dart';
import 'package:air_app/web_modules/web_home/web_home_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/theme/app_theme.dart';
import 'data/auth_service.dart';
import 'routes/app_pages.dart';

import 'package:flutter_background/flutter_background.dart';
// import 'package:flutter_webrtc_example/src/capture_frame_sample.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await dotenv.load(fileName: ".env");
  Get.put(AuthService());
  runApp(const AirApp());
}

// web rtc
Future<bool> startForegroundService() async {
  final androidConfig = FlutterBackgroundAndroidConfig(
    notificationTitle: 'Title of the notification',
    notificationText: 'Text of the notification',
    notificationImportance: AndroidNotificationImportance.normal,
    notificationIcon: AndroidResource(
      name: 'background_icon',
      defType: 'drawable',
    ), // Default is ic_launcher from folder mipmap
  );
  await FlutterBackground.initialize(androidConfig: androidConfig);
  return FlutterBackground.enableBackgroundExecution();
}

// final androidConfig = FlutterBackgroundAndroidConfig(
//     notificationTitle: "flutter_background example app",
//     notificationText: "Background notification for keeping the example app running in the background",
//     notificationImportance: AndroidNotificationImportance.normal,
//     notificationIcon: AndroidResource(name: 'background_icon', defType: 'drawable'), // Default is ic_launcher from folder mipmap
// );
// bool success = await FlutterBackground.initialize(androidConfig: androidConfig);

class AirApp extends StatelessWidget {
  const AirApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 1024),
      builder: (_, child) {
        return GetMaterialApp(
          title: 'AIR-Space',
          theme: AppTheme.etherealLight,
          darkTheme: AppTheme.cosmicDark,
          themeMode:
              ThemeMode.system, // Defaults to system but managed by Settings
          initialRoute: (kIsWeb) ? WebHomeView.routeName : AppRoutes.SPLASH,
          getPages: AppPages.pages,
          initialBinding: SplashBinding(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
