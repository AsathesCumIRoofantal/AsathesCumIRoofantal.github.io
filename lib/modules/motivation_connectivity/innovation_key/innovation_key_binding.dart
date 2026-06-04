import 'package:get/get.dart';
import 'innovation_key_controller.dart';

class InnovationKeyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InnovationKeyController>(() => InnovationKeyController());
  }
}
