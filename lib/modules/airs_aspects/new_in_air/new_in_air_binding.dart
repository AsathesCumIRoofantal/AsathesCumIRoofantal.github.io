import 'package:get/get.dart';
import 'new_in_air_controller.dart';

class NewInAirBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewInAirController>(() => NewInAirController());
  }
}
