import 'package:get/get.dart';
import 'web_identities_earnings_controller.dart';

class WebIdentitiesEarningsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebIdentitiesEarningsController>(
      () => WebIdentitiesEarningsController(),
    );
  }
}
