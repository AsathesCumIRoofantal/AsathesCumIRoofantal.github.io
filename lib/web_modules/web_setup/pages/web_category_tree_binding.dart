import 'package:get/get.dart';
import '../shell/web_shell.dart';
import 'web_category_tree_controller.dart';

class WebCategoryTreeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WebCategoryTreeController());
  }
}
