// web_modules/web_setup/web_setup_binding.dart
import 'package:get/get.dart';
import 'web_setup_controller.dart';

class WebSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebSetupController>(() => WebSetupController());
  }
}
