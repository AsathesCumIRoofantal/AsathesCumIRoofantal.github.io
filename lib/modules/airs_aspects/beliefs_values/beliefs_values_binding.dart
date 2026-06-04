import 'package:get/get.dart';
import 'beliefs_values_controller.dart';

class BeliefsValuesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BeliefsValuesController>(() => BeliefsValuesController());
  }
}
