// ============================================================
//  AIR App – Permission Handler
// ============================================================
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

enum AppPermission { camera, microphone, storage, notification, location }

class PermissionService extends GetxService {
  static PermissionService get to => Get.find();

  // ── Request single permission ─────────────────────────
  Future<bool> request(AppPermission perm) async {
    if (kIsWeb) return true; // Browser handles natively
    final status = await _permMap(perm).request();
    return status.isGranted;
  }

  // ── Request multiple ─────────────────────────────────
  Future<Map<AppPermission, bool>> requestMultiple(List<AppPermission> perms) async {
    if (kIsWeb) return {for (final p in perms) p: true};
    final Map<AppPermission, bool> results = {};
    for (final perm in perms) {
      results[perm] = await request(perm);
    }
    return results;
  }

  // ── Check status ──────────────────────────────────────
  Future<bool> isGranted(AppPermission perm) async {
    if (kIsWeb) return true;
    return (await _permMap(perm).status).isGranted;
  }

  // ── Open settings ────────────────────────────────────
  Future<void> openSettings() => ph.openAppSettings();

  // ── Permissions for meeting (Agora/WebRTC) ───────────
  Future<bool> requestMeetingPermissions() async {
    final result = await requestMultiple([AppPermission.camera, AppPermission.microphone]);
    return result.values.every((v) => v);
  }

  // ── Internal map ─────────────────────────────────────
  ph.Permission _permMap(AppPermission perm) {
    switch (perm) {
      case AppPermission.camera:       return ph.Permission.camera;
      case AppPermission.microphone:   return ph.Permission.microphone;
      case AppPermission.storage:      return ph.Permission.storage;
      case AppPermission.notification: return ph.Permission.notification;
      case AppPermission.location:     return ph.Permission.location;
    }
  }
}
