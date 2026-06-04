import 'package:get/get.dart';
import 'process_controller.dart';

class ProcessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProcessController>(() => ProcessController());
  }
}
