import 'package:get/get.dart';
import 'web_unison_controller.dart';

class WebUnisonBinding extends Bindings {
  @override
  void dependencies() =>
      Get.lazyPut<WebUnisonController>(() => WebUnisonController());
}
