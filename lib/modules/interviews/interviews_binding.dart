import 'package:get/get.dart';
import 'interviews_controller.dart';

class InterviewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InterviewsController>(() => InterviewsController());
  }
}
