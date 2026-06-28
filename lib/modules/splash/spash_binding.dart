import 'package:air_app/core/storage/secure_storage.dart';
import 'package:air_app/data/auth_service.dart';
import 'package:air_app/modules/splash/splash_controller.dart';
import 'package:get/get.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<SplashController>(() => SplashController());
    // Get.lazyPut(() => SecureStorage());
    // ── Core services (must init before app runs) ───────────────

    Get.put(() => SplashController(), permanent: true);
    Get.put(() => SecureStorage(), permanent: true);
    Get.put(() => AuthService(), permanent: true);
  }
}
