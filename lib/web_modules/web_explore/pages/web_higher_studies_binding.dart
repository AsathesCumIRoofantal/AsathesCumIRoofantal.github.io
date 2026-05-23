import 'package:get/get.dart';
import 'web_higher_studies_controller.dart';

class WebHigherStudiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebHigherStudiesController>(
      () => WebHigherStudiesController(),
    );
  }
}
