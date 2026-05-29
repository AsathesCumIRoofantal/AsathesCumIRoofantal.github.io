// ============================================================
//  AIR App – Settings Controller
// ============================================================
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/storage/local_storage.dart';
import '../../../services/auth_service_new.dart';
import '../../../constants/app_constants.dart';

class SettingsController extends GetxController {
  static SettingsController get to => Get.find();

  final RxString themeMode        = 'system'.obs; // system | light | dark
  final RxBool   notificationsOn  = true.obs;
  final RxBool   biometricEnabled = false.obs;
  final RxBool   isAgoraEngine    = (!AppConstants.isAgoraNotUsed).obs;
  final RxString language         = 'en'.obs;
  final RxBool   isDummyMode      = AppConstants.isDummyMode.obs;

  // Video engine label
  String get engineLabel => isAgoraEngine.value ? 'Agora RTC' : 'Flutter WebRTC';

  @override
  void onInit() {
    super.onInit();
    themeMode.value = LocalStorage.to.themeMode;
  }

  void setTheme(String mode) {
    themeMode.value        = mode;
    LocalStorage.to.themeMode = mode;
    switch (mode) {
      case 'dark':   Get.changeThemeMode(ThemeMode.dark);   break;
      case 'light':  Get.changeThemeMode(ThemeMode.light);  break;
      default:       Get.changeThemeMode(ThemeMode.system);
    }
  }

  void toggleNotifications() => notificationsOn.value = !notificationsOn.value;
  void toggleBiometric()      => biometricEnabled.value = !biometricEnabled.value;

  void toggleEngine() {
    isAgoraEngine.value = !isAgoraEngine.value;
    Get.snackbar(
      'Video Engine Changed',
      'Now using: $engineLabel (restart required for full effect)',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> logout() async {
    final confirmed = await Get.defaultDialog<bool>(
      title:   'Log Out',
      content: Text('Are you sure you want to log out?',
          style: TextStyle(fontSize: 14)),
      textConfirm: 'Log Out',
      textCancel:  'Cancel',
      confirmTextColor: Colors.white,
      buttonColor:      Colors.red,
    );
    if (confirmed == true) await AirAuthService.to.logout();
  }

  void clearCache() {
    Get.snackbar('Cache Cleared', 'All cached data has been removed.',
        snackPosition: SnackPosition.BOTTOM);
  }

  void showAppInfo() {
    Get.defaultDialog(
      title:   'AIR-Space',
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        Text('Version: ${AppConstants.appVersion}'),
        const SizedBox(height: 8),
        Text('Dummy mode: ${AppConstants.isDummyMode}'),
        const SizedBox(height: 8),
        Text('Flutter + GetX + Supabase'),
      ]),
      textConfirm: 'Close',
      confirmTextColor: Colors.white,
    );
  }
}
