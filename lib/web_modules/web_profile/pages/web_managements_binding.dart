import 'package:get/get.dart';
import 'web_managements_controller.dart';

class WebManagementsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebManagementsController>(() => WebManagementsController());
  }
}
