import 'package:get/get.dart';
import 'limits_0_1_controller.dart';

class Limits01Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Limits01Controller>(() => Limits01Controller());
  }
}
