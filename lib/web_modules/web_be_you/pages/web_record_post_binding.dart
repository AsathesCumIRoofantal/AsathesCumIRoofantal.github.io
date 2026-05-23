import 'package:get/get.dart';
import 'web_record_post_controller.dart';
class WebRecordPostBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<WebRecordPostController>(() => WebRecordPostController());
}
