// ============================================================
//  AIR App – Auth Middleware  (route guard)
// ============================================================
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/auth_service.dart';
import '../../routes/app_pages.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  /// Routes that do NOT require authentication.
  static const _public = [
    AppRoutes.SPLASH,
    AppRoutes.LOGIN,
    AppRoutes.SIGNUP,
  ];

  @override
  RouteSettings? redirect(String? route) {
    // Allow public routes through without any check.
    if (route != null && _public.any((p) => route.startsWith(p))) {
      return null;
    }

    // Guard: user must be fully authenticated.
    final auth = AuthService.to;
    if (auth.isLoggedIn.value &&
        auth.currentUser.value != null &&
        Supabase.instance.client.auth.currentUser != null) {
      return null; // ✅ Allowed
    }

    // Not authenticated → force logout & redirect to login.
    auth.logout();
    return const RouteSettings(name: '/login');
  }
}
