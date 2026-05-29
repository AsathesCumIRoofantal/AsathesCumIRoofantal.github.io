// ============================================================
//  AIR App – Shared Animation Utilities
// ============================================================
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get_navigation/src/routes/custom_transition.dart';

class AppAnimations {
  AppAnimations._();

  // ── Durations ────────────────────────────────────────────
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration vslow = Duration(milliseconds: 800);

  // ── Curves ───────────────────────────────────────────────
  static const Curve easeOut = Curves.easeOut;
  static const Curve easeIn = Curves.easeIn;
  static const Curve spring = Curves.elasticOut;
  static const Curve smooth = Curves.easeInOutCubic;
}

// ── Extension shortcuts ───────────────────────────────────
extension AnimateWidgetX on Widget {
  Widget fadeSlideIn({int delay = 0, Offset begin = const Offset(0, 0.08)}) =>
      animate(delay: Duration(milliseconds: delay))
          .fadeIn(duration: AppAnimations.normal, curve: AppAnimations.smooth)
          .slideY(
            begin: begin.dy,
            duration: AppAnimations.normal,
            curve: AppAnimations.smooth,
          );

  Widget scaleIn({int delay = 0}) =>
      animate(delay: Duration(milliseconds: delay))
          .scale(
            begin: const Offset(0.92, 0.92),
            duration: AppAnimations.normal,
            curve: AppAnimations.smooth,
          )
          .fadeIn(duration: AppAnimations.fast);

  Widget shimmerLoading() => animate(
    onPlay: (c) => c.repeat(),
  ).shimmer(duration: const Duration(seconds: 2), color: Colors.white24);
}

// ── Page transition factory ──────────────────────────────
class AppPageTransition extends CustomTransition {
  @override
  Widget buildTransition(
    BuildContext context,
    Curve? curve,
    Alignment? alignment,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.04, 0),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
        child: child,
      ),
    );
  }
}
