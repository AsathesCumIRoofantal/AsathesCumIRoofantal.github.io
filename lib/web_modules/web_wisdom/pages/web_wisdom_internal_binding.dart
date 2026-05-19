import 'package:get/get.dart';
import 'web_wisdom_internal_controller.dart';

class WebWisdomInternalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WebWisdomInternalController());
  }
}
