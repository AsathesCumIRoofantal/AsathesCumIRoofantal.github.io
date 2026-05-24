import 'package:get/get.dart';
import 'web_practice_controller.dart';

class WebPracticeBinding extends Bindings {
  @override
  void dependencies() =>
      Get.lazyPut<WebPracticeController>(() => WebPracticeController());
}
