import 'package:get/get.dart';
import 'digitalize_records_controller.dart';

class DigitalizeRecordsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DigitalizeRecordsController>(() => DigitalizeRecordsController());
  }
}
