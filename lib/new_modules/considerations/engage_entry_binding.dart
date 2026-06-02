import 'package:get/get.dart';
import 'engage_entry_controller.dart';

class EngageEntryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EngageEntryController>(() => EngageEntryController());
  }
}
