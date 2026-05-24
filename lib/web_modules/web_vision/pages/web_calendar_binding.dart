import 'package:get/get.dart';
import 'web_calendar_controller.dart';

class WebCalendarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebCalendarController>(() => WebCalendarController());
  }
}
