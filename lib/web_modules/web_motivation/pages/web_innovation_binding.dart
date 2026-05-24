import 'package:get/get.dart';
import 'web_innovation_controller.dart';

class WebInnovationBinding extends Bindings {
  @override
  void dependencies() =>
      Get.lazyPut<WebInnovationController>(() => WebInnovationController());
}
