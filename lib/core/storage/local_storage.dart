// ============================================================
//  AIR App – Local Storage  (SharedPreferences wrapper)
// ============================================================
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app/constants/app_constants.dart';

class LocalStorage extends GetxService {
  static LocalStorage get to => Get.find();

  late SharedPreferences _prefs;

  Future<LocalStorage> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  // ── Theme ────────────────────────────────────────────────
  String get themeMode =>
      _prefs.getString(AppConstants.keyThemeMode) ?? 'system';
  set themeMode(String v) => _prefs.setString(AppConstants.keyThemeMode, v);

  // ── Auth tokens ──────────────────────────────────────────
  String? get accessToken => _prefs.getString(AppConstants.keyAccessToken);
  String? get refreshToken => _prefs.getString(AppConstants.keyRefreshToken);
  String? get userId => _prefs.getString(AppConstants.keyUserId);
  int? get userRole => _prefs.getInt(AppConstants.keyUserRole);

  set accessToken(String? v) => v == null
      ? _prefs.remove(AppConstants.keyAccessToken)
      : _prefs.setString(AppConstants.keyAccessToken, v);

  set refreshToken(String? v) => v == null
      ? _prefs.remove(AppConstants.keyRefreshToken)
      : _prefs.setString(AppConstants.keyRefreshToken, v);

  set userId(String? v) => v == null
      ? _prefs.remove(AppConstants.keyUserId)
      : _prefs.setString(AppConstants.keyUserId, v);

  set userRole(int? v) => v == null
      ? _prefs.remove(AppConstants.keyUserRole)
      : _prefs.setInt(AppConstants.keyUserRole, v);

  // ── Onboarding ───────────────────────────────────────────
  bool get isOnboarded => _prefs.getBool(AppConstants.keyOnboarded) ?? false;
  set isOnboarded(bool v) => _prefs.setBool(AppConstants.keyOnboarded, v);

  // ── Last route (for deep-link restore) ───────────────────
  String? get lastRoute => _prefs.getString(AppConstants.keyLastRoute);
  set lastRoute(String? v) => v == null
      ? _prefs.remove(AppConstants.keyLastRoute)
      : _prefs.setString(AppConstants.keyLastRoute, v);

  // ── Session check ────────────────────────────────────────
  bool get hasSession => accessToken != null && userId != null;

  // ── Full clear (logout) ──────────────────────────────────
  Future<void> clearSession() async {
    await _prefs.remove(AppConstants.keyAccessToken);
    await _prefs.remove(AppConstants.keyRefreshToken);
    await _prefs.remove(AppConstants.keyUserId);
    await _prefs.remove(AppConstants.keyUserRole);
  }

  // ── Generic helpers ──────────────────────────────────────
  String? getString(String k) => _prefs.getString(k);
  Future<bool> setBool(String k, bool v) => _prefs.setBool(k, v);
  bool getBool(String k, {bool d = false}) => _prefs.getBool(k) ?? d;
  Future<bool> remove(String k) => _prefs.remove(k);
}
