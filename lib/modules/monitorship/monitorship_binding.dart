import 'package:get/get.dart';
import 'monitorship_controller.dart';

class MonitorshipBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MonitorshipController>(() => MonitorshipController());
  }
}
