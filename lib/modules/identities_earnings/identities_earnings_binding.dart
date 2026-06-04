import 'package:get/get.dart';
import 'identities_earnings_controller.dart';

class IdentitiesEarningsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IdentitiesEarningsController>(
      () => IdentitiesEarningsController(),
    );
  }
}
