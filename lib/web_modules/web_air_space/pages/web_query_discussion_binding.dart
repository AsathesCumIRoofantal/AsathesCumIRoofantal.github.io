import 'package:get/get.dart';
import 'web_query_discussion_controller.dart';
class WebQueryDiscussionBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<WebQueryDiscussionController>(() => WebQueryDiscussionController());
}
