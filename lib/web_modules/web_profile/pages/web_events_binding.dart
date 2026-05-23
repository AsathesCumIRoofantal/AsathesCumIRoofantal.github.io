import 'package:get/get.dart';
import 'web_events_controller.dart';
class WebEventsBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<WebEventsController>(() => WebEventsController());
}
