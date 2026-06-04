import 'package:get/get.dart';
import 'web_maintenance_controller.dart';

class WebMaintenanceBinding extends Bindings {
  @override
  void dependencies() {
    // lazyPut prevents memory leaks per Handbook Section 4
    Get.lazyPut<WebMaintenanceController>(() => WebMaintenanceController());
  }
}
