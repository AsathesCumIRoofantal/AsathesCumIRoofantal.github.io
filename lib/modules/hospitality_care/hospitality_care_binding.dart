import 'package:get/get.dart';
import 'hospitality_care_controller.dart';

class HospitalityCareBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HospitalityCareController>(() => HospitalityCareController());
  }
}
