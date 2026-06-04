import 'package:get/get.dart';
import 'web_setup_master_controller.dart';

class WebSetupMasterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WebSetupMasterController());
  }
}
