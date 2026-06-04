import 'package:get/get.dart';
import 'query_discussion_controller.dart';

class QueryDiscussionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QueryDiscussionController>(
      () => QueryDiscussionController(),
    );
  }
}
