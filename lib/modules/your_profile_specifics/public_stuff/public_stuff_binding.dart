import 'package:get/get.dart';
import 'public_stuff_controller.dart';

class PublicStuffBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PublicStuffController>(() => PublicStuffController());
  }
}
