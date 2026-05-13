import 'package:get/get.dart';
import 'keep_adding_with_patiencecontroller.dart';

class KeepAddingWithPatienceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KeepAddingWithPatienceController>(
      () => KeepAddingWithPatienceController(),
    );
  }
}
