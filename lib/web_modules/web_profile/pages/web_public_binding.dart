import 'package:get/get.dart';
import 'web_public_controller.dart';

class WebPublicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebPublicController>(() => WebPublicController());
  }
}
