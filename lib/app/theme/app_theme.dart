// ============================================================
//  AIR App – App Theme  (Dark + Light)
// ============================================================
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static const _primary = Color(0xFF4F6EF7);
  static const _secondary = Color(0xFF9B59F5);
  static const _tertiary = Color(0xFF22D3EE);
  static const _error = Color(0xFFEF4444);
  static const _surfaceDark = Color(0xFF13151F);
  static const _bgDark = Color(0xFF0A0D16);
  static const _surfaceLight = Color(0xFFF8F9FF);
  static const _bgLight = Color(0xFFFFFFFF);

  static TextTheme _textTheme(Color base) => GoogleFonts.interTextTheme(
    TextTheme(
      displayLarge: TextStyle(
        color: base,
        fontWeight: FontWeight.w800,
        letterSpacing: -1.5,
      ),
      headlineLarge: TextStyle(color: base, fontWeight: FontWeight.w700),
      titleLarge: TextStyle(color: base, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(color: base),
      bodyMedium: TextStyle(color: base),
      labelLarge: TextStyle(color: base, fontWeight: FontWeight.w600),
    ),
  );

  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primary,
      brightness: Brightness.dark,
      primary: _primary,
      secondary: _secondary,
      tertiary: _tertiary,
      error: _error,
      surface: _surfaceDark,
    ).copyWith(surface: _surfaceDark),
    scaffoldBackgroundColor: _bgDark,
    textTheme: _textTheme(Colors.white),
    appBarTheme: AppBarTheme(
      backgroundColor: _bgDark,
      foregroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    ),
    cardTheme: CardThemeData(
      color: _surfaceDark,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.white.withOpacity(0.06)),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: _surfaceDark,
      indicatorColor: _primary.withOpacity(0.2),
      surfaceTintColor: Colors.transparent,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    ),
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: _surfaceDark,
      indicatorColor: _primary.withOpacity(0.2),
      selectedIconTheme: const IconThemeData(color: _primary),
      unselectedIconTheme: IconThemeData(color: Colors.white.withOpacity(0.5)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white.withOpacity(0.06),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: _primary, width: 1.5),
      ),
      hintStyle: TextStyle(color: Colors.white.withOpacity(0.35), fontSize: 14),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: _primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _primary,
        side: const BorderSide(color: _primary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: Colors.white.withOpacity(0.06),
      selectedColor: _primary.withOpacity(0.25),
      labelStyle: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.8)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.white.withOpacity(0.1)),
      ),
    ),
    dividerTheme: DividerThemeData(color: Colors.white.withOpacity(0.08)),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected) ? _primary : Colors.grey,
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected)
            ? _primary.withOpacity(0.4)
            : Colors.white12,
      ),
    ),
  );

  static final ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primary,
      brightness: Brightness.light,
      primary: _primary,
      secondary: _secondary,
      tertiary: _tertiary,
      error: _error,
    ),
    scaffoldBackgroundColor: _bgLight,
    textTheme: _textTheme(const Color(0xFF0D0F18)),
    appBarTheme: AppBarTheme(
      backgroundColor: _bgLight,
      foregroundColor: const Color(0xFF0D0F18),
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF0D0F18),
      ),
    ),
    cardTheme: CardThemeData(
      color: _surfaceLight,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.black.withOpacity(0.06)),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: _surfaceLight,
      indicatorColor: _primary.withOpacity(0.15),
      surfaceTintColor: Colors.transparent,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.black.withOpacity(0.04),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: _primary, width: 1.5),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: _primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        textStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700),
      ),
    ),
    chipTheme: ChipThemeData(
      selectedColor: _primary.withOpacity(0.15),
      labelStyle: const TextStyle(fontSize: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.black.withOpacity(0.1)),
      ),
    ),
    dividerTheme: DividerThemeData(color: Colors.black.withOpacity(0.08)),
  );
}
