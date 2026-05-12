import 'package:get/get.dart';
import 'outcome_processed_controller.dart';

class OutcomeProcessedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OutcomeProcessedController>(() => OutcomeProcessedController());
  }
}
