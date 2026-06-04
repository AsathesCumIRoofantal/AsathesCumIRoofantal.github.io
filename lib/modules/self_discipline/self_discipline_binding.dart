import 'package:get/get.dart';
import 'self_discipline_controller.dart';

class SelfDisciplineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelfDisciplineController>(() => SelfDisciplineController());
  }
}
