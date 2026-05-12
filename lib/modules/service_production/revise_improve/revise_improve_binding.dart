import 'package:get/get.dart';
import 'revise_improve_controller.dart';

class ReviseImproveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviseImproveController>(() => ReviseImproveController());
  }
}
