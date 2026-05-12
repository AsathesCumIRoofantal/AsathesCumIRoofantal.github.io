import 'package:get/get.dart';
import 'pick_good_going_controller.dart';

class PickGoodGoingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PickGoodGoingController>(() => PickGoodGoingController());
  }
}
