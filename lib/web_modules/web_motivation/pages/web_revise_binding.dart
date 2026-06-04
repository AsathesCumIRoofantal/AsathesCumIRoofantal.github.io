import 'package:get/get.dart';
import 'web_revise_controller.dart';

class WebReviseBinding extends Bindings {
  @override
  void dependencies() =>
      Get.lazyPut<WebReviseController>(() => WebReviseController());
}
