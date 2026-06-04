import 'package:get/get.dart';
import 'utility_facilities_controller.dart';

class UtilityFacilitiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UtilityFacilitiesController>(() => UtilityFacilitiesController());
  }
}
