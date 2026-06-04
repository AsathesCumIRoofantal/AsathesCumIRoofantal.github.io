import 'package:get/get.dart';
import 'respect_controller.dart';

class RespectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RespectController>(() => RespectController());
  }
}
