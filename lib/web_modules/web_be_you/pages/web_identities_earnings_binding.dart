import 'package:air_app/web_modules/web_be_you/pages/web_identities_earnings_controller.dart';
import 'package:get/get.dart';

class WebIdentitiesEarningsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebIdentitiesEarningsController>(
      () => WebIdentitiesEarningsController(),
    );
  }
}
