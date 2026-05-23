import 'package:get/get.dart';
import 'web_learn_docs_controller.dart';

class WebLearnDocsBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<WebLearnDocsController>(() => WebLearnDocsController());
}
