import 'package:get/get.dart';
import 'web_limits_controller.dart';

class WebLimitsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebLimitsController>(() => WebLimitsController());
  }
}
