import 'package:get/get.dart';
import 'web_airs_show_case_controller.dart';

class WebAirsShowCaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WebAirsShowCaseController());
  }
}
