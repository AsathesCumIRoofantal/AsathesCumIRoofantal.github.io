import 'package:get/get.dart';
import 'web_sharecare_controller.dart';

class WebShareCareBinding extends Bindings {
  @override
  void dependencies() =>
      Get.lazyPut<WebShareCareController>(() => WebShareCareController());
}
