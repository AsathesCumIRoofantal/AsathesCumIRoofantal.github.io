import 'package:get/get.dart';
import 'live_fullest_controller.dart';

class LiveFullestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LiveFullestController>(() => LiveFullestController());
  }
}
