import 'package:get/get.dart';
import 'category_docs_controller.dart';

class CategoryDocsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryDocsController());
  }
}
