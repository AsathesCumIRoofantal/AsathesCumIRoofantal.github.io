import 'package:get/get.dart';
import 'knowledge_center_controller.dart';

class KnowledgeCenterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KnowledgeCenterController>(
      () => KnowledgeCenterController(),
    );
  }
}
