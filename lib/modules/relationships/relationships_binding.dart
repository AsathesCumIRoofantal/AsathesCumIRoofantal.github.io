import 'package:get/get.dart';
import 'relationships_controller.dart';

class RelationshipsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RelationshipsController>(() => RelationshipsController());
  }
}
