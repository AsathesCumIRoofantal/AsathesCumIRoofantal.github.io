import 'package:get/get.dart';
import 'punctuality_controller.dart';

class PunctualityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PunctualityController>(() => PunctualityController());
  }
}
