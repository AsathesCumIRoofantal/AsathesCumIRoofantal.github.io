import 'package:get/get.dart';
import 'only_one_way_controller.dart';

class OnlyOneWayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnlyOneWayController>(() => OnlyOneWayController());
  }
}
