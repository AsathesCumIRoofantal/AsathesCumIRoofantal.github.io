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
