import 'package:get/get.dart';
import 'appreciations_thanks_controller.dart';

class AppreciationsThanksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppreciationsThanksController>(() => AppreciationsThanksController());
  }
}
