import 'package:get/get.dart';
import 'accountable_controller.dart';

class AccountableBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountableController>(() => AccountableController());
  }
}
