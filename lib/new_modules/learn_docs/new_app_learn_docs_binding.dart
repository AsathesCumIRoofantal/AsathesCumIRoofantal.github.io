import 'package:get/get.dart';
import 'new_app_learn_docs_controller.dart';

class NewAppLearnDocsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewAppLearnDocsController>(() => NewAppLearnDocsController());
  }
}
