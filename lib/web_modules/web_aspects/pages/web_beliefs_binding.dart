import 'package:get/get.dart';
import 'web_beliefs_controller.dart';

class WebBeliefsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebBeliefsController>(() => WebBeliefsController());
  }
}
