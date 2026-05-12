import 'package:get/get.dart';
import 'managements_controller.dart';

class ManagementsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManagementsController>(() => ManagementsController());
  }
}
