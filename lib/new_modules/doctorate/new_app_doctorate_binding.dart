import 'package:get/get.dart';
import 'new_app_doctorate_controller.dart';

class NewAppDoctorateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewAppDoctorateController>(() => NewAppDoctorateController());
  }
}
