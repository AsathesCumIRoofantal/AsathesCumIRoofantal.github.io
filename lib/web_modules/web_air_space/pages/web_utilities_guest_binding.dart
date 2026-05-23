import 'package:get/get.dart';
import 'web_utilities_guest_controller.dart';

class WebUtilitiesGuestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebUtilitiesGuestController>(
      () => WebUtilitiesGuestController(),
    );
  }
}
