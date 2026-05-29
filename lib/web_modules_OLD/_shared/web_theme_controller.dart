// ============================================================
// web_modules/_shared/web_theme_controller.dart
// Global theme toggle (light / dark / system). Persists in memory
// for the session. Swap _saved/_load to SharedPreferences or GetStorage
// for cross-session persistence.
// ============================================================

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebThemeController extends GetxController {
  static WebThemeController get to {
    if (!Get.isRegistered<WebThemeController>()) {
      Get.put(WebThemeController(), permanent: true);
    }
    return Get.find<WebThemeController>();
  }

  final Rx<ThemeMode> mode = ThemeMode.system.obs;

  bool get isDark =>
      mode.value == ThemeMode.dark ||
      (mode.value == ThemeMode.system &&
          WidgetsBinding.instance.platformDispatcher.platformBrightness ==
              Brightness.dark);

  void setMode(ThemeMode m) {
    mode.value = m;
    Get.changeThemeMode(m);
  }

  void toggle() => setMode(isDark ? ThemeMode.light : ThemeMode.dark);
}

/// Light + Dark ThemeData presets that match the web_modules design tokens.
class WebThemes {
  WebThemes._();

  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFFF8FAFC),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF4F46E5),
      brightness: Brightness.light,
    ),
    fontFamily: 'Roboto',
  );

  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFF0F172A),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF6366F1),
      brightness: Brightness.dark,
    ),
    cardColor: const Color(0xFF1E293B),
    fontFamily: 'Roboto',
  );
}

/// Compact 3-way segmented toggle: light · system · dark
class WebThemeToggle extends StatelessWidget {
  final bool compact;
  const WebThemeToggle({super.key, this.compact = false});

  @override
  Widget build(BuildContext context) {
    final c = WebThemeController.to;
    return Obx(() {
      final m = c.mode.value;
      Widget seg(IconData icon, ThemeMode value, String tip) {
        final active = m == value;
        return Tooltip(
          message: tip,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () => c.setMode(value),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: compact ? 8 : 10,
                vertical: compact ? 6 : 8,
              ),
              decoration: BoxDecoration(
                color: active
                    ? Colors.white.withValues(alpha: 0.25)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: compact ? 16 : 18, color: Colors.white),
            ),
          ),
        );
      }

      return Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            seg(Icons.light_mode_rounded, ThemeMode.light, 'Light'),
            seg(Icons.brightness_auto_rounded, ThemeMode.system, 'System'),
            seg(Icons.dark_mode_rounded, ThemeMode.dark, 'Dark'),
          ],
        ),
      );
    });
  }
}
