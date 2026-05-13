import 'package:get/get.dart';
import 'joining_services_controller.dart';

class JoiningServicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JoiningServicesController>(() => JoiningServicesController());
  }
}
