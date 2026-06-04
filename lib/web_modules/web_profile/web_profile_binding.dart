// web_modules/web_profile/web_profile_binding.dart
import 'package:get/get.dart';
import 'web_profile_controller.dart';

class WebProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebProfileController>(() => WebProfileController());
  }
}
