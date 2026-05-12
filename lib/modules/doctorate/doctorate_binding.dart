import 'package:get/get.dart';
import 'doctorate_controller.dart';
class DoctorateBinding extends Bindings {
  @override void dependencies() => Get.lazyPut(() => DoctorateController());
}
