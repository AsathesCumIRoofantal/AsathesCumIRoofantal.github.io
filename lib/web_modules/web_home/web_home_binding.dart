// web_modules/web_home/web_home_binding.dart
import 'package:get/get.dart';
import 'web_home_controller.dart';

class WebHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebHomeController>(() => WebHomeController());
  }
}
