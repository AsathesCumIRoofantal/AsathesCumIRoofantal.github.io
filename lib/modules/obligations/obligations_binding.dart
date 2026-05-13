import 'package:get/get.dart';
import 'obligations_controller.dart';

class ObligationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ObligationsController>(() => ObligationsController());
  }
}
