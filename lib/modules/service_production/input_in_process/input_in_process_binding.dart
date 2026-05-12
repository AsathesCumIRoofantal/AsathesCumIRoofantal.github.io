import 'package:get/get.dart';
import 'input_in_process_controller.dart';

class InputInProcessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InputInProcessController>(() => InputInProcessController());
  }
}
