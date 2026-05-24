import 'package:get/get.dart';
import 'web_goodgoing_controller.dart';

class WebGoodGoingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebGoodGoingController>(() => WebGoodGoingController());
  }
}
