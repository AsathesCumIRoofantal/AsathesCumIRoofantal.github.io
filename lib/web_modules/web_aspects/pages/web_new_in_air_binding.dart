import 'package:get/get.dart';
import 'web_new_in_air_controller.dart';

class WebNewInAirBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebNewInAirController>(() => WebNewInAirController());
  }
}
