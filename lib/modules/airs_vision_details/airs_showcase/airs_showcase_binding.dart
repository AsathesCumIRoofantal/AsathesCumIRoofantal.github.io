import 'package:get/get.dart';
import 'airs_showcase_controller.dart';

class AirsShowcaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AirsShowcaseController>(() => AirsShowcaseController());
  }
}
