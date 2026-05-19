import 'package:get/get.dart';
import 'web_category_tree_controller.dart';

class WebCategoryTreeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WebCategoryTreeController());
  }
}
