import 'package:get/get.dart';
import 'package:air_app/web_modules/web_home/livekit_rtc_controller.dart';

class LivekitRtcBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LiveRtcController(), permanent: true);
  }
}
