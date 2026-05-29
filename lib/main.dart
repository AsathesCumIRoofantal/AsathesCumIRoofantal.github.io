// ============================================================
//  AIR App – main.dart  (Entry Point)
//  WhatsApp + Zoom + AnyDesk in Flutter 3.41.x
// ============================================================
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../app/bindings/app_binding.dart';
import '../app/constants/app_constants.dart';
import '../app/modules/dashboard/views/dashboard_view.dart';
import '../app/routes/air_pages.dart';
import '../app/routes/air_routes.dart';
import '../app/theme/app_theme.dart';
import '../core/storage/local_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

  // ── Environment variables ───────────────────────────────────
  try {
    await dotenv.load(fileName: '.env');
  } catch (_) {
    debugPrint('⚠️  .env not found – running in dummy mode');
  }

  // ── Core services (must init before app runs) ───────────────
  final localStorage = await LocalStorage().init();
  Get.put(localStorage, permanent: true);

  // ── Determine initial route ─────────────────────────────────
  final initialRoute = localStorage.hasSession
      ? AirRoutes.dashboard
      : AirRoutes.login;

  runApp(AirApp(initialRoute: initialRoute));
}

class AirApp extends StatelessWidget {
  final String initialRoute;
  const AirApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // Design frame = 390 × 844 (iPhone 14 baseline)
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (ctx, child) {
        return GetMaterialApp(
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,

          // ── Themes ───────────────────────────────────────
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: _resolveThemeMode(LocalStorage.to.themeMode),

          // ── Root binding ─────────────────────────────────
          initialBinding: AppBinding(),

          // ── Routing ──────────────────────────────────────
          initialRoute: initialRoute,
          getPages: AirPages.pages,
          unknownRoute: GetPage(
            name: '/404',
            page: () => const _NotFoundPage(),
          ),

          // ── Global transition ─────────────────────────────
          defaultTransition: Transition.fadeIn,
          transitionDuration: const Duration(milliseconds: 280),

          // ── Locale ───────────────────────────────────────
          locale: const Locale('en', 'US'),
          fallbackLocale: const Locale('en', 'US'),

          // ── Login fallback (replace with real auth screen) ─
          home: initialRoute == AirRoutes.dashboard
              ? const DashboardView()
              : const _LoginPlaceholder(),
        );
      },
    );
  }

  ThemeMode _resolveThemeMode(String mode) {
    switch (mode) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }
}

// ── Login Placeholder ─────────────────────────────────────
// Replace this with your real auth page from lib/modules/auth/
class _LoginPlaceholder extends StatelessWidget {
  const _LoginPlaceholder();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.primary,
                      theme.colorScheme.secondary,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.primary.withOpacity(0.4),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.air_rounded,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'AIR-Space',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Chat • Meet • Remote Support',
                style: TextStyle(fontSize: 14, color: theme.hintColor),
              ),
              const SizedBox(height: 48),

              // Quick-demo login button
              FilledButton.icon(
                icon: const Icon(Icons.play_arrow_rounded),
                label: const Text('Demo Login (Dummy Mode)'),
                onPressed: () => Get.offAll(() => const DashboardView()),
                style: FilledButton.styleFrom(
                  minimumSize: const Size(double.infinity, 52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'OTP code: 123456 (dummy mode)',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
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
            onPressed: () => Get.offAllNamed(AirRoutes.dashboard),
            child: const Text('Go Home'),
          ),
        ],
      ),
    ),
  );
}
