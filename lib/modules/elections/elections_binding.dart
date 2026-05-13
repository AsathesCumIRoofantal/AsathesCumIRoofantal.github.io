import 'package:get/get.dart';
import 'elections_controller.dart';

class ElectionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ElectionsController>(() => ElectionsController());
  }
}
