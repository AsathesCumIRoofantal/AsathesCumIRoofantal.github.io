import 'package:get/get.dart';
import 'commerce_controller.dart';

class CommerceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommerceController>(() => CommerceController());
  }
}
