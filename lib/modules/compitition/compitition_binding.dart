import 'package:get/get.dart';
import 'compitition_controller.dart';

class CompititionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompititionController>(() => CompititionController());
  }
}
