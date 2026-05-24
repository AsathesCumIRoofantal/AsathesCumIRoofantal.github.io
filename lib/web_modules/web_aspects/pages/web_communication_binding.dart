import 'package:get/get.dart';
import 'web_communication_controller.dart';

class WebCommunicationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebCommunicationController>(() => WebCommunicationController());
  }
}
