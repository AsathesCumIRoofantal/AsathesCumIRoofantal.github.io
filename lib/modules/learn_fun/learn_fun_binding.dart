import 'package:get/get.dart';
import 'learn_fun_controller.dart';

class LearnFunBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LearnFunController());
  }
}
