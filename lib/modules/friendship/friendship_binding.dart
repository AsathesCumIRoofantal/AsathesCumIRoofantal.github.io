import 'package:get/get.dart';
import 'friendship_controller.dart';

class FriendshipBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FriendshipController>(() => FriendshipController());
  }
}
