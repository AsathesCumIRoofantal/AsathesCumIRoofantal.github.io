import 'package:air_app/web_modules_OLD/web_home/agora_rtc_controller.dart';
import 'package:get/get.dart';

class AgoraBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AgoraRtcController(), permanent: true);
  }
}
