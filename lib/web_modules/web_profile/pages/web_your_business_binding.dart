import 'package:get/get.dart';
import 'web_your_business_controller.dart';

class WebYourBusinessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebYourBusinessController>(() => WebYourBusinessController());
  }
}
