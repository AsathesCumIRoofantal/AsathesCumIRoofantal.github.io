import 'package:get/get.dart';
import 'web_appeals_controller.dart';

class WebAppealsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebAppealsController>(() => WebAppealsController());
  }
}
