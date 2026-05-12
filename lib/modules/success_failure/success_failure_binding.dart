import 'package:get/get.dart';
import 'success_failure_controller.dart';
class SuccessFailureBinding extends Bindings {
  @override void dependencies() => Get.lazyPut(() => SuccessFailureController());
}
