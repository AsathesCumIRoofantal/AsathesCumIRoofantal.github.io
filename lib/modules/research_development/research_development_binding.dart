import 'package:get/get.dart';
import 'research_development_controller.dart';

class ResearchDevelopmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResearchDevelopmentController>(() => ResearchDevelopmentController());
  }
}
