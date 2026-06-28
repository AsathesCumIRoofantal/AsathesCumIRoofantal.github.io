import 'dart:convert';

import 'package:air_app/app/models/geo_location_logged_model.dart';
import 'package:air_app/app/models/system_platform_logged_model.dart';
import 'package:air_app/data/auth_repository.dart';
import 'package:air_app/routes/app_pages.dart';
import 'package:air_app/web_modules/web_home/web_home_view.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:universal_platform/universal_platform.dart';

import '../../data/auth_service.dart';

class LoginController extends GetxController {
  final isLoading = false.obs;
  final isObscure = true.obs;

  final userIdController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  Rx<String?> selectedRole = (null).obs; // Default role
  final roles = [
    'Alifiyas',
    'Mazeasta',
    'Roofantal',
    'Asathes',
    'Diplomat',
    'Developer',
    'Devotee',
    'God',
    'Meritorious',
    'Perfect',
    'Media',
    'Celebrity',
    'Advocate',
    'Judge',
    'Jobist',
    'Bussnessman',
    'Teacher',
    'Student',
  ];
  final roleDescriptions = <String, String>{
    'Alifiyas': 'The New Beginner',
    'Mazeasta': 'The Expert',
    'Roofantal': 'The Peace Agent',
    'Asathes': 'The Field Agent',
    'Diplomat': 'Politics and Diplomacy',
    'Developer': 'Developer and Researcher',
    'Devotee': 'The Devoted One',
    'God': 'The Supreme Being',
    'Meritorious': 'The Meritorious',
    'Perfect': 'The Perfect One',
    'Media': 'The Media Specialist',
    'Celebrity': 'The atrist',
    'Advocate': 'The Lawyer',
    'Judge': 'The Judge',
    'Jobist': 'The Jobist',
    'Bussnessman': 'The Bussnessman',
    'Teacher': 'The Teacher',
    'Student': 'The Student',
  };

  void toggleObscure() => isObscure.value = !isObscure.value;

  void setRole(String role) => selectedRole.value = role;

  @override
  void onInit() {
    super.onInit();

    // 🚀 DISMISS HERE: Removes the splash screen the moment this controller initializes
    FlutterNativeSplash.remove();
  }

  void login() async {
    if (
    // userIdController.text.isEmpty ||
    passwordController.text.isEmpty || !emailController.text.isEmail) {
      Get.snackbar(
        'Error',
        'Please enter password and valid email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withValues(alpha: 0.1),
        colorText: Colors.redAccent,
      );
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;

    // TODO: await Sentry.configureScope((scope) {
    //   scope.setUser(SentryUser(id: user.id, email: user.email));
    // });
    // await Sentry.configureScope((scope) {
    //   scope.setTag('module', 'meeting');
    //   scope.setTag('meetingId', meetingId);
    // });
    // await Sentry.configureScope((scope) {
    //   scope.setTag('platform', kIsWeb ? 'web' : 'mobile');
    //   scope.setTag('app', 'air-space');
    // });
    // try {
    //   await joinMeeting();
    // } catch (e, s) {
    //   await Sentry.captureException(
    //     e,
    //     stackTrace: s,
    //     withScope: (scope) {
    //       scope.setTag('module', 'meeting');
    //       scope.setExtra('roomId', roomId);
    //     },
    //   );
    // }
    Get.put(() => AuthService());
    final loginResponseBool = await AuthService.to.loginWithEmailPassword(
      email: emailController.text,
      password: passwordController.text,
    );

    if (!loginResponseBool) {
      Get.snackbar(
        'Error',
        'Invalid email or password',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withValues(alpha: 0.6),
        colorText: Colors.white,
      );
      return;
    }
    //TODO Later final logInBool = await AuthService.to.getLoggedIn(
    //   password: passwordController.text,
    //   email: emailController.text,
    // );

    // if (!logInBool) {
    //   Get.snackbar(
    //     'Error',
    //     'Invalid  password or email',
    //     snackPosition: SnackPosition.BOTTOM,
    //     backgroundColor: Colors.redAccent.withValues(alpha: 0.6),
    //     colorText: Colors.white,
    //   );
    //   return;
    // }
    AuthRepository repository = AuthRepository(Supabase.instance.client);
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

    final userResponse = await repository.createLoginLogsWithFunctionHitByMap({
      "user_id": Supabase.instance.client.auth.currentUser!.id,
      "system_platform_logged": system.toJson(),
      "is_from_android": isAndroid ? 1 : 0,
      "is_from_ios": isIOS ? 1 : 0,
      "is_from_web": isWeb ? 1 : 0,
      "ip_address": system.ipAddress,

      // "app_version": system.appVersion, //TODO
      "geo_location_logged": geoLocation.toJson(),
      "is_login": 1,
    });
    if (!userResponse) {
      Get.snackbar(
        'Error',
        'We are unable to process your login-logs request. Please try again later.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withValues(alpha: 0.6),
        colorText: Colors.white,
      );
      return;
    }

    if (kIsWeb) {
      Get.offAllNamed(WebHomeView.routeName);
    } else {
      Get.offAllNamed(AppRoutes.HOME_APP_OLD);
    }
    Get.snackbar(
      'Success',
      'Welcome back!',
      snackPosition: SnackPosition.BOTTOM,
    );
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

  // @override
  // void onClose() {
  //   userIdController.dispose();
  //   passwordController.dispose();
  //   super.onClose();
  // }
}
