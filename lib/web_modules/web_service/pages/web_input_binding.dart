import 'package:get/get.dart';
import 'web_input_controller.dart';

class WebInputBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebInputController>(() => WebInputController());
  }
}
