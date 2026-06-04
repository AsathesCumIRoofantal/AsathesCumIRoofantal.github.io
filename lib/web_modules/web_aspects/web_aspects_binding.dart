// web_modules/web_aspects/web_aspects_binding.dart
import 'package:get/get.dart';
import 'web_aspects_controller.dart';

class WebAspectsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebAspectsController>(() => WebAspectsController());
  }
}
