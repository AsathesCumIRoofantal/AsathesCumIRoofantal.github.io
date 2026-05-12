import 'package:get/get.dart';
import 'system_all_together_controller.dart';

class SystemAllTogetherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SystemAllTogetherController>(() => SystemAllTogetherController());
  }
}
