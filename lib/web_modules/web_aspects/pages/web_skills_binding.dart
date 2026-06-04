import 'package:get/get.dart';
import 'web_skills_controller.dart';

class WebSkillsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebSkillsController>(() => WebSkillsController());
  }
}
