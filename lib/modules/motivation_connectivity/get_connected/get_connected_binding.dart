import 'package:get/get.dart';
import 'get_connected_controller.dart';

class GetConnectedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetConnectedController>(() => GetConnectedController());
  }
}
