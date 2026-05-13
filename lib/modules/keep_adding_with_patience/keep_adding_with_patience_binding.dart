import 'package:get/get.dart';
import 'keep_adding_controller.dart';

class KeepAddingWithPatienceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KeepAddingController>(() => KeepAddingController());
  }
}
