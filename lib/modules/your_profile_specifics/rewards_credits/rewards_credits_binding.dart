import 'package:get/get.dart';
import 'rewards_credits_controller.dart';

class RewardsCreditsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RewardsCreditsController>(() => RewardsCreditsController());
  }
}
