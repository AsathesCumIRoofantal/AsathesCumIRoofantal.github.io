import 'package:get/get.dart';
import 'resume_tour_controller.dart';

class ResumeTourBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResumeTourController>(() => ResumeTourController());
  }
}
