import 'package:get/get.dart';
import 'group_discussions_controller.dart';

class GroupDiscussionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GroupDiscussionsController>(() => GroupDiscussionsController());
  }
}
