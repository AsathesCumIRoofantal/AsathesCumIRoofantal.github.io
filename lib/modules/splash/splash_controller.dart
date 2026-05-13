import 'package:air_app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    // Simulate a delay for the splash screen (e.g., loading resources)
    Future.delayed(const Duration(seconds: 3), () {
      // Navigate to the login screen after the delay
      Get.offNamed(AppRoutes.LOGIN);
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
