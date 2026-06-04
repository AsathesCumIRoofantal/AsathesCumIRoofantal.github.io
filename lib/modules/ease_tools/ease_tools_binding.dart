import 'package:get/get.dart';
import 'ease_tools_controller.dart';

class EaseToolsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EaseToolsController>(() => EaseToolsController());
  }
}
