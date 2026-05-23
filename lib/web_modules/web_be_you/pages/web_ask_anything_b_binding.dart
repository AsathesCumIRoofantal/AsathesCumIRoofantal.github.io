import 'package:get/get.dart';
import '../pages/web_ask_anything_b_controller.dart';

class WebAskAnythingBBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebAskAnythingBController>(() => WebAskAnythingBController());
  }
}
