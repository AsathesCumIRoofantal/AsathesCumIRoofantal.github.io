import 'package:get/get.dart';
import 'contribute_to_air_controller.dart';

class ContributeToAirBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContributeToAirController>(() => ContributeToAirController());
  }
}
