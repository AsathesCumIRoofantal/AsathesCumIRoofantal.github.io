// web_modules/web_motivation/web_motivation_binding.dart
import 'package:get/get.dart';
import 'web_motivation_controller.dart';

class WebMotivationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebMotivationController>(() => WebMotivationController());
  }
}
