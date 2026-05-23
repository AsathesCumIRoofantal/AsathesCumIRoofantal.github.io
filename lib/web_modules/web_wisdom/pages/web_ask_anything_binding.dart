import 'package:get/get.dart';
import 'web_ask_anything_controller.dart';
class WebAskAnythingBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<WebAskAnythingController>(() => WebAskAnythingController());
}
