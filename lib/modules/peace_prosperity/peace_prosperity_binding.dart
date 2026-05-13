import 'package:get/get.dart';
import 'peace_prosperity_controller.dart';

class PeaceProsperityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PeaceProsperityController>(() => PeaceProsperityController());
  }
}
