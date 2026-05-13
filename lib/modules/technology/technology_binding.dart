import 'package:get/get.dart';
import 'technology_controller.dart';

class TechnologyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TechnologyController>(() => TechnologyController());
  }
}
