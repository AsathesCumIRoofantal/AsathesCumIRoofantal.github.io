import 'package:get/get.dart';
import 'web_learn_and_fun_controller.dart';

class WebLearnAndFunBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WebLearnAndFunController());
  }
}
