import 'package:flutter/material.dart';

/// Centralised design tokens for the Zoom-parity module.
/// Keeps colours, gradients, spacing, and typography consistent across views.
class ZoomTheme {
  static const bg        = Color(0xFF0B0D12);
  static const surface   = Color(0xFF14171F);
  static const surface2  = Color(0xFF1B2030);
  static const stroke    = Color(0x1FFFFFFF);
  static const text      = Color(0xFFF5F7FA);
  static const textMuted = Color(0xFF98A2B3);
  static const primary   = Color(0xFF4F8CFF);
  static const accent    = Color(0xFF7C5CFF);
  static const success   = Color(0xFF2EE6A6);
  static const warn      = Color(0xFFFFB020);
  static const danger    = Color(0xFFFF5C7A);

  static const heroGradient = LinearGradient(
    begin: Alignment.topLeft, end: Alignment.bottomRight,
    colors: [Color(0xFF4F8CFF), Color(0xFF7C5CFF), Color(0xFFFF5C7A)],
  );

  static BoxDecoration card({double r = 16, Color? color, Border? border}) =>
    BoxDecoration(
      color: color ?? surface,
      borderRadius: BorderRadius.circular(r),
      border: border ?? Border.all(color: stroke),
    );

  static TextStyle h1   = const TextStyle(color: text, fontSize: 32, fontWeight: FontWeight.w700, letterSpacing: -0.5, height: 1.1);
  static TextStyle h2   = const TextStyle(color: text, fontSize: 22, fontWeight: FontWeight.w700);
  static TextStyle h3   = const TextStyle(color: text, fontSize: 17, fontWeight: FontWeight.w600);
  static TextStyle body = const TextStyle(color: text, fontSize: 14, fontWeight: FontWeight.w400, height: 1.4);
  static TextStyle muted= const TextStyle(color: textMuted, fontSize: 13);
  static TextStyle mono = const TextStyle(color: text, fontFamily: 'monospace', fontSize: 14, letterSpacing: 1.2);

  /// Forces this module's own dark palette on every screen inside it,
  /// regardless of what ThemeData the host app around it uses.
  ///
  /// Why this exists: this module is dropped into *someone else's*
  /// GetMaterialApp. Every widget that doesn't set an explicit color reads
  /// from the ambient Theme instead — DropdownButton's selected-item text,
  /// unstyled TextButton/ElevatedButton labels, default AppBar backgrounds,
  /// Slider tracks, Switch colors, and so on. If the host app happens to be
  /// a light theme, several of those ambient defaults land at or near
  /// black — and rendered on this module's near-black backgrounds (`bg`,
  /// `surface`), the result is text and controls that are technically
  /// there but effectively invisible. Wrapping every route in this
  /// ThemeData (see zoom_routes.dart) fixes that at the root instead of
  /// hunting down each individual unstyled widget one at a time.
  static ThemeData get themeData {
    final base = ThemeData(brightness: Brightness.dark, useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: bg,
      canvasColor: surface,
      cardColor: surface,
      dividerColor: stroke,
      colorScheme: base.colorScheme.copyWith(
        brightness: Brightness.dark,
        surface: surface,
        onSurface: text,
        primary: primary,
        onPrimary: Colors.white,
        secondary: accent,
        onSecondary: Colors.white,
        error: danger,
        onError: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: surface,
        foregroundColor: text,
        elevation: 0,
        iconTheme: IconThemeData(color: text),
      ),
      textTheme: base.textTheme.apply(
        bodyColor: text,
        displayColor: text,
      ),
      iconTheme: const IconThemeData(color: text),
      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: const TextStyle(color: text),
        menuStyle: MenuStyle(
          backgroundColor: WidgetStateProperty.all(surface2),
        ),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: surface2,
        textStyle: body,
      ),
      // Note: dialogTheme is intentionally left out — its expected type
      // (DialogTheme vs. DialogThemeData) changed between recent Flutter
      // versions, and every AlertDialog/showDialog call in this module
      // already sets an explicit backgroundColor, so a theme-level default
      // isn't load-bearing here. Same story for bottomSheetTheme.
      bottomSheetTheme: const BottomSheetThemeData(backgroundColor: surface),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((s) =>
          s.contains(WidgetState.selected) ? primary : textMuted),
        trackColor: WidgetStateProperty.resolveWith((s) =>
          s.contains(WidgetState.selected) ? primary.withOpacity(.5) : stroke),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: primary,
        inactiveTrackColor: stroke,
        thumbColor: primary,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: primary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary, foregroundColor: Colors.white),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primary, foregroundColor: Colors.white),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(foregroundColor: primary),
      ),
      listTileTheme: const ListTileThemeData(
        textColor: text, iconColor: text,
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: const TextStyle(color: textMuted),
        hintStyle: const TextStyle(color: textMuted),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: stroke)),
      ),
    );
  }
}

/// Responsive helpers — use these to decide layout (mobile / tablet / desktop).
class Responsive {
  static bool isMobile (BuildContext c) => MediaQuery.of(c).size.width <  720;
  static bool isTablet (BuildContext c) => MediaQuery.of(c).size.width >= 720 && MediaQuery.of(c).size.width < 1100;
  static bool isDesktop(BuildContext c) => MediaQuery.of(c).size.width >= 1100;
}

/// Coloured circular avatar with initials — used wherever a real avatar isn't available.
class InitialsAvatar extends StatelessWidget {
  const InitialsAvatar({super.key, required this.name, required this.colorHex, this.size = 36});
  final String name;
  final int colorHex;
  final double size;
  @override
  Widget build(BuildContext c) {
    final parts = name.trim().split(RegExp(r'\s+'));
    final initials = parts.length == 1
      ? parts.first.substring(0, parts.first.length.clamp(0,2)).toUpperCase()
      : (parts.first[0] + parts.last[0]).toUpperCase();
    return Container(
      width: size, height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft, end: Alignment.bottomRight,
          colors: [Color(colorHex), Color(colorHex).withOpacity(.6)],
        ),
        shape: BoxShape.circle,
        boxShadow: const [BoxShadow(color: Color(0x55000000), blurRadius: 6, offset: Offset(0,2))],
      ),
      alignment: Alignment.center,
      child: Text(initials,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700,
          fontSize: size * .38, letterSpacing: .5)),
    );
  }
}
