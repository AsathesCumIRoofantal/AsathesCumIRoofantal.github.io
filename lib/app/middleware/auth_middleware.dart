// ============================================================
//  AIR App – Auth Middleware  (route guard)
// ============================================================
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/storage/local_storage.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    final hasSession = LocalStorage.to.hasSession;

    // Protected routes
    const protected = ['/dashboard', '/profile', '/settings'];
    // Auth routes
    const authOnly  = ['/login', '/signup', '/otp'];

    if (protected.any((p) => route?.startsWith(p) == true) && !hasSession) {
      return const RouteSettings(name: '/login');
    }

    if (authOnly.contains(route) && hasSession) {
      return const RouteSettings(name: '/dashboard');
    }

    return null;
  }
}
