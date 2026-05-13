import 'package:get/get.dart';
import 'ground_task_controller.dart';

class GroundTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GroundTaskController>(() => GroundTaskController());
  }
}
