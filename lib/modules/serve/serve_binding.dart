import 'package:get/get.dart';
import 'serve_controller.dart';

class ServeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServeController>(() => ServeController());
  }
}
