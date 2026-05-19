// web_modules/web_explore/web_explore_binding.dart
import 'package:get/get.dart';
import 'web_explore_controller.dart';

class WebExploreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebExploreController>(() => WebExploreController());
  }
}
