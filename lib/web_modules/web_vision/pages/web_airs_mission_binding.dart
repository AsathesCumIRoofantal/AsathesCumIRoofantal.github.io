import 'package:get/get.dart';
import 'web_airs_mission_controller.dart';
class WebAirsMissionBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<WebAirsMissionController>(() => WebAirsMissionController());
}
