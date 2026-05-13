import 'package:get/get.dart';
import 'empathy_sympathy_controller.dart';

class EmpathySympathyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmpathySympathyController>(() => EmpathySympathyController());
  }
}
