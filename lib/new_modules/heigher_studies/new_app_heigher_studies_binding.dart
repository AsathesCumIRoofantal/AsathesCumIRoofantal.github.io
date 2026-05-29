import 'package:get/get.dart';
import 'new_app_heigher_studies_controller.dart';

class NewAppHeigherStudiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewAppHeigherStudiesController>(() => NewAppHeigherStudiesController());
  }
}
