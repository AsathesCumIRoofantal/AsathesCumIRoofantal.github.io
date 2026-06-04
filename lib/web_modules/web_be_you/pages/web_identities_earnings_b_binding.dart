import 'package:get/get.dart';
import 'web_identities_earnings_b_controller.dart';

class WebIdentitiesEarningsBBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebIdentitiesEarningsBController>(
      () => WebIdentitiesEarningsBController(),
    );
  }
}
