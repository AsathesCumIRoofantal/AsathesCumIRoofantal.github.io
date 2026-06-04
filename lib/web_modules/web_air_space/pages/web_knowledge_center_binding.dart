import 'package:get/get.dart';
import 'web_knowledge_center_controller.dart';

class WebKnowledgeCenterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WebKnowledgeCenterController());
  }
}
