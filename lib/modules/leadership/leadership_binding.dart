import 'package:get/get.dart';
import 'leadership_controller.dart';

class LeadershipBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeadershipController>(() => LeadershipController());
  }
}
