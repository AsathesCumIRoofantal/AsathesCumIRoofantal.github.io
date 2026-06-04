import 'package:get/get.dart';
import 'media_news_controller.dart';

class MediaNewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MediaNewsController>(() => MediaNewsController());
  }
}
