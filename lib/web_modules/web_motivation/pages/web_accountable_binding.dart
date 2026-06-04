import 'package:get/get.dart';
import 'web_accountable_controller.dart';

class WebAccountableBinding extends Bindings {
  @override
  void dependencies() =>
      Get.lazyPut<WebAccountableController>(() => WebAccountableController());
}
