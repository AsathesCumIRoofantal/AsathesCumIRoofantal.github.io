import 'package:get/get.dart';
import 'script_strategy_controller.dart';

class ScriptStrategyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScriptStrategyController>(() => ScriptStrategyController());
  }
}
