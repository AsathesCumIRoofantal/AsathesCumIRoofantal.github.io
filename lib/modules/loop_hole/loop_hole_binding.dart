import 'package:get/get.dart';
import 'loop_hole_controller.dart';
class LoopHoleBinding extends Bindings {
  @override void dependencies() => Get.lazyPut(() => LoopHoleController());
}
