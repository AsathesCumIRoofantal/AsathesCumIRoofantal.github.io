import 'package:get/get.dart';
import 'web_imagination_controller.dart';

class WebImaginationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebImaginationController>(() => WebImaginationController());
  }
}
