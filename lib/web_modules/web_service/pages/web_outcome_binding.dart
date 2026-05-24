import 'package:get/get.dart';
import 'web_outcome_controller.dart';

class WebOutcomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebOutcomeController>(() => WebOutcomeController());
  }
}
