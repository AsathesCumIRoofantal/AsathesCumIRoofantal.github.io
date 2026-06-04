import 'package:get/get.dart';
import 'web_network_apis_controller.dart';

class WebNetworkApisBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebNetworkApisController>(() => WebNetworkApisController());
  }
}
