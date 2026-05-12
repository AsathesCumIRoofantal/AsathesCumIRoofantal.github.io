import 'package:get/get.dart';
import 'practice_expertise_controller.dart';

class PracticeExpertiseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PracticeExpertiseController>(() => PracticeExpertiseController());
  }
}
