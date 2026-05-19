import 'package:get/get.dart';
import 'web_app_setting_controller.dart';

class WebAppSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WebAppSettingController());
  }
}
