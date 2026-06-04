import 'package:get/get.dart';
import 'code_conduct_controller.dart';

class CodeConductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CodeConductController>(() => CodeConductController());
  }
}
