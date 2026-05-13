import 'package:get/get.dart';
import 'fingers_are_crossed_controller.dart';

class FingersAreCrossedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FingersAreCrossedController>(() => FingersAreCrossedController());
  }
}
