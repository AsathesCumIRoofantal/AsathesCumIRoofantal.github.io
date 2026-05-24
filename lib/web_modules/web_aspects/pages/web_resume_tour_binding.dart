import 'package:get/get.dart';
import 'web_resume_tour_controller.dart';

class WebResumeTourBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebResumeTourController>(() => WebResumeTourController());
  }
}
