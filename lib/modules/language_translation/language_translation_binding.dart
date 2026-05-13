import 'package:get/get.dart';
import 'language_translation_controller.dart';

class LanguageTranslationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LanguageTranslationController>(() => LanguageTranslationController());
  }
}
