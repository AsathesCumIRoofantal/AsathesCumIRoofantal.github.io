import 'package:get/get.dart';
import 'court_cases_controller.dart';

class CourtCasesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CourtCasesController>(() => CourtCasesController());
  }
}
