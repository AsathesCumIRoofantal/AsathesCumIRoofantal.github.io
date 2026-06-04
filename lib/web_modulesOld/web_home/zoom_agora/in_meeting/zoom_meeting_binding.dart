import 'package:get/get.dart';
import 'zoom_meeting_controller.dart';
class ZoomMeetingBinding extends Bindings {
  @override void dependencies() => Get.lazyPut(() => ZoomMeetingController());
}
