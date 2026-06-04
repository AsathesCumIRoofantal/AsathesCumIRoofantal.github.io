import 'package:get/get.dart';
import 'web_timeline_of_air_controller.dart';

class WebTimelineOfAirBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WebTimelineOfAirController());
  }
}
