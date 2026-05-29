// web_modules/web_home/web_home_binding.dart
import 'package:air_app/web_modules_OLD/web_home/zoom_agora/in_meeting/zoom_meeting_binding.dart';
import 'package:air_app/web_modules_OLD/web_home/zoom_agora/in_meeting/zoom_meeting_controller.dart';
import 'package:get/get.dart';
import 'web_home_controller.dart';

class WebHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebHomeController>(() => WebHomeController());
    // Get.lazyPut(() => ZoomMeetingController());
  }
}
