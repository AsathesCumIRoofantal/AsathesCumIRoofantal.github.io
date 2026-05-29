import 'package:air_app/new_modules/splash/spash_binding.dart';
import 'package:air_app/web_modules/web_home/web_home_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/theme/app_theme.dart';
import 'data/auth_service.dart';
import 'routes/app_pages.dart';

import 'package:flutter_background/flutter_background.dart';
// import 'package:flutter_webrtc_example/src/capture_frame_sample.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:web/web.dart' as web;
import 'dart:js_interop';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  // 🚀 FIX: Forces standard clean paths instead of fallback hash strategy
  usePathUrlStrategy();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // await dotenv.load(fileName: ".env");
  GoogleFonts.config.allowRuntimeFetching = false;
  Get.put(AuthService());
  runApp(AirApp());
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

class AirApp extends StatefulWidget {
  AirApp({super.key});

  @override
  State<AirApp> createState() => _AirAppState();
}

class _AirAppState extends State<AirApp> {
  @override
  void initState() {
    super.initState();
    _listenForUpdates();
  }

  void _listenForUpdates() {
    web.window.addEventListener(
      'flutter_version_update',
      ((web.Event event) {
            _showUpdateNotification();
          }).toJS
          as web.EventListener, // Explicitly cast the JS-interop object
    );
  }

  void _showUpdateNotification() {
    // GetX snackbar runs independently of context, bypassing layout size errors completely
    Get.snackbar(
      'Update Available',
      'A new version of the app has been deployed.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.black87,
      colorText: Colors.white,
      duration: const Duration(minutes: 5), // Keeps it open
      isDismissible: true,
      mainButton: TextButton(
        onPressed: () {
          web.window.location.reload(); // Hard reload browser
        },
        child: const Text(
          'Refresh',
          style: TextStyle(
            color: Colors.lightBlueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1920, 1080), // Desktop Web Standard Base Layout
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'AIR-Space',
          theme: AppTheme.etherealLight,
          darkTheme: AppTheme.cosmicDark,
          themeMode:
              ThemeMode.system, // Defaults to system but managed by Settings
          initialRoute: kIsWeb ? AppRoutes.LOGIN : AppRoutes.SPLASH,
          getPages: AppPages.pages,
          initialBinding: SplashBinding(),
          debugShowCheckedModeBanner: false,
          routingCallback: (routing) {
            if (routing != null) {
              FlutterNativeSplash.remove();
            }
          },
        );
      },
    );
  }
}
