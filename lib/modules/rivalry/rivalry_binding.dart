import 'package:get/get.dart';
import 'rivalry_controller.dart';

class RivalryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RivalryController>(() => RivalryController());
  }
}
