import 'package:get/get.dart';
import 'web_process_controller.dart';

class WebProcessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WebProcessController());
  }
}
