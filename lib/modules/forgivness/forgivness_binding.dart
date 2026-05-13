import 'package:get/get.dart';
import 'forgivness_controller.dart';

class ForgivnessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgivnessController>(() => ForgivnessController());
  }
}
