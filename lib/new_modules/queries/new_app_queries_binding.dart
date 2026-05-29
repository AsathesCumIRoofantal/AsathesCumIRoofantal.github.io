import 'package:get/get.dart';
import 'new_app_queries_controller.dart';

class NewAppQueriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewAppQueriesController>(() => NewAppQueriesController());
  }
}
