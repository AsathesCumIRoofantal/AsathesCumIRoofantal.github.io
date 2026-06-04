import 'package:get/get.dart';
import 'rules_regulations_controller.dart';

class RulesRegulationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RulesRegulationsController>(() => RulesRegulationsController());
  }
}
