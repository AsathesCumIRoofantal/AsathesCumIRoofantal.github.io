import 'package:get/get.dart';
import 'merits_demerits_controller.dart';

class MeritsDemeritsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MeritsDemeritsController>(() => MeritsDemeritsController());
  }
}
