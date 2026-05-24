import 'package:get/get.dart';
import 'web_system_all_controller.dart';

class WebSystemAllBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebSystemAllController>(() => WebSystemAllController());
  }
}
