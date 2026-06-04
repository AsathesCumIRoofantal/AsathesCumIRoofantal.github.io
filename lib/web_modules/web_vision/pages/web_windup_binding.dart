import 'package:get/get.dart';
import 'web_windup_controller.dart';

class WebWindupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebWindupController>(() => WebWindupController());
  }
}
