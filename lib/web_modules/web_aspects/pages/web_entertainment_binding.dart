import 'package:get/get.dart';
import 'web_entertainment_controller.dart';

class WebEntertainmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebEntertainmentController>(() => WebEntertainmentController());
  }
}
