import 'package:get/get.dart';
import 'web_private_controller.dart';

class WebPrivateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebPrivateController>(() => WebPrivateController());
  }
}
