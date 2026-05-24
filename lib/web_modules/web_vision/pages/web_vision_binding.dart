import 'package:get/get.dart';
import 'web_vision_controller.dart';

class WebVisionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebVisionController>(() => WebVisionController());
  }
}
