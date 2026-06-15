import 'dart:async';

import 'package:air_app/app/routes/air_routes.dart';
import 'package:air_app/modules/splash/spash_binding.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

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
  runZonedGuarded(
    () async {
      await SentryFlutter.init(
        (options) {
          //TODO: ADD Latest Version
          // options.release = "air-web@1.0.23";
          options.dsn =
              "https://github.com/getsentry/sentry-wizard/releases/download/v4.0.1/sentry-wizard-win-x64.exe";
        },
        appRunner: () async {
          // 🚀 FIX: Forces standard clean paths instead of fallback hash strategy
          usePathUrlStrategy();
          WidgetsBinding widgetsBinding =
              WidgetsFlutterBinding.ensureInitialized();
          FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
          Get.put(AuthService());

          // // ── Environment variables ───────────────────────────────────
          // try {
          //   await dotenv.load(fileName: '.env');
          // } catch (_) {
          //   debugPrint('⚠️  .env not found – running in dummy mode');
          // }

          // ── Lock orientation on phones only (allow all on tablet/web) ──
          await SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight,
          ]);

          // ── Status bar style ────────────────────────────────────────
          SystemChrome.setSystemUIOverlayStyle(
            const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.dark,
            ),
          );

          // await dotenv.load(fileName: ".env");
          GoogleFonts.config.allowRuntimeFetching = false;

          FlutterError.onError = (FlutterErrorDetails details) {
            FlutterError.presentError(details);
            debugPrint(details.exceptionAsString());
            debugPrint(details.stack.toString());
          };
          return runApp(AirApp());
        },
      );
    },
    (error, stack) {
      debugPrint('ERROR: $error');
      debugPrint(stack.toString());
    },
  );
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
      useInheritedMediaQuery: true,
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
          unknownRoute: GetPage(
            name: '/404',
            page: () => const _NotFoundPage(),
          ),
        );
      },
    );
  }
}

// ── 404 Page ──────────────────────────────────────────────
class _NotFoundPage extends StatelessWidget {
  const _NotFoundPage();
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.search_off_rounded, size: 72, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'Page not found',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () => Get.offAllNamed(AppRoutes.LOGIN),
            child: const Text('Go to Login'),
          ),
        ],
      ),
    ),
  );
}
