import 'package:get/get.dart';
import 'follow_calendar_controller.dart';

class FollowCalendarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FollowCalendarController>(() => FollowCalendarController());
  }
}
