import 'package:get/get.dart';
import 'new_app_learn_fun_controller.dart';

class NewAppLearnFunBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewAppLearnFunController>(() => NewAppLearnFunController());
  }
}
