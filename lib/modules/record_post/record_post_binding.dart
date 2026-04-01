import 'package:get/get.dart';
import 'record_post_controller.dart';

class RecordPostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecordPostController>(
      () => RecordPostController(),
    );
  }
}
