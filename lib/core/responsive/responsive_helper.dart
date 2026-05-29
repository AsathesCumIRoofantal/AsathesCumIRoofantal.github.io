// ============================================================
//  AIR App – Responsive Helper
//  Breakpoints: mobile <600, tablet 600-1199, desktop ≥1200
// ============================================================
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Responsive {
  Responsive._();

  // ── Breakpoints ──────────────────────────────────────────
  static const double _mobileMax  = 599;
  static const double _tabletMax  = 1199;

  static bool isMobile(BuildContext ctx)  => MediaQuery.sizeOf(ctx).width <= _mobileMax;
  static bool isTablet(BuildContext ctx)  => MediaQuery.sizeOf(ctx).width > _mobileMax &&
      MediaQuery.sizeOf(ctx).width <= _tabletMax;
  static bool isDesktop(BuildContext ctx) => MediaQuery.sizeOf(ctx).width > _tabletMax;

  // ── Value Selector ───────────────────────────────────────
  static T value<T>(BuildContext ctx, {
    required T mobile,
    T? tablet,
    required T desktop,
  }) {
    if (isDesktop(ctx)) return desktop;
    if (isTablet(ctx))  return tablet ?? desktop;
    return mobile;
  }

  // ── Common Layout Values ─────────────────────────────────
  static double sidebarWidth(BuildContext ctx) =>
      isDesktop(ctx) ? 280 : isTablet(ctx) ? 240 : 0;

  static EdgeInsets pagePadding(BuildContext ctx) => EdgeInsets.symmetric(
    horizontal: value(ctx, mobile: 16.w, tablet: 24.w, desktop: 32.w),
    vertical:   value(ctx, mobile: 12.h, tablet: 16.h, desktop: 20.h),
  );

  static double gridCrossAxisCount(BuildContext ctx, {
    int mobile = 1, int tablet = 2, int desktop = 3,
  }) => value(ctx, mobile: mobile.toDouble(), tablet: tablet.toDouble(), desktop: desktop.toDouble());

  static double avatarRadius(BuildContext ctx) =>
      value(ctx, mobile: 20.r, tablet: 22.r, desktop: 24.r);

  static double fontTitle(BuildContext ctx) =>
      value(ctx, mobile: 18.sp, tablet: 20.sp, desktop: 22.sp);

  static double fontBody(BuildContext ctx) =>
      value(ctx, mobile: 14.sp, tablet: 15.sp, desktop: 16.sp);

  static double fontCaption(BuildContext ctx) =>
      value(ctx, mobile: 11.sp, tablet: 12.sp, desktop: 13.sp);

  // ── Navigation type ──────────────────────────────────────
  /// Returns true if the app should show bottom-nav (mobile/tablet portrait)
  static bool useBottomNav(BuildContext ctx) =>
      isMobile(ctx) || (isTablet(ctx) && MediaQuery.orientationOf(ctx) == Orientation.portrait);
}

// ── Responsive Builder Widget ────────────────────────────
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext ctx) {
    if (Responsive.isDesktop(ctx)) return desktop;
    if (Responsive.isTablet(ctx))  return tablet ?? desktop;
    return mobile;
  }
}
