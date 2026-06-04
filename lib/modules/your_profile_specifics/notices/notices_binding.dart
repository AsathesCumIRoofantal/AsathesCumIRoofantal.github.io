import 'package:get/get.dart';
import 'notices_controller.dart';

class NoticesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NoticesController>(() => NoticesController());
  }
}
