import 'package:get/get.dart';

import 'counting_reports_controller.dart';

class CountingReportsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CountingReportsController>(() => CountingReportsController());
  }
}
