import 'package:get/get.dart';
import 'vocabulary_controller.dart';

class VocabularyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VocabularyController>(() => VocabularyController());
  }
}
