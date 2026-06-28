import 'package:air_app/data/auth_service.dart';
import 'package:get/get.dart';
import 'login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.put(() => AuthService());
  }
}
