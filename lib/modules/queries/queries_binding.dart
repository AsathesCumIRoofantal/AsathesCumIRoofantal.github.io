import 'package:get/get.dart';
import 'queries_controller.dart';

class QueriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QueriesController());
  }
}
