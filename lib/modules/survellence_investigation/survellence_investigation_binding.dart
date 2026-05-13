import 'package:get/get.dart';
import 'survellence_investigation_controller.dart';

class SurvellenceInvestigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SurvellenceInvestigationController>(() => SurvellenceInvestigationController());
  }
}
