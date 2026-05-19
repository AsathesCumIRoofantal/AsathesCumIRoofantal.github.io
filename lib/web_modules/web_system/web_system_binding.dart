// web_modules/web_system/web_system_binding.dart
import 'package:get/get.dart';
import 'web_system_controller.dart';

class WebSystemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebSystemController>(() => WebSystemController());
  }
}
