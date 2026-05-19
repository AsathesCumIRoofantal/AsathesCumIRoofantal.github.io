import 'package:get/get.dart';
import 'web_get_connected_controller.dart';

class WebGetConnectedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WebGetConnectedController());
  }
}
