import 'package:get/get.dart';

import 'web_wisdom_b_controller.dart';

class WebWisdomBBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebWisdomBController>(() => WebWisdomBController());
  }
}
