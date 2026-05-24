import 'package:get/get.dart';
import 'web_blessings_controller.dart';

class WebBlessingsBinding extends Bindings {
  @override
  void dependencies() =>
      Get.lazyPut<WebBlessingsController>(() => WebBlessingsController());
}
