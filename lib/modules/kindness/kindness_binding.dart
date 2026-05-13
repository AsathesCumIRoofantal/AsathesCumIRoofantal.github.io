import 'package:get/get.dart';
import 'kindness_controller.dart';

class KindnessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KindnessController>(() => KindnessController());
  }
}
