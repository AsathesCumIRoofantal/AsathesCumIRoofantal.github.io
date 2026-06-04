import 'package:get/get.dart';
import 'world_controller.dart';

class WorldBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WorldController>(() => WorldController());
  }
}
