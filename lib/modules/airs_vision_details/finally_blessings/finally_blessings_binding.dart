import 'package:get/get.dart';
import 'finally_blessings_controller.dart';

class FinallyBlessingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FinallyBlessingsController>(() => FinallyBlessingsController());
  }
}
