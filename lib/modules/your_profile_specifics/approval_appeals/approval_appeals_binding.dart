import 'package:get/get.dart';
import 'approval_appeals_controller.dart';

class ApprovalAppealsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApprovalAppealsController>(() => ApprovalAppealsController());
  }
}
