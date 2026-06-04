// web_modules/web_wisdom/web_wisdom_binding.dart
import 'package:get/get.dart';
import 'web_wisdom_controller.dart';

class WebWisdomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebWisdomController>(() => WebWisdomController());
  }
}
