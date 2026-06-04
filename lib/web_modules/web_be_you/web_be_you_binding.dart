// web_modules/web_be_you/web_be_you_binding.dart
import 'package:get/get.dart';
import 'web_be_you_controller.dart';

class WebBeYouBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebBeYouController>(() => WebBeYouController());
  }
}
