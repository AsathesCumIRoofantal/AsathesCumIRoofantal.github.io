import 'package:get/get.dart';
import 'motivation_controller.dart';

class MotivationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MotivationController>(() => MotivationController());
  }
}
