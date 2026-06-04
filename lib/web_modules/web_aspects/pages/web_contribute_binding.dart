import 'package:get/get.dart';
import 'web_contribute_controller.dart';

class WebContributeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebContributeController>(() => WebContributeController());
  }
}
