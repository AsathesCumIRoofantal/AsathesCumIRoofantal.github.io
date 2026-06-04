import 'package:get/get.dart';
import 'windup_else_controller.dart';

class WindupElseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WindupElseController>(() => WindupElseController());
  }
}
