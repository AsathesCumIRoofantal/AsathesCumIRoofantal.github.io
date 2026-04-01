import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData cosmicDark = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.deepPurple,
    scaffoldBackgroundColor: const Color(0xFF0D0B1A), // Deep Cosmic Blue/Black
    cardColor: const Color(0xFF1E193B), // Frosty neon backdrop
    dividerColor: Colors.white24,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0D0B1A),
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    tabBarTheme: const TabBarThemeData(
      indicatorColor: Colors.purpleAccent,
      labelColor: Colors.purpleAccent,
      unselectedLabelColor: Colors.white54,
    ),
    colorScheme: const ColorScheme.dark(
      surface: Color(0xFF1E193B),
      primary: Colors.purpleAccent,
      secondary: Colors.tealAccent,
      tertiary: Colors.cyanAccent,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
    ),
    useMaterial3: true,
    fontFamily: 'Roboto',
  );

  static final ThemeData etherealLight = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.deepPurple,
    scaffoldBackgroundColor: const Color(0xFFF4F6F9), // Ethereal Cloud White
    cardColor: Colors.white, // Clean white panels
    dividerColor: Colors.black12,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFF4F6F9),
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Color(0xFF2C255F),
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
      ),
      iconTheme: IconThemeData(color: Color(0xFF2C255F)),
    ),
    tabBarTheme: const TabBarThemeData(
      indicatorColor: Colors.deepPurple,
      labelColor: Colors.deepPurple,
      unselectedLabelColor: Colors.black38,
    ),
    colorScheme: const ColorScheme.light(
      surface: Colors.white,
      primary: Colors.deepPurple,
      secondary: Colors.teal,
      tertiary: Colors.black87,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF1B1B1B)),
      bodyMedium: TextStyle(color: Color(0xFF4A4A4A)),
    ),
    useMaterial3: true,
    fontFamily: 'Roboto',
  );
}
