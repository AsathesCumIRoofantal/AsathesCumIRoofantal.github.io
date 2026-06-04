import 'package:get/get.dart';
import 'responsibilities_controller.dart';

class ResponsibilitiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResponsibilitiesController>(() => ResponsibilitiesController());
  }
}
