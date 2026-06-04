import 'package:air_app/core/storage/local_storage.dart';
import 'package:air_app/routes/app_pages.dart';
import 'package:get/get.dart';

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
    Get.offNamed(AppRoutes.LOGIN);
  }
}
