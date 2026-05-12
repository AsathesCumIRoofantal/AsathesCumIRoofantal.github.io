import 'package:get/get.dart';
import 'airs_mission_controller.dart';

class AirsMissionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AirsMissionController>(() => AirsMissionController());
  }
}
