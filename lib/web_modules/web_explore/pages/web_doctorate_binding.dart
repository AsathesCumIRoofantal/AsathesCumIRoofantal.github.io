import 'package:get/get.dart';
import 'web_doctorate_controller.dart';

class WebDoctorateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebDoctorateController>(() => WebDoctorateController());
  }
}
