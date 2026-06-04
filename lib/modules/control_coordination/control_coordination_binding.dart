import 'package:get/get.dart';
import 'control_coordination_controller.dart';

class ControlCoordinationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ControlCoordinationController>(() => ControlCoordinationController());
  }
}
