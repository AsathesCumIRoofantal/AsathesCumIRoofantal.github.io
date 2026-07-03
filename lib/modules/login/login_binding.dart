import 'package:air_app/core/storage/secure_storage.dart';
import 'package:air_app/data/auth_service.dart';
import 'package:air_app/modules/splash/splash_controller.dart';
import 'package:get/get.dart';
import 'login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController(), permanent: true);
    Get.put<AuthService>(AuthService(), permanent: true);
    Get.put<SplashController>(SplashController(), permanent: true);
    Get.put<SecureStorage>(SecureStorage(), permanent: true);
  }
}
