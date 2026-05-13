import 'package:get/get.dart';
import 'engagements_controller.dart';

class EngagementsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EngagementsController>(() => EngagementsController());
  }
}
