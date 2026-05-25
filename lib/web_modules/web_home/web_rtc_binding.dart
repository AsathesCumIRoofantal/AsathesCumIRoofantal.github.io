import 'package:get/get.dart';

import 'web_rtc_controller.dart';

class WebRTCBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(WebRtcController());
  }
}
