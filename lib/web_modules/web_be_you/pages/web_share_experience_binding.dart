import 'package:get/get.dart';
import 'web_share_experience_controller.dart';

class WebShareExperienceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WebShareExperienceController());
  }
}
