import 'package:get/get.dart';
import 'category_tree_controller.dart';

class CategoryTreeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryTreeController>(() => CategoryTreeController());
  }
}
