import 'package:get/get.dart';
import 'be_part_of_air_controller.dart';

class BePartOfAirBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BePartOfAirController>(() => BePartOfAirController());
  }
}
