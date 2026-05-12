import 'package:get/get.dart';
import 'timeline_of_air_controller.dart';

class TimelineOfAirBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TimelineOfAirController>(() => TimelineOfAirController());
  }
}
