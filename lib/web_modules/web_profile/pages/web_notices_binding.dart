import 'package:get/get.dart';
import 'web_notices_controller.dart';

class WebNoticesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebNoticesController>(() => WebNoticesController());
  }
}
