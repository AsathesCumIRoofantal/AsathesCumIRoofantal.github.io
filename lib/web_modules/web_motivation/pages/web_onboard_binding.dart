import 'package:get/get.dart';
import 'web_onboard_controller.dart';

class WebOnboardBinding extends Bindings {
  @override
  void dependencies() =>
      Get.lazyPut<WebOnboardController>(() => WebOnboardController());
}
