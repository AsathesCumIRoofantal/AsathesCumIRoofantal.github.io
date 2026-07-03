import 'dart:convert';

import 'package:air_app/app/models/geo_location_logged_model.dart';
import 'package:air_app/app/models/system_platform_logged_model.dart';
import 'package:air_app/core/storage/local_storage.dart';
import 'package:air_app/core/storage/secure_storage.dart';
import 'package:air_app/data/auth_repository.dart';
import 'package:air_app/data/auth_service.dart';
import 'package:air_app/routes/app_pages.dart';
import 'package:air_app/web_modules/web_home/web_home_view.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart'
    hide LocalStorage, AuthState;
import 'package:universal_platform/universal_platform.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getStartData();
  }

  getStartData() async {
    // Simulate a delay for the splash screen (e.g., loading resources)
    await Future.delayed(const Duration(seconds: 3));

    // throw StateError('This is test exception');//For Tracing

    // Navigate to the login screen after the delay
    final localStorage = await LocalStorage().init();
    Get.put(localStorage, permanent: true);
    final authService = AuthService.to;
    if (authService.isLoggedIn &&
        authService.currentUser.value != null &&
        Supabase.instance.client.auth.currentUser != null) {
      Get.offAllNamed(WebHomeView.routeName);
    } else {
      Get.offAllNamed(AppRoutes.LOGIN);
    }
  }

  Future<void> getLogOutWorkDone() async {
    final localStorage = Get.find<LocalStorage>();
    final secureStorage = Get.find<SecureStorage>();

    final deviceInfo = DeviceInfoPlugin();
    final packageInfo = await PackageInfo.fromPlatform();

    String device = "";
    String model = "";
    String os = "";
    String osVersion = "";
    String manufacturer = "";
    String brand = "";
    String cpu = "";

    if (kIsWeb) {
      final info = await deviceInfo.webBrowserInfo;

      device = "Web";
      model = info.browserName.name;
      os = info.platform ?? "";
      osVersion = "";
      manufacturer = "";
      brand = "";
      cpu = "";
    } else if (UniversalPlatform.isAndroid) {
      final info = await deviceInfo.androidInfo;

      device = "Phone";
      model = info.model;
      os = "Android";
      osVersion = info.version.release;
      manufacturer = info.manufacturer;
      brand = info.brand;
      cpu = info.supportedAbis.join(", ");
    } else if (UniversalPlatform.isIOS) {
      final info = await deviceInfo.iosInfo;

      device = "iPhone";
      model = info.utsname.machine;
      os = "iOS";
      osVersion = info.systemVersion;
      manufacturer = "Apple";
      brand = "Apple";
      cpu = "";
    }

    bool isAndroid = UniversalPlatform.isAndroid;
    bool isIOS = UniversalPlatform.isIOS;
    bool isWeb = kIsWeb;

    SystemPlatformLoggedModel system = SystemPlatformLoggedModel(
      device: device,
      model: model,
      os: os,
      osVersion: osVersion,
      manufacturer: manufacturer,
      brand: brand,
      cpuArchitecture: cpu,
      appVersion: packageInfo.version,
      buildNumber: packageInfo.buildNumber,
      ipAddress: await _getPublicIP(),
    );

    final GeoLocationLoggedModel? geoLocation =
        await GeoLocationLoggedModel.loadLocation();
    if (geoLocation == null) {
      Get.snackbar(
        'Warning',
        'We are unable to get your current location. Please enable location services and try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withValues(alpha: 0.6),
        colorText: Colors.white,
      );
      return;
    }
    AuthRepository repository = AuthRepository(Supabase.instance.client);
    final userResponse = await repository.createLoginLogsWithFunctionHitByMap({
      "user_id": Supabase.instance.client.auth.currentUser!.id,
      "system_platform_logged": system.toJson(),
      "is_from_android": isAndroid ? 1 : 0,
      "is_from_ios": isIOS ? 1 : 0,
      "is_from_web": isWeb ? 1 : 0,
      "ip_address": system.ipAddress,

      // "app_version": system.appVersion,
      "geo_location_logged": geoLocation.toJson(),
      "is_login": 0,
      "isLogin": false,
    });
    await Supabase.instance.client.auth.signOut();
    final authService = AuthService.to;
    await authService.logout();
    await localStorage.clearSession();
    await secureStorage.clearAll();
    Get.offAllNamed(AppRoutes.LOGIN);
  }

  Future<String> _getPublicIP() async {
    try {
      final res = await http.get(
        Uri.parse("https://api.ipify.org?format=json"),
      );

      if (res.statusCode == 200) {
        return jsonDecode(res.body)["ip"];
      }
    } catch (_) {}

    return "";
  }
}
