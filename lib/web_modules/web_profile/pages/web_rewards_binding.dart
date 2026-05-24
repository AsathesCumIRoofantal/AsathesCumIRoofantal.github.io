import 'package:get/get.dart';
import 'web_rewards_controller.dart';

class WebRewardsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebRewardsController>(() => WebRewardsController());
  }
}
