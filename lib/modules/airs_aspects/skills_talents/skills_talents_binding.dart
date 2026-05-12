import 'package:get/get.dart';
import 'skills_talents_controller.dart';

class SkillsTalentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SkillsTalentsController>(() => SkillsTalentsController());
  }
}
