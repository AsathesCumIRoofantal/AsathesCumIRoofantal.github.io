import 'package:get/get.dart';
import 'demonstration_controller.dart';

class DemonstrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DemonstrationController>(() => DemonstrationController());
  }
}
