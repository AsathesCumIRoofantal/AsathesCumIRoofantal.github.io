import 'package:get/get.dart';
import 'share_experience_controller.dart';

class ShareExperienceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShareExperienceController>(
      () => ShareExperienceController(),
    );
  }
}
