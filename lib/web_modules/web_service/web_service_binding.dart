// web_modules/web_service/web_service_binding.dart
import 'package:get/get.dart';
import 'web_service_controller.dart';

class WebServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebServiceController>(() => WebServiceController());
  }
}
