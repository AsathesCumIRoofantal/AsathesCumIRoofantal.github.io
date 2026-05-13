import 'package:air_app/modules/Counting Reports- Both Hindi & English/counting_reports_controller.dart';
import 'package:get/get.dart';

class CountingReportsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CountingReportsController>(() => CountingReportsController());
  }
}
