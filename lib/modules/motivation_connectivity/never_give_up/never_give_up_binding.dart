import 'package:get/get.dart';
import 'never_give_up_controller.dart';

class NeverGiveUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NeverGiveUpController>(() => NeverGiveUpController());
  }
}
