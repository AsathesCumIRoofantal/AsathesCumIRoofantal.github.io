import 'package:get/get.dart';
import 'network_apis_controller.dart';

class NetworkApisBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NetworkApisController>(() => NetworkApisController());
  }
}
