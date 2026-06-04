import 'package:get/get.dart';
import 'web_liable_controller.dart';

class WebLiableBinding extends Bindings {
  @override
  void dependencies() =>
      Get.lazyPut<WebLiableController>(() => WebLiableController());
}
