import 'package:get/get.dart';
import 'web_be_part_controller.dart';
class WebBePartBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<WebBePartController>(() => WebBePartController());
}
