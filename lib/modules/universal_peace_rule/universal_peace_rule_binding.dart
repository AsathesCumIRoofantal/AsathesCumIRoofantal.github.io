import 'package:get/get.dart';
import 'universal_peace_rule_controller.dart';

class UniversalPeaceRuleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UniversalPeaceRuleController>(() => UniversalPeaceRuleController());
  }
}
